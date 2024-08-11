--  route_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R2 ['Sw04', 'Sw07'] 
--dw  R2 [] 
--sc  R2 [] 
--lc  R2 ['Lc06'] 
	entity route_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne14 : in hex_char;
			ne14_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			T04_state : in hex_char;
			T04_command : out routeCommands := RELEASE;
			X16_state : in hex_char;
			X16_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_1;
architecture Behavioral of route_1 is
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
	signal ne14_used : std_logic := '0';
	signal ne14_state : nodeStates := FREE;
	signal ne14_lock : objectLock := RELEASED;
	signal Lc06_position : levelCrossingStates := UP;
	signal Lc06_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw07_position : singleSwitchStates := NORMAL;
	signal Sw07_lock : objectLock := RELEASED;
	signal T04_aspectIn : signalStates := RED;
	signal T04_lock: objectLock := RELEASED;
	signal X16_aspectIn : signalStates := RED;
	signal X16_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne14_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne14)(2 to 3))));
	ne14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne14)(0 to 1))));
	Lc06_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc06_state)(2 to 3))));
	Lc06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc06_state)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw07_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw07_state)(2 to 3))));
	Sw07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw07_state)(0 to 1))));
	T04_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T04_state)(2 to 3))));
	T04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T04_state)(0 to 1))));
	X16_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X16_state)(2 to 3))));
	X16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X16_state)(0 to 1))));
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
				if (ne14_lock = RELEASED) then
					ne14_command <= RESERVE;
				end if;
				if (ne14_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne14_lock = RESERVED) then
					ne14_command <= LOCK;
				end if;
				if (ne14_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc06_lock = RELEASED and Sw04_lock = RELEASED and Sw07_lock = RELEASED) then
					Lc06_command <= RESERVE;
					Sw04_command <= RESERVE;
					Sw07_command <= RESERVE;
				end if;
				if (Lc06_lock = RESERVED and Sw04_lock = RESERVED and Sw07_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc06_lock = RESERVED and Sw04_lock = RESERVED and Sw07_lock = RESERVED) then
					Lc06_command <= LOCK;
					Sw04_command <= LOCK;
					Sw07_command <= LOCK;
				end if;
				if (Lc06_lock = LOCKED and Sw04_lock = LOCKED and Sw07_lock = LOCKED)then
					ne14_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T04_lock = RELEASED and X16_lock = RELEASED) then
					T04_command <= RESERVE;
					X16_command <= LOCK;
				end if;
				if (T04_lock = RESERVED and X16_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne14_used = '0' and ne14_state = OCCUPIED) then 
					ne14_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc06_command <= RELEASE;
				Sw04_command <= RELEASE;
				Sw07_command <= RELEASE;
				ne14_command <= RELEASE;
				T04_command <= RELEASE;
				X16_command <= RELEASE;
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