--  route_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R6 ['Sw03', 'Sw04'] 
--dw  R6 [] 
--sc  R6 [] 
--lc  R6 [] 
	entity route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne05 : in hex_char;
			ne05_command : out routeCommands := RELEASE;
			track_ne07 : in hex_char;
			ne07_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			T06_state : in hex_char;
			T06_command : out routeCommands := RELEASE;
			B34_state : in hex_char;
			B34_command : out routeCommands := RELEASE;
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
	signal ne05_used , ne07_used : std_logic := '0';
	signal ne05_state : nodeStates := FREE;
	signal ne05_lock : objectLock := RELEASED;
	signal ne07_state : nodeStates := FREE;
	signal ne07_lock : objectLock := RELEASED;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal T06_aspectIn : signalStates := RED;
	signal T06_lock: objectLock := RELEASED;
	signal B34_aspectIn : signalStates := RED;
	signal B34_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne05_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne05)(2 to 3))));
	ne05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne05)(0 to 1))));
	ne07_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne07)(2 to 3))));
	ne07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne07)(0 to 1))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	T06_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T06_state)(2 to 3))));
	T06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T06_state)(0 to 1))));
	B34_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B34_state)(2 to 3))));
	B34_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B34_state)(0 to 1))));
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
				if ((ne05_lock = RELEASED and ne07_lock = RELEASED) and (ne07_state = FREE)) then
					ne05_command <= RESERVE;
					ne07_command <= RESERVE;
				end if;
				if (ne05_lock = RESERVED and ne07_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne05_lock = RESERVED and ne07_lock = RESERVED) and (ne07_state = FREE)) then
					ne05_command <= LOCK;
					ne07_command <= LOCK;
				end if;
				if (ne05_lock = LOCKED and ne07_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw03_lock = RELEASED and Sw04_lock = RELEASED) then
					Sw03_command <= RESERVE;
					Sw04_command <= RESERVE;
				end if;
				if (Sw03_lock = RESERVED and Sw04_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw03_lock = RESERVED and Sw04_lock = RESERVED) then
					Sw03_command <= LOCK;
					Sw04_command <= LOCK;
				end if;
				if (Sw03_lock = LOCKED and Sw04_lock = LOCKED)then
					ne05_used <= '0';
					ne07_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T06_lock = RELEASED and B34_lock = RELEASED) then
					T06_command <= RESERVE;
					B34_command <= LOCK;
				end if;
				if (T06_lock = RESERVED and B34_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne05_used = '0' and ne05_state = OCCUPIED) then 
					ne05_used <= '1';
				end if;
				if (ne05_used = '1' and ne05_state = FREE) then
					ne05_used <= '0';
					ne05_command <= RELEASE;
				end if;
					---
				if (ne05_lock = RELEASED and ne07_used = '0' and ne07_state = OCCUPIED) then 
					ne07_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw03_command <= RELEASE;
				Sw04_command <= RELEASE;
				ne05_command <= RELEASE;
				ne07_command <= RELEASE;
				T06_command <= RELEASE;
				B34_command <= RELEASE;
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