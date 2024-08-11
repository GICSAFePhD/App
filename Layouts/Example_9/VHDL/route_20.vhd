--  route_20.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R21 ['Sw27', 'Sw29'] 
--dw  R21 [] 
--sc  R21 [] 
--lc  R21 ['Lc11'] 
	entity route_20 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			track_ne48 : in hex_char;
			ne48_command : out routeCommands := RELEASE;
			track_ne49 : in hex_char;
			ne49_command : out routeCommands := RELEASE;
			Lc11_state : in hex_char;
			Lc11_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			Sw29_state : in hex_char;
			Sw29_command : out routeCommands := RELEASE;
			S36_state : in hex_char;
			S36_command : out routeCommands := RELEASE;
			J05_state : in hex_char;
			J05_command : out routeCommands := RELEASE;
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
	signal ne40_used , ne48_used , ne49_used : std_logic := '0';
	signal ne40_state : nodeStates := FREE;
	signal ne40_lock : objectLock := RELEASED;
	signal ne48_state : nodeStates := FREE;
	signal ne48_lock : objectLock := RELEASED;
	signal ne49_state : nodeStates := FREE;
	signal ne49_lock : objectLock := RELEASED;
	signal Lc11_position : levelCrossingStates := UP;
	signal Lc11_lock : objectLock := RELEASED;
	signal Sw27_position : singleSwitchStates := NORMAL;
	signal Sw27_lock : objectLock := RELEASED;
	signal Sw29_position : singleSwitchStates := NORMAL;
	signal Sw29_lock : objectLock := RELEASED;
	signal S36_aspectIn : signalStates := RED;
	signal S36_lock: objectLock := RELEASED;
	signal J05_aspectIn : signalStates := RED;
	signal J05_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne40_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne40)(2 to 3))));
	ne40_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne40)(0 to 1))));
	ne48_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne48)(2 to 3))));
	ne48_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne48)(0 to 1))));
	ne49_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne49)(2 to 3))));
	ne49_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne49)(0 to 1))));
	Lc11_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc11_state)(2 to 3))));
	Lc11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc11_state)(0 to 1))));
	Sw27_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw27_state)(2 to 3))));
	Sw27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw27_state)(0 to 1))));
	Sw29_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw29_state)(2 to 3))));
	Sw29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw29_state)(0 to 1))));
	S36_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S36_state)(2 to 3))));
	S36_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S36_state)(0 to 1))));
	J05_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J05_state)(2 to 3))));
	J05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J05_state)(0 to 1))));
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
				if ((ne40_lock = RELEASED and ne48_lock = RELEASED and ne49_lock = RELEASED) and (ne48_state = FREE and ne49_state = FREE)) then
					ne40_command <= RESERVE;
					ne48_command <= RESERVE;
					ne49_command <= RESERVE;
				end if;
				if (ne40_lock = RESERVED and ne48_lock = RESERVED and ne49_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne40_lock = RESERVED and ne48_lock = RESERVED and ne49_lock = RESERVED) and (ne48_state = FREE and ne49_state = FREE)) then
					ne40_command <= LOCK;
					ne48_command <= LOCK;
					ne49_command <= LOCK;
				end if;
				if (ne40_lock = LOCKED and ne48_lock = LOCKED and ne49_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc11_lock = RELEASED and Sw27_lock = RELEASED and Sw29_lock = RELEASED) then
					Lc11_command <= RESERVE;
					Sw27_command <= RESERVE;
					Sw29_command <= RESERVE;
				end if;
				if (Lc11_lock = RESERVED and Sw27_lock = RESERVED and Sw29_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc11_lock = RESERVED and Sw27_lock = RESERVED and Sw29_lock = RESERVED) then
					Lc11_command <= LOCK;
					Sw27_command <= LOCK;
					Sw29_command <= LOCK;
				end if;
				if (Lc11_lock = LOCKED and Sw27_lock = LOCKED and Sw29_lock = LOCKED)then
					ne40_used <= '0';
					ne48_used <= '0';
					ne49_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S36_lock = RELEASED and J05_lock = RELEASED) then
					S36_command <= RESERVE;
					J05_command <= LOCK;
				end if;
				if (S36_lock = RESERVED and J05_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne40_used = '0' and ne40_state = OCCUPIED) then 
					ne40_used <= '1';
				end if;
				if (ne40_used = '1' and ne40_state = FREE) then
					ne40_used <= '0';
					ne40_command <= RELEASE;
				end if;
					---
				if (ne40_lock = RELEASED and ne48_used = '0' and ne48_state = OCCUPIED) then 
					ne48_used <= '1';
				end if;
				if (ne48_used = '1' and ne48_state = FREE) then
					ne48_used <= '0';
					ne48_command <= RELEASE;
				end if;
					---
				if (ne48_lock = RELEASED and ne49_used = '0' and ne49_state = OCCUPIED) then 
					ne49_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc11_command <= RELEASE;
				Sw27_command <= RELEASE;
				Sw29_command <= RELEASE;
				ne40_command <= RELEASE;
				ne48_command <= RELEASE;
				ne49_command <= RELEASE;
				S36_command <= RELEASE;
				J05_command <= RELEASE;
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