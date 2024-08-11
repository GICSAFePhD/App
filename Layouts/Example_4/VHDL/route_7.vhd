--  route_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R8 ['D09', 'D20', 'D21'] 
--dw  R8 [] 
--sc  R8 [] 
--lc  R8 [] 
	entity route_7 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne465 : in hex_char;
			ne465_command : out routeCommands := RELEASE;
			track_ne131 : in hex_char;
			ne131_command : out routeCommands := RELEASE;
			track_ne912 : in hex_char;
			ne912_command : out routeCommands := RELEASE;
			D09_state : in hex_char;
			D09_command : out routeCommands := RELEASE;
			D20_state : in hex_char;
			D20_command : out routeCommands := RELEASE;
			D21_state : in hex_char;
			D21_command : out routeCommands := RELEASE;
			T10_state : in hex_char;
			T10_command : out routeCommands := RELEASE;
			J45_state : in hex_char;
			J45_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_7;
architecture Behavioral of route_7 is
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
	signal ne465_used , ne131_used , ne912_used : std_logic := '0';
	signal ne465_state : nodeStates := FREE;
	signal ne465_lock : objectLock := RELEASED;
	signal ne131_state : nodeStates := FREE;
	signal ne131_lock : objectLock := RELEASED;
	signal ne912_state : nodeStates := FREE;
	signal ne912_lock : objectLock := RELEASED;
	signal D09_position : singleSwitchStates := NORMAL;
	signal D09_lock : objectLock := RELEASED;
	signal D20_position : singleSwitchStates := NORMAL;
	signal D20_lock : objectLock := RELEASED;
	signal D21_position : singleSwitchStates := NORMAL;
	signal D21_lock : objectLock := RELEASED;
	signal T10_aspectIn : signalStates := RED;
	signal T10_lock: objectLock := RELEASED;
	signal J45_aspectIn : signalStates := RED;
	signal J45_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne465_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne465)(2 to 3))));
	ne465_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne465)(0 to 1))));
	ne131_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne131)(2 to 3))));
	ne131_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne131)(0 to 1))));
	ne912_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne912)(2 to 3))));
	ne912_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne912)(0 to 1))));
	D09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D09_state)(2 to 3))));
	D09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D09_state)(0 to 1))));
	D20_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D20_state)(2 to 3))));
	D20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D20_state)(0 to 1))));
	D21_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D21_state)(2 to 3))));
	D21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D21_state)(0 to 1))));
	T10_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T10_state)(2 to 3))));
	T10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T10_state)(0 to 1))));
	J45_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J45_state)(2 to 3))));
	J45_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J45_state)(0 to 1))));
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
				if ((ne465_lock = RELEASED and ne131_lock = RELEASED and ne912_lock = RELEASED) and (ne131_state = FREE and ne912_state = FREE)) then
					ne465_command <= RESERVE;
					ne131_command <= RESERVE;
					ne912_command <= RESERVE;
				end if;
				if (ne465_lock = RESERVED and ne131_lock = RESERVED and ne912_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne465_lock = RESERVED and ne131_lock = RESERVED and ne912_lock = RESERVED) and (ne131_state = FREE and ne912_state = FREE)) then
					ne465_command <= LOCK;
					ne131_command <= LOCK;
					ne912_command <= LOCK;
				end if;
				if (ne465_lock = LOCKED and ne131_lock = LOCKED and ne912_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D09_lock = RELEASED and D20_lock = RELEASED and D21_lock = RELEASED) then
					D09_command <= RESERVE;
					D20_command <= RESERVE;
					D21_command <= RESERVE;
				end if;
				if (D09_lock = RESERVED and D20_lock = RESERVED and D21_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D09_lock = RESERVED and D20_lock = RESERVED and D21_lock = RESERVED) then
					D09_command <= LOCK;
					D20_command <= LOCK;
					D21_command <= LOCK;
				end if;
				if (D09_lock = LOCKED and D20_lock = LOCKED and D21_lock = LOCKED)then
					ne465_used <= '0';
					ne131_used <= '0';
					ne912_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T10_lock = RELEASED and J45_lock = RELEASED) then
					T10_command <= RESERVE;
					J45_command <= LOCK;
				end if;
				if (T10_lock = RESERVED and J45_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne465_used = '0' and ne465_state = OCCUPIED) then 
					ne465_used <= '1';
				end if;
				if (ne465_used = '1' and ne465_state = FREE) then
					ne465_used <= '0';
					ne465_command <= RELEASE;
				end if;
					---
				if (ne465_lock = RELEASED and ne131_used = '0' and ne131_state = OCCUPIED) then 
					ne131_used <= '1';
				end if;
				if (ne131_used = '1' and ne131_state = FREE) then
					ne131_used <= '0';
					ne131_command <= RELEASE;
				end if;
					---
				if (ne131_lock = RELEASED and ne912_used = '0' and ne912_state = OCCUPIED) then 
					ne912_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D09_command <= RELEASE;
				D20_command <= RELEASE;
				D21_command <= RELEASE;
				ne465_command <= RELEASE;
				ne131_command <= RELEASE;
				ne912_command <= RELEASE;
				T10_command <= RELEASE;
				J45_command <= RELEASE;
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