--  route_22.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R23 [] 
--dw  R23 [] 
--sc  R23 [] 
--lc  R23 [] 
	entity route_22 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne996 : in hex_char;
			ne996_command : out routeCommands := RELEASE;
			track_ne98 : in hex_char;
			ne98_command : out routeCommands := RELEASE;
			J38_state : in hex_char;
			J38_command : out routeCommands := RELEASE;
			L30_state : in hex_char;
			L30_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_22;
architecture Behavioral of route_22 is
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
	signal ne996_used , ne98_used : std_logic := '0';
	signal ne996_state : nodeStates := FREE;
	signal ne996_lock : objectLock := RELEASED;
	signal ne98_state : nodeStates := FREE;
	signal ne98_lock : objectLock := RELEASED;
	signal J38_aspectIn : signalStates := RED;
	signal J38_lock: objectLock := RELEASED;
	signal L30_aspectIn : signalStates := RED;
	signal L30_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne996_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne996)(2 to 3))));
	ne996_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne996)(0 to 1))));
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne98_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne98)(0 to 1))));
	J38_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J38_state)(2 to 3))));
	J38_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J38_state)(0 to 1))));
	L30_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L30_state)(2 to 3))));
	L30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L30_state)(0 to 1))));
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
				if ((ne996_lock = RELEASED and ne98_lock = RELEASED) and (ne98_state = FREE)) then
					ne996_command <= RESERVE;
					ne98_command <= RESERVE;
				end if;
				if (ne996_lock = RESERVED and ne98_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne996_lock = RESERVED and ne98_lock = RESERVED) and (ne98_state = FREE)) then
					ne996_command <= LOCK;
					ne98_command <= LOCK;
				end if;
				if (ne996_lock = LOCKED and ne98_lock = LOCKED)then
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
					ne996_used <= '0';
					ne98_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (J38_lock = RELEASED and L30_lock = RELEASED) then
					J38_command <= RESERVE;
					L30_command <= LOCK;
				end if;
				if (J38_lock = RESERVED and L30_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne996_used = '0' and ne996_state = OCCUPIED) then 
					ne996_used <= '1';
				end if;
				if (ne996_used = '1' and ne996_state = FREE) then
					ne996_used <= '0';
					ne996_command <= RELEASE;
				end if;
					---
				if (ne996_lock = RELEASED and ne98_used = '0' and ne98_state = OCCUPIED) then 
					ne98_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne996_command <= RELEASE;
				ne98_command <= RELEASE;
				J38_command <= RELEASE;
				L30_command <= RELEASE;
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