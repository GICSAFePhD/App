--  route_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R8 ['Sw08'] 
--YYY  R8 [] 
	entity route_7 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne7 : in hex_char;
			ne7_command : out routeCommands := RELEASE;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			J19_state : in hex_char;
			J19_command : out routeCommands := RELEASE;
			T07_state : in hex_char;
			T07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_7;
architecture Behavioral of route_7 is
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
	signal ne7_used , ne41_used : std_logic := '0';
	signal ne7_state : nodeStates := FREE;
	signal ne7_lock : objectLock := RELEASED;
	signal ne41_state : nodeStates := FREE;
	signal ne41_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
	signal J19_aspectIn : signalStates := RED;
	signal J19_lock: objectLock := RELEASED;
	signal T07_aspectIn : signalStates := RED;
	signal T07_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne7_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne7)(2 to 3))));
	ne7_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne7)(0 to 1))));
	ne41_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne41)(2 to 3))));
	ne41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne41)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	J19_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J19_state)(2 to 3))));
	J19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J19_state)(0 to 1))));
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
				if ((ne7_lock = RELEASED and ne41_lock = RELEASED) and (ne41_state = FREE)) then
					ne7_command <= RESERVE;
					ne41_command <= RESERVE;
				end if;
				if (ne7_lock = RESERVED and ne41_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne7_lock = RESERVED and ne41_lock = RESERVED) and (ne41_state = FREE)) then
					ne7_command <= LOCK;
					ne41_command <= LOCK;
				end if;
				if (ne7_lock = LOCKED and ne41_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw08_lock = RELEASED) then
					Sw08_command <= RESERVE;
				end if;
				if (Sw08_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw08_lock = RESERVED) then
					Sw08_command <= LOCK;
				end if;
				if (Sw08_lock = LOCKED)then
					ne7_used <= '0';
					ne41_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (J19_lock = RELEASED and T07_lock = RELEASED) then
					J19_command <= RESERVE;
					T07_command <= LOCK;
				end if;
				if (J19_lock = RESERVED and T07_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne7_used = '0' and ne7_state = OCCUPIED) then 
					ne7_used <= '1';
				end if;
				if (ne7_used = '1' and ne7_state = FREE) then
					ne7_used <= '0';
					ne7_command <= RELEASE;
				end if;
					---
				if (ne7_lock = RELEASED and ne41_used = '0' and ne41_state = OCCUPIED) then 
					ne41_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw08_command <= RELEASE;
				ne7_command <= RELEASE;
				ne41_command <= RELEASE;
				J19_command <= RELEASE;
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