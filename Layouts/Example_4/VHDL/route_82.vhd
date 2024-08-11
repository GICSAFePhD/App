--  route_82.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R83 ['Sw05'] 
--dw  R83 [] 
--sc  R83 [] 
--lc  R83 [] 
	entity route_82 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne400 : in hex_char;
			ne400_command : out routeCommands := RELEASE;
			track_ne993 : in hex_char;
			ne993_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			S123_state : in hex_char;
			S123_command : out routeCommands := RELEASE;
			T25_state : in hex_char;
			T25_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_82;
architecture Behavioral of route_82 is
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
	signal ne400_used , ne993_used : std_logic := '0';
	signal ne400_state : nodeStates := FREE;
	signal ne400_lock : objectLock := RELEASED;
	signal ne993_state : nodeStates := FREE;
	signal ne993_lock : objectLock := RELEASED;
	signal Sw05_position : singleSwitchStates := NORMAL;
	signal Sw05_lock : objectLock := RELEASED;
	signal S123_aspectIn : signalStates := RED;
	signal S123_lock: objectLock := RELEASED;
	signal T25_aspectIn : signalStates := RED;
	signal T25_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne400_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne400)(2 to 3))));
	ne400_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne400)(0 to 1))));
	ne993_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne993)(2 to 3))));
	ne993_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne993)(0 to 1))));
	Sw05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	S123_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S123_state)(2 to 3))));
	S123_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S123_state)(0 to 1))));
	T25_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T25_state)(2 to 3))));
	T25_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T25_state)(0 to 1))));
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
				if ((ne400_lock = RELEASED and ne993_lock = RELEASED) and (ne993_state = FREE)) then
					ne400_command <= RESERVE;
					ne993_command <= RESERVE;
				end if;
				if (ne400_lock = RESERVED and ne993_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne400_lock = RESERVED and ne993_lock = RESERVED) and (ne993_state = FREE)) then
					ne400_command <= LOCK;
					ne993_command <= LOCK;
				end if;
				if (ne400_lock = LOCKED and ne993_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw05_lock = RELEASED) then
					Sw05_command <= RESERVE;
				end if;
				if (Sw05_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw05_lock = RESERVED) then
					Sw05_command <= LOCK;
				end if;
				if (Sw05_lock = LOCKED)then
					ne400_used <= '0';
					ne993_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S123_lock = RELEASED and T25_lock = RELEASED) then
					S123_command <= RESERVE;
					T25_command <= LOCK;
				end if;
				if (S123_lock = RESERVED and T25_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne400_used = '0' and ne400_state = OCCUPIED) then 
					ne400_used <= '1';
				end if;
				if (ne400_used = '1' and ne400_state = FREE) then
					ne400_used <= '0';
					ne400_command <= RELEASE;
				end if;
					---
				if (ne400_lock = RELEASED and ne993_used = '0' and ne993_state = OCCUPIED) then 
					ne993_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw05_command <= RELEASE;
				ne400_command <= RELEASE;
				ne993_command <= RELEASE;
				S123_command <= RELEASE;
				T25_command <= RELEASE;
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