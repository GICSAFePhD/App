--  route_14.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R15 [] 
--dw  R15 [] 
--sc  R15 [] 
--lc  R15 [] 
	entity route_14 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne78 : in hex_char;
			ne78_command : out routeCommands := RELEASE;
			track_ne93 : in hex_char;
			ne93_command : out routeCommands := RELEASE;
			L33_state : in hex_char;
			L33_command : out routeCommands := RELEASE;
			L34_state : in hex_char;
			L34_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_14;
architecture Behavioral of route_14 is
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
	signal ne78_used , ne93_used : std_logic := '0';
	signal ne78_state : nodeStates := FREE;
	signal ne78_lock : objectLock := RELEASED;
	signal ne93_state : nodeStates := FREE;
	signal ne93_lock : objectLock := RELEASED;
	signal L33_aspectIn : signalStates := RED;
	signal L33_lock: objectLock := RELEASED;
	signal L34_aspectIn : signalStates := RED;
	signal L34_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne78_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne78)(2 to 3))));
	ne78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne78)(0 to 1))));
	ne93_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne93)(2 to 3))));
	ne93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne93)(0 to 1))));
	L33_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L33_state)(2 to 3))));
	L33_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L33_state)(0 to 1))));
	L34_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L34_state)(2 to 3))));
	L34_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L34_state)(0 to 1))));
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
				if ((ne78_lock = RELEASED and ne93_lock = RELEASED) and (ne93_state = FREE)) then
					ne78_command <= RESERVE;
					ne93_command <= RESERVE;
				end if;
				if (ne78_lock = RESERVED and ne93_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne78_lock = RESERVED and ne93_lock = RESERVED) and (ne93_state = FREE)) then
					ne78_command <= LOCK;
					ne93_command <= LOCK;
				end if;
				if (ne78_lock = LOCKED and ne93_lock = LOCKED)then
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
					ne78_used <= '0';
					ne93_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (L33_lock = RELEASED and L34_lock = RELEASED) then
					L33_command <= RESERVE;
					L34_command <= LOCK;
				end if;
				if (L33_lock = RESERVED and L34_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne78_used = '0' and ne78_state = OCCUPIED) then 
					ne78_used <= '1';
				end if;
				if (ne78_used = '1' and ne78_state = FREE) then
					ne78_used <= '0';
					ne78_command <= RELEASE;
				end if;
					---
				if (ne78_lock = RELEASED and ne93_used = '0' and ne93_state = OCCUPIED) then 
					ne93_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne78_command <= RELEASE;
				ne93_command <= RELEASE;
				L33_command <= RELEASE;
				L34_command <= RELEASE;
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