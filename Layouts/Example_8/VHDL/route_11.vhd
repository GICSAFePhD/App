--  route_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R12 ['Sw12'] 
--dw  R12 [] 
--sc  R12 [] 
--lc  R12 ['Lc06', 'Lc03', 'Lc04'] 
	entity route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne26 : in hex_char;
			ne26_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			Lc03_state : in hex_char;
			Lc03_command : out routeCommands := RELEASE;
			Lc04_state : in hex_char;
			Lc04_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			S25_state : in hex_char;
			S25_command : out routeCommands := RELEASE;
			X07_state : in hex_char;
			X07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_11;
architecture Behavioral of route_11 is
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
	signal ne3_used , ne26_used : std_logic := '0';
	signal ne3_state : nodeStates := FREE;
	signal ne3_lock : objectLock := RELEASED;
	signal ne26_state : nodeStates := FREE;
	signal ne26_lock : objectLock := RELEASED;
	signal Lc06_position : levelCrossingStates := UP;
	signal Lc06_lock : objectLock := RELEASED;
	signal Lc03_position : levelCrossingStates := UP;
	signal Lc03_lock : objectLock := RELEASED;
	signal Lc04_position : levelCrossingStates := UP;
	signal Lc04_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal S25_aspectIn : signalStates := RED;
	signal S25_lock: objectLock := RELEASED;
	signal X07_aspectIn : signalStates := RED;
	signal X07_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne3_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne3)(2 to 3))));
	ne3_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne3)(0 to 1))));
	ne26_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne26)(2 to 3))));
	ne26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne26)(0 to 1))));
	Lc06_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc06_state)(2 to 3))));
	Lc06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc06_state)(0 to 1))));
	Lc03_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc03_state)(2 to 3))));
	Lc03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc03_state)(0 to 1))));
	Lc04_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc04_state)(2 to 3))));
	Lc04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc04_state)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	S25_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S25_state)(2 to 3))));
	S25_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S25_state)(0 to 1))));
	X07_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X07_state)(2 to 3))));
	X07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X07_state)(0 to 1))));
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
				if ((ne3_lock = RELEASED and ne26_lock = RELEASED) and (ne26_state = FREE)) then
					ne3_command <= RESERVE;
					ne26_command <= RESERVE;
				end if;
				if (ne3_lock = RESERVED and ne26_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne3_lock = RESERVED and ne26_lock = RESERVED) and (ne26_state = FREE)) then
					ne3_command <= LOCK;
					ne26_command <= LOCK;
				end if;
				if (ne3_lock = LOCKED and ne26_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc06_lock = RELEASED and Lc03_lock = RELEASED and Lc04_lock = RELEASED and Sw12_lock = RELEASED) then
					Lc06_command <= RESERVE;
					Lc03_command <= RESERVE;
					Lc04_command <= RESERVE;
					Sw12_command <= RESERVE;
				end if;
				if (Lc06_lock = RESERVED and Lc03_lock = RESERVED and Lc04_lock = RESERVED and Sw12_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc06_lock = RESERVED and Lc03_lock = RESERVED and Lc04_lock = RESERVED and Sw12_lock = RESERVED) then
					Lc06_command <= LOCK;
					Lc03_command <= LOCK;
					Lc04_command <= LOCK;
					Sw12_command <= LOCK;
				end if;
				if (Lc06_lock = LOCKED and Lc03_lock = LOCKED and Lc04_lock = LOCKED and Sw12_lock = LOCKED)then
					ne3_used <= '0';
					ne26_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S25_lock = RELEASED and X07_lock = RELEASED) then
					S25_command <= RESERVE;
					X07_command <= LOCK;
				end if;
				if (S25_lock = RESERVED and X07_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne3_used = '0' and ne3_state = OCCUPIED) then 
					ne3_used <= '1';
				end if;
				if (ne3_used = '1' and ne3_state = FREE) then
					ne3_used <= '0';
					ne3_command <= RELEASE;
				end if;
					---
				if (ne3_lock = RELEASED and ne26_used = '0' and ne26_state = OCCUPIED) then 
					ne26_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc06_command <= RELEASE;
				Lc03_command <= RELEASE;
				Lc04_command <= RELEASE;
				Sw12_command <= RELEASE;
				ne3_command <= RELEASE;
				ne26_command <= RELEASE;
				S25_command <= RELEASE;
				X07_command <= RELEASE;
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