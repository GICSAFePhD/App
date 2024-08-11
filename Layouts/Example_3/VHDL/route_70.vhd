--  route_70.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R71 ['Sw11'] 
--dw  R71 [] 
--sc  R71 [] 
--lc  R71 [] 
	entity route_70 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne88 : in hex_char;
			ne88_command : out routeCommands := RELEASE;
			track_ne86 : in hex_char;
			ne86_command : out routeCommands := RELEASE;
			Sw11_state : in hex_char;
			Sw11_command : out routeCommands := RELEASE;
			C118_state : in hex_char;
			C118_command : out routeCommands := RELEASE;
			T15_state : in hex_char;
			T15_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_70;
architecture Behavioral of route_70 is
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
	signal ne88_used , ne86_used : std_logic := '0';
	signal ne88_state : nodeStates := FREE;
	signal ne88_lock : objectLock := RELEASED;
	signal ne86_state : nodeStates := FREE;
	signal ne86_lock : objectLock := RELEASED;
	signal Sw11_position : singleSwitchStates := NORMAL;
	signal Sw11_lock : objectLock := RELEASED;
	signal C118_aspectIn : signalStates := RED;
	signal C118_lock: objectLock := RELEASED;
	signal T15_aspectIn : signalStates := RED;
	signal T15_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne88_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne88)(2 to 3))));
	ne88_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne88)(0 to 1))));
	ne86_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne86)(2 to 3))));
	ne86_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne86)(0 to 1))));
	Sw11_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw11_state)(2 to 3))));
	Sw11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw11_state)(0 to 1))));
	C118_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C118_state)(2 to 3))));
	C118_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C118_state)(0 to 1))));
	T15_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T15_state)(2 to 3))));
	T15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T15_state)(0 to 1))));
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
				if ((ne88_lock = RELEASED and ne86_lock = RELEASED) and (ne86_state = FREE)) then
					ne88_command <= RESERVE;
					ne86_command <= RESERVE;
				end if;
				if (ne88_lock = RESERVED and ne86_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne88_lock = RESERVED and ne86_lock = RESERVED) and (ne86_state = FREE)) then
					ne88_command <= LOCK;
					ne86_command <= LOCK;
				end if;
				if (ne88_lock = LOCKED and ne86_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw11_lock = RELEASED) then
					Sw11_command <= RESERVE;
				end if;
				if (Sw11_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw11_lock = RESERVED) then
					Sw11_command <= LOCK;
				end if;
				if (Sw11_lock = LOCKED)then
					ne88_used <= '0';
					ne86_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (C118_lock = RELEASED and T15_lock = RELEASED) then
					C118_command <= RESERVE;
					T15_command <= LOCK;
				end if;
				if (C118_lock = RESERVED and T15_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne88_used = '0' and ne88_state = OCCUPIED) then 
					ne88_used <= '1';
				end if;
				if (ne88_used = '1' and ne88_state = FREE) then
					ne88_used <= '0';
					ne88_command <= RELEASE;
				end if;
					---
				if (ne88_lock = RELEASED and ne86_used = '0' and ne86_state = OCCUPIED) then 
					ne86_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw11_command <= RELEASE;
				ne88_command <= RELEASE;
				ne86_command <= RELEASE;
				C118_command <= RELEASE;
				T15_command <= RELEASE;
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