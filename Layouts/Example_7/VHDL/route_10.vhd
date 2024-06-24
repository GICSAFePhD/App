--  route_10.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R11 ['Sw19'] 
--YYY  R11 [] 
	entity route_10 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			track_ne43 : in hex_char;
			ne43_command : out routeCommands := RELEASE;
			Sw19_state : in hex_char;
			Sw19_command : out routeCommands := RELEASE;
			H20_state : in hex_char;
			H20_command : out routeCommands := RELEASE;
			T09_state : in hex_char;
			T09_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_10;
architecture Behavioral of route_10 is
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
	signal ne42_used , ne43_used : std_logic := '0';
	signal ne42_state : nodeStates := FREE;
	signal ne42_lock : objectLock := RELEASED;
	signal ne43_state : nodeStates := FREE;
	signal ne43_lock : objectLock := RELEASED;
	signal Sw19_position : singleSwitchStates := NORMAL;
	signal Sw19_lock : objectLock := RELEASED;
	signal H20_aspectIn : signalStates := RED;
	signal H20_lock: objectLock := RELEASED;
	signal T09_aspectIn : signalStates := RED;
	signal T09_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne42_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne42)(2 to 3))));
	ne42_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne42)(0 to 1))));
	ne43_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne43)(2 to 3))));
	ne43_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne43)(0 to 1))));
	Sw19_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw19_state)(2 to 3))));
	Sw19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw19_state)(0 to 1))));
	H20_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(H20_state)(2 to 3))));
	H20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(H20_state)(0 to 1))));
	T09_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T09_state)(2 to 3))));
	T09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T09_state)(0 to 1))));
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
				if ((ne42_lock = RELEASED and ne43_lock = RELEASED) and (ne43_state = FREE)) then
					ne42_command <= RESERVE;
					ne43_command <= RESERVE;
				end if;
				if (ne42_lock = RESERVED and ne43_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne42_lock = RESERVED and ne43_lock = RESERVED) and (ne43_state = FREE)) then
					ne42_command <= LOCK;
					ne43_command <= LOCK;
				end if;
				if (ne42_lock = LOCKED and ne43_lock = LOCKED)then
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
					ne42_used <= '0';
					ne43_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (H20_lock = RELEASED and T09_lock = RELEASED) then
					H20_command <= RESERVE;
					T09_command <= LOCK;
				end if;
				if (H20_lock = RESERVED and T09_lock = LOCKED) then
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
				if (ne42_lock = RELEASED and ne43_used = '0' and ne43_state = OCCUPIED) then 
					ne43_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw19_command <= RELEASE;
				ne42_command <= RELEASE;
				ne43_command <= RELEASE;
				H20_command <= RELEASE;
				T09_command <= RELEASE;
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