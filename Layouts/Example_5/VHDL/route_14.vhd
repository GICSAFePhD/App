--  route_14.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R15 ['Sw04'] 
--YYY  R15 [] 
	entity route_14 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne06 : in hex_char;
			ne06_command : out routeCommands := RELEASE;
			track_ne08 : in hex_char;
			ne08_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			C33_state : in hex_char;
			C33_command : out routeCommands := RELEASE;
			T07_state : in hex_char;
			T07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_14;
architecture Behavioral of route_14 is
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
	signal ne06_used , ne08_used : std_logic := '0';
	signal ne06_state : nodeStates := FREE;
	signal ne06_lock : objectLock := RELEASED;
	signal ne08_state : nodeStates := FREE;
	signal ne08_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal C33_aspectIn : signalStates := RED;
	signal C33_lock: objectLock := RELEASED;
	signal T07_aspectIn : signalStates := RED;
	signal T07_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne06_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne06)(2 to 3))));
	ne06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne06)(0 to 1))));
	ne08_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne08)(2 to 3))));
	ne08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne08)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	C33_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C33_state)(2 to 3))));
	C33_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C33_state)(0 to 1))));
	T07_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T07_state)(2 to 3))));
	T07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T07_state)(0 to 1))));
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
				if ((ne06_lock = RELEASED and ne08_lock = RELEASED) and (ne08_state = FREE)) then
					ne06_command <= RESERVE;
					ne08_command <= RESERVE;
				end if;
				if (ne06_lock = RESERVED and ne08_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne06_lock = RESERVED and ne08_lock = RESERVED) and (ne08_state = FREE)) then
					ne06_command <= LOCK;
					ne08_command <= LOCK;
				end if;
				if (ne06_lock = LOCKED and ne08_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw04_lock = RELEASED) then
					Sw04_command <= RESERVE;
				end if;
				if (Sw04_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw04_lock = RESERVED) then
					Sw04_command <= LOCK;
				end if;
				if (Sw04_lock = LOCKED)then
					ne06_used <= '0';
					ne08_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (C33_lock = RELEASED and T07_lock = RELEASED) then
					C33_command <= RESERVE;
					T07_command <= LOCK;
				end if;
				if (C33_lock = RESERVED and T07_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne06_used = '0' and ne06_state = OCCUPIED) then 
					ne06_used <= '1';
				end if;
				if (ne06_used = '1' and ne06_state = FREE) then
					ne06_used <= '0';
					ne06_command <= RELEASE;
				end if;
					---
				if (ne06_lock = RELEASED and ne08_used = '0' and ne08_state = OCCUPIED) then 
					ne08_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw04_command <= RELEASE;
				ne06_command <= RELEASE;
				ne08_command <= RELEASE;
				C33_command <= RELEASE;
				T07_command <= RELEASE;
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