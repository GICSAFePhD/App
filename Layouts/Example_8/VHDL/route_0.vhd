--  route_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R1 ['Sw12'] 
--dw  R1 [] 
--sc  R1 [] 
--lc  R1 ['Lc03', 'Lc04'] 
	entity route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne26 : in hex_char;
			ne26_command : out routeCommands := RELEASE;
			Lc03_state : in hex_char;
			Lc03_command : out routeCommands := RELEASE;
			Lc04_state : in hex_char;
			Lc04_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			X06_state : in hex_char;
			X06_command : out routeCommands := RELEASE;
			C24_state : in hex_char;
			C24_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_0;
architecture Behavioral of route_0 is
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
	signal ne26_used : std_logic := '0';
	signal ne26_state : nodeStates := FREE;
	signal ne26_lock : objectLock := RELEASED;
	signal Lc03_position : levelCrossingStates := UP;
	signal Lc03_lock : objectLock := RELEASED;
	signal Lc04_position : levelCrossingStates := UP;
	signal Lc04_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal X06_aspectIn : signalStates := RED;
	signal X06_lock: objectLock := RELEASED;
	signal C24_aspectIn : signalStates := RED;
	signal C24_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne26_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne26)(2 to 3))));
	ne26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne26)(0 to 1))));
	Lc03_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc03_state)(2 to 3))));
	Lc03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc03_state)(0 to 1))));
	Lc04_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc04_state)(2 to 3))));
	Lc04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc04_state)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	X06_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X06_state)(2 to 3))));
	X06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X06_state)(0 to 1))));
	C24_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C24_state)(2 to 3))));
	C24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C24_state)(0 to 1))));
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
				if (ne26_lock = RELEASED) then
					ne26_command <= RESERVE;
				end if;
				if (ne26_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne26_lock = RESERVED) then
					ne26_command <= LOCK;
				end if;
				if (ne26_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc03_lock = RELEASED and Lc04_lock = RELEASED and Sw12_lock = RELEASED) then
					Lc03_command <= RESERVE;
					Lc04_command <= RESERVE;
					Sw12_command <= RESERVE;
				end if;
				if (Lc03_lock = RESERVED and Lc04_lock = RESERVED and Sw12_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc03_lock = RESERVED and Lc04_lock = RESERVED and Sw12_lock = RESERVED) then
					Lc03_command <= LOCK;
					Lc04_command <= LOCK;
					Sw12_command <= LOCK;
				end if;
				if (Lc03_lock = LOCKED and Lc04_lock = LOCKED and Sw12_lock = LOCKED)then
					ne26_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (X06_lock = RELEASED and C24_lock = RELEASED) then
					X06_command <= RESERVE;
					C24_command <= LOCK;
				end if;
				if (X06_lock = RESERVED and C24_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne26_used = '0' and ne26_state = OCCUPIED) then 
					ne26_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc03_command <= RELEASE;
				Lc04_command <= RELEASE;
				Sw12_command <= RELEASE;
				ne26_command <= RELEASE;
				X06_command <= RELEASE;
				C24_command <= RELEASE;
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