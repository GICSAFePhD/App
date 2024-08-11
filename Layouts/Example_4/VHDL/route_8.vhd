--  route_8.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R9 ['D21'] 
--dw  R9 [] 
--sc  R9 [] 
--lc  R9 [] 
	entity route_8 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne465 : in hex_char;
			ne465_command : out routeCommands := RELEASE;
			track_ne133 : in hex_char;
			ne133_command : out routeCommands := RELEASE;
			D21_state : in hex_char;
			D21_command : out routeCommands := RELEASE;
			T10_state : in hex_char;
			T10_command : out routeCommands := RELEASE;
			T21_state : in hex_char;
			T21_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_8;
architecture Behavioral of route_8 is
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
	signal ne465_used , ne133_used : std_logic := '0';
	signal ne465_state : nodeStates := FREE;
	signal ne465_lock : objectLock := RELEASED;
	signal ne133_state : nodeStates := FREE;
	signal ne133_lock : objectLock := RELEASED;
	signal D21_position : singleSwitchStates := NORMAL;
	signal D21_lock : objectLock := RELEASED;
	signal T10_aspectIn : signalStates := RED;
	signal T10_lock: objectLock := RELEASED;
	signal T21_aspectIn : signalStates := RED;
	signal T21_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne465_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne465)(2 to 3))));
	ne465_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne465)(0 to 1))));
	ne133_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne133)(2 to 3))));
	ne133_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne133)(0 to 1))));
	D21_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D21_state)(2 to 3))));
	D21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D21_state)(0 to 1))));
	T10_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T10_state)(2 to 3))));
	T10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T10_state)(0 to 1))));
	T21_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T21_state)(2 to 3))));
	T21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T21_state)(0 to 1))));
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
				if ((ne465_lock = RELEASED and ne133_lock = RELEASED) and (ne133_state = FREE)) then
					ne465_command <= RESERVE;
					ne133_command <= RESERVE;
				end if;
				if (ne465_lock = RESERVED and ne133_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne465_lock = RESERVED and ne133_lock = RESERVED) and (ne133_state = FREE)) then
					ne465_command <= LOCK;
					ne133_command <= LOCK;
				end if;
				if (ne465_lock = LOCKED and ne133_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D21_lock = RELEASED) then
					D21_command <= RESERVE;
				end if;
				if (D21_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D21_lock = RESERVED) then
					D21_command <= LOCK;
				end if;
				if (D21_lock = LOCKED)then
					ne465_used <= '0';
					ne133_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T10_lock = RELEASED and T21_lock = RELEASED) then
					T10_command <= RESERVE;
					T21_command <= LOCK;
				end if;
				if (T10_lock = RESERVED and T21_lock = LOCKED) then
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
				if (ne465_lock = RELEASED and ne133_used = '0' and ne133_state = OCCUPIED) then 
					ne133_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D21_command <= RELEASE;
				ne465_command <= RELEASE;
				ne133_command <= RELEASE;
				T10_command <= RELEASE;
				T21_command <= RELEASE;
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