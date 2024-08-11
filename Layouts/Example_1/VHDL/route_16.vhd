--  route_16.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R17 ['Sw04', 'Sw07'] 
--dw  R17 [] 
--sc  R17 [] 
--lc  R17 [] 
	entity route_16 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne15 : in hex_char;
			ne15_command : out routeCommands := RELEASE;
			track_ne9 : in hex_char;
			ne9_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			C29_state : in hex_char;
			C29_command : out routeCommands := RELEASE;
			L07_state : in hex_char;
			L07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_16;
architecture Behavioral of route_16 is
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
	signal ne15_used , ne9_used , ne1_used : std_logic := '0';
	signal ne15_state : nodeStates := FREE;
	signal ne15_lock : objectLock := RELEASED;
	signal ne9_state : nodeStates := FREE;
	signal ne9_lock : objectLock := RELEASED;
	signal ne1_state : nodeStates := FREE;
	signal ne1_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw07_position : singleSwitchStates := NORMAL;
	signal Sw07_lock : objectLock := RELEASED;
	signal C29_aspectIn : signalStates := RED;
	signal C29_lock: objectLock := RELEASED;
	signal L07_aspectIn : signalStates := RED;
	signal L07_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne15_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne15)(2 to 3))));
	ne15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne15)(0 to 1))));
	ne9_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne9)(2 to 3))));
	ne9_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne9)(0 to 1))));
	ne1_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne1)(2 to 3))));
	ne1_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne1)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw07_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw07_state)(2 to 3))));
	Sw07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw07_state)(0 to 1))));
	C29_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C29_state)(2 to 3))));
	C29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C29_state)(0 to 1))));
	L07_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L07_state)(2 to 3))));
	L07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L07_state)(0 to 1))));
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
				if ((ne15_lock = RELEASED and ne9_lock = RELEASED and ne1_lock = RELEASED) and (ne9_state = FREE and ne1_state = FREE)) then
					ne15_command <= RESERVE;
					ne9_command <= RESERVE;
					ne1_command <= RESERVE;
				end if;
				if (ne15_lock = RESERVED and ne9_lock = RESERVED and ne1_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne15_lock = RESERVED and ne9_lock = RESERVED and ne1_lock = RESERVED) and (ne9_state = FREE and ne1_state = FREE)) then
					ne15_command <= LOCK;
					ne9_command <= LOCK;
					ne1_command <= LOCK;
				end if;
				if (ne15_lock = LOCKED and ne9_lock = LOCKED and ne1_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw04_lock = RELEASED and Sw07_lock = RELEASED) then
					Sw04_command <= RESERVE;
					Sw07_command <= RESERVE;
				end if;
				if (Sw04_lock = RESERVED and Sw07_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw04_lock = RESERVED and Sw07_lock = RESERVED) then
					Sw04_command <= LOCK;
					Sw07_command <= LOCK;
				end if;
				if (Sw04_lock = LOCKED and Sw07_lock = LOCKED)then
					ne15_used <= '0';
					ne9_used <= '0';
					ne1_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (C29_lock = RELEASED and L07_lock = RELEASED) then
					C29_command <= RESERVE;
					L07_command <= LOCK;
				end if;
				if (C29_lock = RESERVED and L07_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne15_used = '0' and ne15_state = OCCUPIED) then 
					ne15_used <= '1';
				end if;
				if (ne15_used = '1' and ne15_state = FREE) then
					ne15_used <= '0';
					ne15_command <= RELEASE;
				end if;
					---
				if (ne15_lock = RELEASED and ne9_used = '0' and ne9_state = OCCUPIED) then 
					ne9_used <= '1';
				end if;
				if (ne9_used = '1' and ne9_state = FREE) then
					ne9_used <= '0';
					ne9_command <= RELEASE;
				end if;
					---
				if (ne9_lock = RELEASED and ne1_used = '0' and ne1_state = OCCUPIED) then 
					ne1_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw04_command <= RELEASE;
				Sw07_command <= RELEASE;
				ne15_command <= RELEASE;
				ne9_command <= RELEASE;
				ne1_command <= RELEASE;
				C29_command <= RELEASE;
				L07_command <= RELEASE;
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