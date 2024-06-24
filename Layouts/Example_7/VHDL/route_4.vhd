--  route_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R5 ['Sw19'] 
--YYY  R5 [] 
	entity route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne43 : in hex_char;
			ne43_command : out routeCommands := RELEASE;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			Sw19_state : in hex_char;
			Sw19_command : out routeCommands := RELEASE;
			T10_state : in hex_char;
			T10_command : out routeCommands := RELEASE;
			T07_state : in hex_char;
			T07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_4;
architecture Behavioral of route_4 is
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
	signal ne43_used , ne42_used : std_logic := '0';
	signal ne43_state : nodeStates := FREE;
	signal ne43_lock : objectLock := RELEASED;
	signal ne42_state : nodeStates := FREE;
	signal ne42_lock : objectLock := RELEASED;
	signal Sw19_position : singleSwitchStates := NORMAL;
	signal Sw19_lock : objectLock := RELEASED;
	signal T10_aspectIn : signalStates := RED;
	signal T10_lock: objectLock := RELEASED;
	signal T07_aspectIn : signalStates := RED;
	signal T07_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne43_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne43)(2 to 3))));
	ne43_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne43)(0 to 1))));
	ne42_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne42)(2 to 3))));
	ne42_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne42)(0 to 1))));
	Sw19_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw19_state)(2 to 3))));
	Sw19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw19_state)(0 to 1))));
	T10_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T10_state)(2 to 3))));
	T10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T10_state)(0 to 1))));
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
				if ((ne43_lock = RELEASED and ne42_lock = RELEASED) and (ne42_state = FREE)) then
					ne43_command <= RESERVE;
					ne42_command <= RESERVE;
				end if;
				if (ne43_lock = RESERVED and ne42_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne43_lock = RESERVED and ne42_lock = RESERVED) and (ne42_state = FREE)) then
					ne43_command <= LOCK;
					ne42_command <= LOCK;
				end if;
				if (ne43_lock = LOCKED and ne42_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw19_lock = RELEASED) then
					Sw19_command <= RESERVE;
				end if;
				if (Sw19_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw19_lock = RESERVED) then
					Sw19_command <= LOCK;
				end if;
				if (Sw19_lock = LOCKED)then
					ne43_used <= '0';
					ne42_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T10_lock = RELEASED and T07_lock = RELEASED) then
					T10_command <= RESERVE;
					T07_command <= LOCK;
				end if;
				if (T10_lock = RESERVED and T07_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne43_used = '0' and ne43_state = OCCUPIED) then 
					ne43_used <= '1';
				end if;
				if (ne43_used = '1' and ne43_state = FREE) then
					ne43_used <= '0';
					ne43_command <= RELEASE;
				end if;
					---
				if (ne43_lock = RELEASED and ne42_used = '0' and ne42_state = OCCUPIED) then 
					ne42_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw19_command <= RELEASE;
				ne43_command <= RELEASE;
				ne42_command <= RELEASE;
				T10_command <= RELEASE;
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