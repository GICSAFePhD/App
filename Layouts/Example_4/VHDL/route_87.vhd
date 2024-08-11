--  route_87.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R88 ['D14', 'Sw04'] 
--dw  R88 [] 
--sc  R88 [] 
--lc  R88 [] 
	entity route_87 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne996 : in hex_char;
			ne996_command : out routeCommands := RELEASE;
			track_ne292 : in hex_char;
			ne292_command : out routeCommands := RELEASE;
			D14_state : in hex_char;
			D14_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			S129_state : in hex_char;
			S129_command : out routeCommands := RELEASE;
			J37_state : in hex_char;
			J37_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_87;
architecture Behavioral of route_87 is
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
	signal ne996_used , ne292_used : std_logic := '0';
	signal ne996_state : nodeStates := FREE;
	signal ne996_lock : objectLock := RELEASED;
	signal ne292_state : nodeStates := FREE;
	signal ne292_lock : objectLock := RELEASED;
	signal D14_position : singleSwitchStates := NORMAL;
	signal D14_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal S129_aspectIn : signalStates := RED;
	signal S129_lock: objectLock := RELEASED;
	signal J37_aspectIn : signalStates := RED;
	signal J37_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne996_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne996)(2 to 3))));
	ne996_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne996)(0 to 1))));
	ne292_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne292)(2 to 3))));
	ne292_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne292)(0 to 1))));
	D14_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D14_state)(2 to 3))));
	D14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D14_state)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	S129_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S129_state)(2 to 3))));
	S129_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S129_state)(0 to 1))));
	J37_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J37_state)(2 to 3))));
	J37_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J37_state)(0 to 1))));
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
				if ((ne996_lock = RELEASED and ne292_lock = RELEASED) and (ne292_state = FREE)) then
					ne996_command <= RESERVE;
					ne292_command <= RESERVE;
				end if;
				if (ne996_lock = RESERVED and ne292_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne996_lock = RESERVED and ne292_lock = RESERVED) and (ne292_state = FREE)) then
					ne996_command <= LOCK;
					ne292_command <= LOCK;
				end if;
				if (ne996_lock = LOCKED and ne292_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D14_lock = RELEASED and Sw04_lock = RELEASED) then
					D14_command <= RESERVE;
					Sw04_command <= RESERVE;
				end if;
				if (D14_lock = RESERVED and Sw04_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D14_lock = RESERVED and Sw04_lock = RESERVED) then
					D14_command <= LOCK;
					Sw04_command <= LOCK;
				end if;
				if (D14_lock = LOCKED and Sw04_lock = LOCKED)then
					ne996_used <= '0';
					ne292_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S129_lock = RELEASED and J37_lock = RELEASED) then
					S129_command <= RESERVE;
					J37_command <= LOCK;
				end if;
				if (S129_lock = RESERVED and J37_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne996_used = '0' and ne996_state = OCCUPIED) then 
					ne996_used <= '1';
				end if;
				if (ne996_used = '1' and ne996_state = FREE) then
					ne996_used <= '0';
					ne996_command <= RELEASE;
				end if;
					---
				if (ne996_lock = RELEASED and ne292_used = '0' and ne292_state = OCCUPIED) then 
					ne292_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D14_command <= RELEASE;
				Sw04_command <= RELEASE;
				ne996_command <= RELEASE;
				ne292_command <= RELEASE;
				S129_command <= RELEASE;
				J37_command <= RELEASE;
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