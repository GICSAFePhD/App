--  route_12.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R13 ['Sw12', 'Sw11'] 
--dw  R13 [] 
--sc  R13 [] 
--lc  R13 ['Lc06', 'Lc09'] 
	entity route_12 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne27 : in hex_char;
			ne27_command : out routeCommands := RELEASE;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			Sw11_state : in hex_char;
			Sw11_command : out routeCommands := RELEASE;
			S25_state : in hex_char;
			S25_command : out routeCommands := RELEASE;
			X12_state : in hex_char;
			X12_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_12;
architecture Behavioral of route_12 is
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
	signal ne3_used , ne27_used , ne23_used : std_logic := '0';
	signal ne3_state : nodeStates := FREE;
	signal ne3_lock : objectLock := RELEASED;
	signal ne27_state : nodeStates := FREE;
	signal ne27_lock : objectLock := RELEASED;
	signal ne23_state : nodeStates := FREE;
	signal ne23_lock : objectLock := RELEASED;
	signal Lc06_position : levelCrossingStates := UP;
	signal Lc06_lock : objectLock := RELEASED;
	signal Lc09_position : levelCrossingStates := UP;
	signal Lc09_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal Sw11_position : singleSwitchStates := NORMAL;
	signal Sw11_lock : objectLock := RELEASED;
	signal S25_aspectIn : signalStates := RED;
	signal S25_lock: objectLock := RELEASED;
	signal X12_aspectIn : signalStates := RED;
	signal X12_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne3_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne3)(2 to 3))));
	ne3_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne3)(0 to 1))));
	ne27_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne27)(2 to 3))));
	ne27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne27)(0 to 1))));
	ne23_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne23)(2 to 3))));
	ne23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne23)(0 to 1))));
	Lc06_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc06_state)(2 to 3))));
	Lc06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc06_state)(0 to 1))));
	Lc09_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc09_state)(2 to 3))));
	Lc09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc09_state)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	Sw11_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw11_state)(2 to 3))));
	Sw11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw11_state)(0 to 1))));
	S25_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S25_state)(2 to 3))));
	S25_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S25_state)(0 to 1))));
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

				if (routingIn = ROUTE_REQUEST) then
					routeState <= RESERVING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne3_lock = RELEASED and ne27_lock = RELEASED and ne23_lock = RELEASED) and (ne27_state = FREE and ne23_state = FREE)) then
					ne3_command <= RESERVE;
					ne27_command <= RESERVE;
					ne23_command <= RESERVE;
				end if;
				if (ne3_lock = RESERVED and ne27_lock = RESERVED and ne23_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne3_lock = RESERVED and ne27_lock = RESERVED and ne23_lock = RESERVED) and (ne27_state = FREE and ne23_state = FREE)) then
					ne3_command <= LOCK;
					ne27_command <= LOCK;
					ne23_command <= LOCK;
				end if;
				if (ne3_lock = LOCKED and ne27_lock = LOCKED and ne23_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc06_lock = RELEASED and Lc09_lock = RELEASED and Sw12_lock = RELEASED and Sw11_lock = RELEASED) then
					Lc06_command <= RESERVE;
					Lc09_command <= RESERVE;
					Sw12_command <= RESERVE;
					Sw11_command <= RESERVE;
				end if;
				if (Lc06_lock = RESERVED and Lc09_lock = RESERVED and Sw12_lock = RESERVED and Sw11_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc06_lock = RESERVED and Lc09_lock = RESERVED and Sw12_lock = RESERVED and Sw11_lock = RESERVED) then
					Lc06_command <= LOCK;
					Lc09_command <= LOCK;
					Sw12_command <= LOCK;
					Sw11_command <= LOCK;
				end if;
				if (Lc06_lock = LOCKED and Lc09_lock = LOCKED and Sw12_lock = LOCKED and Sw11_lock = LOCKED)then
					ne3_used <= '0';
					ne27_used <= '0';
					ne23_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S25_lock = RELEASED and X12_lock = RELEASED) then
					S25_command <= RESERVE;
					X12_command <= LOCK;
				end if;
				if (S25_lock = RESERVED and X12_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

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
				if (ne3_lock = RELEASED and ne27_used = '0' and ne27_state = OCCUPIED) then 
					ne27_used <= '1';
				end if;
				if (ne27_used = '1' and ne27_state = FREE) then
					ne27_used <= '0';
					ne27_command <= RELEASE;
				end if;
					---
				if (ne27_lock = RELEASED and ne23_used = '0' and ne23_state = OCCUPIED) then 
					ne23_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				Lc06_command <= RELEASE;
				Lc09_command <= RELEASE;
				Sw12_command <= RELEASE;
				Sw11_command <= RELEASE;
				ne3_command <= RELEASE;
				ne27_command <= RELEASE;
				ne23_command <= RELEASE;
				S25_command <= RELEASE;
				X12_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;