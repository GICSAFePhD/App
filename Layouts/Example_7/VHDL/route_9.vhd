--  route_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R10 ['Sw18', 'Sw19'] 
--YYY  R10 [] 
	entity route_9 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw19_state : in hex_char;
			Sw19_command : out routeCommands := RELEASE;
			H20_state : in hex_char;
			H20_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_9;
architecture Behavioral of route_9 is
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
	signal ne42_used , ne41_used , ne1_used : std_logic := '0';
	signal ne42_state : nodeStates := FREE;
	signal ne42_lock : objectLock := RELEASED;
	signal ne41_state : nodeStates := FREE;
	signal ne41_lock : objectLock := RELEASED;
	signal ne1_state : nodeStates := FREE;
	signal ne1_lock : objectLock := RELEASED;
	signal Sw18_position : singleSwitchStates := NORMAL;
	signal Sw18_lock : objectLock := RELEASED;
	signal Sw19_position : singleSwitchStates := NORMAL;
	signal Sw19_lock : objectLock := RELEASED;
	signal H20_aspectIn : signalStates := RED;
	signal H20_lock: objectLock := RELEASED;
	signal T01_aspectIn : signalStates := RED;
	signal T01_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne42_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne42)(2 to 3))));
	ne42_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne42)(0 to 1))));
	ne41_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne41)(2 to 3))));
	ne41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne41)(0 to 1))));
	ne1_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne1)(2 to 3))));
	ne1_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne1)(0 to 1))));
	Sw18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw18_state)(2 to 3))));
	Sw18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw18_state)(0 to 1))));
	Sw19_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw19_state)(2 to 3))));
	Sw19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw19_state)(0 to 1))));
	H20_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(H20_state)(2 to 3))));
	H20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(H20_state)(0 to 1))));
	T01_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T01_state)(2 to 3))));
	T01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T01_state)(0 to 1))));
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
				if ((ne42_lock = RELEASED and ne41_lock = RELEASED and ne1_lock = RELEASED) and (ne41_state = FREE and ne1_state = FREE)) then
					ne42_command <= RESERVE;
					ne41_command <= RESERVE;
					ne1_command <= RESERVE;
				end if;
				if (ne42_lock = RESERVED and ne41_lock = RESERVED and ne1_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne42_lock = RESERVED and ne41_lock = RESERVED and ne1_lock = RESERVED) and (ne41_state = FREE and ne1_state = FREE)) then
					ne42_command <= LOCK;
					ne41_command <= LOCK;
					ne1_command <= LOCK;
				end if;
				if (ne42_lock = LOCKED and ne41_lock = LOCKED and ne1_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw18_lock = RELEASED and Sw19_lock = RELEASED) then
					Sw18_command <= RESERVE;
					Sw19_command <= RESERVE;
				end if;
				if (Sw18_lock = RESERVED and Sw19_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw18_lock = RESERVED and Sw19_lock = RESERVED) then
					Sw18_command <= LOCK;
					Sw19_command <= LOCK;
				end if;
				if (Sw18_lock = LOCKED and Sw19_lock = LOCKED)then
					ne42_used <= '0';
					ne41_used <= '0';
					ne1_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (H20_lock = RELEASED and T01_lock = RELEASED) then
					H20_command <= RESERVE;
					T01_command <= LOCK;
				end if;
				if (H20_lock = RESERVED and T01_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne42_used = '0' and ne42_state = OCCUPIED) then 
					ne42_used <= '1';
				end if;
				if (ne42_used = '1' and ne42_state = FREE) then
					ne42_used <= '0';
					ne42_command <= RELEASE;
				end if;
					---
				if (ne42_lock = RELEASED and ne41_used = '0' and ne41_state = OCCUPIED) then 
					ne41_used <= '1';
				end if;
				if (ne41_used = '1' and ne41_state = FREE) then
					ne41_used <= '0';
					ne41_command <= RELEASE;
				end if;
					---
				if (ne41_lock = RELEASED and ne1_used = '0' and ne1_state = OCCUPIED) then 
					ne1_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw18_command <= RELEASE;
				Sw19_command <= RELEASE;
				ne42_command <= RELEASE;
				ne41_command <= RELEASE;
				ne1_command <= RELEASE;
				H20_command <= RELEASE;
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