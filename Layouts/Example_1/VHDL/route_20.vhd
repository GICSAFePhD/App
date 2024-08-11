--  route_20.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R21 ['Sw04', 'Sw12', 'Sw13'] 
--dw  R21 [] 
--sc  R21 [] 
--lc  R21 [] 
	entity route_20 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne12 : in hex_char;
			ne12_command : out routeCommands := RELEASE;
			track_ne24 : in hex_char;
			ne24_command : out routeCommands := RELEASE;
			track_ne8 : in hex_char;
			ne8_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			Sw13_state : in hex_char;
			Sw13_command : out routeCommands := RELEASE;
			S35_state : in hex_char;
			S35_command : out routeCommands := RELEASE;
			C21_state : in hex_char;
			C21_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_20;
architecture Behavioral of route_20 is
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
	signal ne12_used , ne24_used , ne8_used : std_logic := '0';
	signal ne12_state : nodeStates := FREE;
	signal ne12_lock : objectLock := RELEASED;
	signal ne24_state : nodeStates := FREE;
	signal ne24_lock : objectLock := RELEASED;
	signal ne8_state : nodeStates := FREE;
	signal ne8_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal Sw13_position : singleSwitchStates := NORMAL;
	signal Sw13_lock : objectLock := RELEASED;
	signal S35_aspectIn : signalStates := RED;
	signal S35_lock: objectLock := RELEASED;
	signal C21_aspectIn : signalStates := RED;
	signal C21_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne12_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne12)(2 to 3))));
	ne12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne12)(0 to 1))));
	ne24_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne24)(2 to 3))));
	ne24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne24)(0 to 1))));
	ne8_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne8)(2 to 3))));
	ne8_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne8)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	Sw13_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw13_state)(2 to 3))));
	Sw13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw13_state)(0 to 1))));
	S35_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S35_state)(2 to 3))));
	S35_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S35_state)(0 to 1))));
	C21_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C21_state)(2 to 3))));
	C21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C21_state)(0 to 1))));
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
				if ((ne12_lock = RELEASED and ne24_lock = RELEASED and ne8_lock = RELEASED) and (ne24_state = FREE and ne8_state = FREE)) then
					ne12_command <= RESERVE;
					ne24_command <= RESERVE;
					ne8_command <= RESERVE;
				end if;
				if (ne12_lock = RESERVED and ne24_lock = RESERVED and ne8_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne12_lock = RESERVED and ne24_lock = RESERVED and ne8_lock = RESERVED) and (ne24_state = FREE and ne8_state = FREE)) then
					ne12_command <= LOCK;
					ne24_command <= LOCK;
					ne8_command <= LOCK;
				end if;
				if (ne12_lock = LOCKED and ne24_lock = LOCKED and ne8_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw04_lock = RELEASED and Sw12_lock = RELEASED and Sw13_lock = RELEASED) then
					Sw04_command <= RESERVE;
					Sw12_command <= RESERVE;
					Sw13_command <= RESERVE;
				end if;
				if (Sw04_lock = RESERVED and Sw12_lock = RESERVED and Sw13_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw04_lock = RESERVED and Sw12_lock = RESERVED and Sw13_lock = RESERVED) then
					Sw04_command <= LOCK;
					Sw12_command <= LOCK;
					Sw13_command <= LOCK;
				end if;
				if (Sw04_lock = LOCKED and Sw12_lock = LOCKED and Sw13_lock = LOCKED)then
					ne12_used <= '0';
					ne24_used <= '0';
					ne8_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S35_lock = RELEASED and C21_lock = RELEASED) then
					S35_command <= RESERVE;
					C21_command <= LOCK;
				end if;
				if (S35_lock = RESERVED and C21_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne12_used = '0' and ne12_state = OCCUPIED) then 
					ne12_used <= '1';
				end if;
				if (ne12_used = '1' and ne12_state = FREE) then
					ne12_used <= '0';
					ne12_command <= RELEASE;
				end if;
					---
				if (ne12_lock = RELEASED and ne24_used = '0' and ne24_state = OCCUPIED) then 
					ne24_used <= '1';
				end if;
				if (ne24_used = '1' and ne24_state = FREE) then
					ne24_used <= '0';
					ne24_command <= RELEASE;
				end if;
					---
				if (ne24_lock = RELEASED and ne8_used = '0' and ne8_state = OCCUPIED) then 
					ne8_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw04_command <= RELEASE;
				Sw12_command <= RELEASE;
				Sw13_command <= RELEASE;
				ne12_command <= RELEASE;
				ne24_command <= RELEASE;
				ne8_command <= RELEASE;
				S35_command <= RELEASE;
				C21_command <= RELEASE;
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