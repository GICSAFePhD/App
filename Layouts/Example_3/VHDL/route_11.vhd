--  route_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R12 [] 
--dw  R12 [] 
--sc  R12 [] 
--lc  R12 [] 
	entity route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne44 : in hex_char;
			ne44_command : out routeCommands := RELEASE;
			track_ne101 : in hex_char;
			ne101_command : out routeCommands := RELEASE;
			L28_state : in hex_char;
			L28_command : out routeCommands := RELEASE;
			L40_state : in hex_char;
			L40_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_11;
architecture Behavioral of route_11 is
	component flipFlop is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			Q : out std_logic := '0'
		);
	end component flipFlop;
	signal restart : std_logic := '1';
	signal Q : std_logic_vector(32 downto 0) := (others => '0');
	signal clock_in : std_logic_vector(32 downto 0) := (others => '0');
	signal timeout : std_logic := '0';
	signal routeState : routeStates := WAITING_COMMAND;
	signal routingIn : routeStates;
	signal ne44_used , ne101_used : std_logic := '0';
	signal ne44_state : nodeStates := FREE;
	signal ne44_lock : objectLock := RELEASED;
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal L28_aspectIn : signalStates := RED;
	signal L28_lock: objectLock := RELEASED;
	signal L40_aspectIn : signalStates := RED;
	signal L40_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne44_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne44)(2 to 3))));
	ne44_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne44)(0 to 1))));
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	L28_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L28_state)(2 to 3))));
	L28_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L28_state)(0 to 1))));
	L40_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L40_state)(2 to 3))));
	L40_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L40_state)(0 to 1))));
	gen : for i in 0 to 31 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "010110010110100000101111000000000") then
			timeout <= '1';
		end if;
		if (restart = '1') then
			timeout <= '0';
		end if;
	end process;

	process(clock)
	begin
	if (clock'Event and clock = '1') then
		case routeState is
			when WAITING_COMMAND =>
				if (routingIn = ROUTE_REQUEST) then
					routeState <= RESERVING_TRACKS;
				end if;
			when RESERVING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne44_lock = RELEASED and ne101_lock = RELEASED) and (ne101_state = FREE)) then
					ne44_command <= RESERVE;
					ne101_command <= RESERVE;
				end if;
				if (ne44_lock = RESERVED and ne101_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne44_lock = RESERVED and ne101_lock = RESERVED) and (ne101_state = FREE)) then
					ne44_command <= LOCK;
					ne101_command <= LOCK;
				end if;
				if (ne44_lock = LOCKED and ne101_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					restart <= '1';
				routeState <= LOCKING_INFRASTRUCTURE;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					ne44_used <= '0';
					ne101_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (L28_lock = RELEASED and L40_lock = RELEASED) then
					L28_command <= RESERVE;
					L40_command <= LOCK;
				end if;
				if (L28_lock = RESERVED and L40_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne44_used = '0' and ne44_state = OCCUPIED) then 
					ne44_used <= '1';
				end if;
				if (ne44_used = '1' and ne44_state = FREE) then
					ne44_used <= '0';
					ne44_command <= RELEASE;
				end if;
					---
				if (ne44_lock = RELEASED and ne101_used = '0' and ne101_state = OCCUPIED) then 
					ne101_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne44_command <= RELEASE;
				ne101_command <= RELEASE;
				L28_command <= RELEASE;
				L40_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;
			when CANCEL_ROUTE =>
				routeState <= RELEASING_INFRASTRUCTURE;
			when others =>
				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;