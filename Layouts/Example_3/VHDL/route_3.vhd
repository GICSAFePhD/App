--  route_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R4 ['71W02'] 
--dw  R4 [] 
--sc  R4 [] 
--lc  R4 [] 
	entity route_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne47 : in hex_char;
			ne47_command : out routeCommands := RELEASE;
			track_ne48 : in hex_char;
			ne48_command : out routeCommands := RELEASE;
			s71W02_state : in hex_char;
			s71W02_command : out routeCommands := RELEASE;
			T12_state : in hex_char;
			T12_command : out routeCommands := RELEASE;
			L29_state : in hex_char;
			L29_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_3;
architecture Behavioral of route_3 is
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
	signal ne47_used , ne48_used : std_logic := '0';
	signal ne47_state : nodeStates := FREE;
	signal ne47_lock : objectLock := RELEASED;
	signal ne48_state : nodeStates := FREE;
	signal ne48_lock : objectLock := RELEASED;
	signal s71W02_position : singleSwitchStates := NORMAL;
	signal s71W02_lock : objectLock := RELEASED;
	signal T12_aspectIn : signalStates := RED;
	signal T12_lock: objectLock := RELEASED;
	signal L29_aspectIn : signalStates := RED;
	signal L29_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne47_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne47)(2 to 3))));
	ne47_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne47)(0 to 1))));
	ne48_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne48)(2 to 3))));
	ne48_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne48)(0 to 1))));
	s71W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s71W02_state)(2 to 3))));
	s71W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s71W02_state)(0 to 1))));
	T12_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T12_state)(2 to 3))));
	T12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T12_state)(0 to 1))));
	L29_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L29_state)(2 to 3))));
	L29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L29_state)(0 to 1))));
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
				if ((ne47_lock = RELEASED and ne48_lock = RELEASED) and (ne48_state = FREE)) then
					ne47_command <= RESERVE;
					ne48_command <= RESERVE;
				end if;
				if (ne47_lock = RESERVED and ne48_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne47_lock = RESERVED and ne48_lock = RESERVED) and (ne48_state = FREE)) then
					ne47_command <= LOCK;
					ne48_command <= LOCK;
				end if;
				if (ne47_lock = LOCKED and ne48_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s71W02_lock = RELEASED) then
					s71W02_command <= RESERVE;
				end if;
				if (s71W02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s71W02_lock = RESERVED) then
					s71W02_command <= LOCK;
				end if;
				if (s71W02_lock = LOCKED)then
					ne47_used <= '0';
					ne48_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T12_lock = RELEASED and L29_lock = RELEASED) then
					T12_command <= RESERVE;
					L29_command <= LOCK;
				end if;
				if (T12_lock = RESERVED and L29_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne47_used = '0' and ne47_state = OCCUPIED) then 
					ne47_used <= '1';
				end if;
				if (ne47_used = '1' and ne47_state = FREE) then
					ne47_used <= '0';
					ne47_command <= RELEASE;
				end if;
					---
				if (ne47_lock = RELEASED and ne48_used = '0' and ne48_state = OCCUPIED) then 
					ne48_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s71W02_command <= RELEASE;
				ne47_command <= RELEASE;
				ne48_command <= RELEASE;
				T12_command <= RELEASE;
				L29_command <= RELEASE;
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