--  route_15.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R16 ['Sw06'] 
--dw  R16 [] 
--sc  R16 [] 
--lc  R16 ['Lc08'] 
	entity route_15 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne2 : in hex_char;
			ne2_command : out routeCommands := RELEASE;
			track_ne13 : in hex_char;
			ne13_command : out routeCommands := RELEASE;
			Lc08_state : in hex_char;
			Lc08_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			S27_state : in hex_char;
			S27_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_15;
architecture Behavioral of route_15 is
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
	signal ne2_used , ne13_used : std_logic := '0';
	signal ne2_state : nodeStates := FREE;
	signal ne2_lock : objectLock := RELEASED;
	signal ne13_state : nodeStates := FREE;
	signal ne13_lock : objectLock := RELEASED;
	signal Lc08_position : levelCrossingStates := UP;
	signal Lc08_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal S27_aspectIn : signalStates := RED;
	signal S27_lock: objectLock := RELEASED;
	signal T01_aspectIn : signalStates := RED;
	signal T01_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne2_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne2)(2 to 3))));
	ne2_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne2)(0 to 1))));
	ne13_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne13)(2 to 3))));
	ne13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne13)(0 to 1))));
	Lc08_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc08_state)(2 to 3))));
	Lc08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc08_state)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	S27_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S27_state)(2 to 3))));
	S27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S27_state)(0 to 1))));
	T01_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T01_state)(2 to 3))));
	T01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T01_state)(0 to 1))));
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
				if ((ne2_lock = RELEASED and ne13_lock = RELEASED) and (ne13_state = FREE)) then
					ne2_command <= RESERVE;
					ne13_command <= RESERVE;
				end if;
				if (ne2_lock = RESERVED and ne13_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne2_lock = RESERVED and ne13_lock = RESERVED) and (ne13_state = FREE)) then
					ne2_command <= LOCK;
					ne13_command <= LOCK;
				end if;
				if (ne2_lock = LOCKED and ne13_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc08_lock = RELEASED and Sw06_lock = RELEASED) then
					Lc08_command <= RESERVE;
					Sw06_command <= RESERVE;
				end if;
				if (Lc08_lock = RESERVED and Sw06_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc08_lock = RESERVED and Sw06_lock = RESERVED) then
					Lc08_command <= LOCK;
					Sw06_command <= LOCK;
				end if;
				if (Lc08_lock = LOCKED and Sw06_lock = LOCKED)then
					ne2_used <= '0';
					ne13_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S27_lock = RELEASED and T01_lock = RELEASED) then
					S27_command <= RESERVE;
					T01_command <= LOCK;
				end if;
				if (S27_lock = RESERVED and T01_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne2_used = '0' and ne2_state = OCCUPIED) then 
					ne2_used <= '1';
				end if;
				if (ne2_used = '1' and ne2_state = FREE) then
					ne2_used <= '0';
					ne2_command <= RELEASE;
				end if;
					---
				if (ne2_lock = RELEASED and ne13_used = '0' and ne13_state = OCCUPIED) then 
					ne13_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc08_command <= RELEASE;
				Sw06_command <= RELEASE;
				ne2_command <= RELEASE;
				ne13_command <= RELEASE;
				S27_command <= RELEASE;
				T01_command <= RELEASE;
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