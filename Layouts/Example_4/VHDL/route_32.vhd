--  route_32.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R33 ['Sw01', 'Sw05'] 
--dw  R33 [] 
--sc  R33 [] 
--lc  R33 ['Lc04'] 
	entity route_32 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne100 : in hex_char;
			ne100_command : out routeCommands := RELEASE;
			track_ne992 : in hex_char;
			ne992_command : out routeCommands := RELEASE;
			Lc04_state : in hex_char;
			Lc04_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			X53_state : in hex_char;
			X53_command : out routeCommands := RELEASE;
			S120_state : in hex_char;
			S120_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_32;
architecture Behavioral of route_32 is
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
	signal ne100_used , ne992_used : std_logic := '0';
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal ne992_state : nodeStates := FREE;
	signal ne992_lock : objectLock := RELEASED;
	signal Lc04_position : levelCrossingStates := UP;
	signal Lc04_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
	signal Sw05_position : singleSwitchStates := NORMAL;
	signal Sw05_lock : objectLock := RELEASED;
	signal X53_aspectIn : signalStates := RED;
	signal X53_lock: objectLock := RELEASED;
	signal S120_aspectIn : signalStates := RED;
	signal S120_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	ne992_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne992)(2 to 3))));
	ne992_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne992)(0 to 1))));
	Lc04_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc04_state)(2 to 3))));
	Lc04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc04_state)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	Sw05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	X53_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X53_state)(2 to 3))));
	X53_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X53_state)(0 to 1))));
	S120_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S120_state)(2 to 3))));
	S120_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S120_state)(0 to 1))));
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
				if ((ne100_lock = RELEASED and ne992_lock = RELEASED) and (ne992_state = FREE)) then
					ne100_command <= RESERVE;
					ne992_command <= RESERVE;
				end if;
				if (ne100_lock = RESERVED and ne992_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne100_lock = RESERVED and ne992_lock = RESERVED) and (ne992_state = FREE)) then
					ne100_command <= LOCK;
					ne992_command <= LOCK;
				end if;
				if (ne100_lock = LOCKED and ne992_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc04_lock = RELEASED and Sw01_lock = RELEASED and Sw05_lock = RELEASED) then
					Lc04_command <= RESERVE;
					Sw01_command <= RESERVE;
					Sw05_command <= RESERVE;
				end if;
				if (Lc04_lock = RESERVED and Sw01_lock = RESERVED and Sw05_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc04_lock = RESERVED and Sw01_lock = RESERVED and Sw05_lock = RESERVED) then
					Lc04_command <= LOCK;
					Sw01_command <= LOCK;
					Sw05_command <= LOCK;
				end if;
				if (Lc04_lock = LOCKED and Sw01_lock = LOCKED and Sw05_lock = LOCKED)then
					ne100_used <= '0';
					ne992_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (X53_lock = RELEASED and S120_lock = RELEASED) then
					X53_command <= RESERVE;
					S120_command <= LOCK;
				end if;
				if (X53_lock = RESERVED and S120_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne100_used = '0' and ne100_state = OCCUPIED) then 
					ne100_used <= '1';
				end if;
				if (ne100_used = '1' and ne100_state = FREE) then
					ne100_used <= '0';
					ne100_command <= RELEASE;
				end if;
					---
				if (ne100_lock = RELEASED and ne992_used = '0' and ne992_state = OCCUPIED) then 
					ne992_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc04_command <= RELEASE;
				Sw01_command <= RELEASE;
				Sw05_command <= RELEASE;
				ne100_command <= RELEASE;
				ne992_command <= RELEASE;
				X53_command <= RELEASE;
				S120_command <= RELEASE;
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