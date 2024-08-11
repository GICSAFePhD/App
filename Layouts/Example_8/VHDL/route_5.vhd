--  route_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R6 ['Sw11'] 
--dw  R6 [] 
--sc  R6 [] 
--lc  R6 ['Lc09', 'Lc05'] 
	entity route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne25 : in hex_char;
			ne25_command : out routeCommands := RELEASE;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Lc05_state : in hex_char;
			Lc05_command : out routeCommands := RELEASE;
			Sw11_state : in hex_char;
			Sw11_command : out routeCommands := RELEASE;
			X14_state : in hex_char;
			X14_command : out routeCommands := RELEASE;
			X12_state : in hex_char;
			X12_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_5;
architecture Behavioral of route_5 is
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
	signal ne25_used , ne23_used : std_logic := '0';
	signal ne25_state : nodeStates := FREE;
	signal ne25_lock : objectLock := RELEASED;
	signal ne23_state : nodeStates := FREE;
	signal ne23_lock : objectLock := RELEASED;
	signal Lc09_position : levelCrossingStates := UP;
	signal Lc09_lock : objectLock := RELEASED;
	signal Lc05_position : levelCrossingStates := UP;
	signal Lc05_lock : objectLock := RELEASED;
	signal Sw11_position : singleSwitchStates := NORMAL;
	signal Sw11_lock : objectLock := RELEASED;
	signal X14_aspectIn : signalStates := RED;
	signal X14_lock: objectLock := RELEASED;
	signal X12_aspectIn : signalStates := RED;
	signal X12_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne25_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne25)(2 to 3))));
	ne25_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne25)(0 to 1))));
	ne23_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne23)(2 to 3))));
	ne23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne23)(0 to 1))));
	Lc09_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc09_state)(2 to 3))));
	Lc09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc09_state)(0 to 1))));
	Lc05_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc05_state)(2 to 3))));
	Lc05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc05_state)(0 to 1))));
	Sw11_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw11_state)(2 to 3))));
	Sw11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw11_state)(0 to 1))));
	X14_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X14_state)(2 to 3))));
	X14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X14_state)(0 to 1))));
	X12_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X12_state)(2 to 3))));
	X12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X12_state)(0 to 1))));
	gen : for i in 0 to 31 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "011011111100001000111010101111110") then
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
				if ((ne25_lock = RELEASED and ne23_lock = RELEASED) and (ne23_state = FREE)) then
					ne25_command <= RESERVE;
					ne23_command <= RESERVE;
				end if;
				if (ne25_lock = RESERVED and ne23_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne25_lock = RESERVED and ne23_lock = RESERVED) and (ne23_state = FREE)) then
					ne25_command <= LOCK;
					ne23_command <= LOCK;
				end if;
				if (ne25_lock = LOCKED and ne23_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc09_lock = RELEASED and Lc05_lock = RELEASED and Sw11_lock = RELEASED) then
					Lc09_command <= RESERVE;
					Lc05_command <= RESERVE;
					Sw11_command <= RESERVE;
				end if;
				if (Lc09_lock = RESERVED and Lc05_lock = RESERVED and Sw11_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc09_lock = RESERVED and Lc05_lock = RESERVED and Sw11_lock = RESERVED) then
					Lc09_command <= LOCK;
					Lc05_command <= LOCK;
					Sw11_command <= LOCK;
				end if;
				if (Lc09_lock = LOCKED and Lc05_lock = LOCKED and Sw11_lock = LOCKED)then
					ne25_used <= '0';
					ne23_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (X14_lock = RELEASED and X12_lock = RELEASED) then
					X14_command <= RESERVE;
					X12_command <= LOCK;
				end if;
				if (X14_lock = RESERVED and X12_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne25_used = '0' and ne25_state = OCCUPIED) then 
					ne25_used <= '1';
				end if;
				if (ne25_used = '1' and ne25_state = FREE) then
					ne25_used <= '0';
					ne25_command <= RELEASE;
				end if;
					---
				if (ne25_lock = RELEASED and ne23_used = '0' and ne23_state = OCCUPIED) then 
					ne23_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc09_command <= RELEASE;
				Lc05_command <= RELEASE;
				Sw11_command <= RELEASE;
				ne25_command <= RELEASE;
				ne23_command <= RELEASE;
				X14_command <= RELEASE;
				X12_command <= RELEASE;
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