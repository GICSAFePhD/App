--  route_86.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R87 ['Sw04', 'Sw03'] 
--dw  R87 [] 
--sc  R87 [] 
--lc  R87 [] 
	entity route_86 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne297 : in hex_char;
			ne297_command : out routeCommands := RELEASE;
			track_ne997 : in hex_char;
			ne997_command : out routeCommands := RELEASE;
			track_ne996 : in hex_char;
			ne996_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			S126_state : in hex_char;
			S126_command : out routeCommands := RELEASE;
			J38_state : in hex_char;
			J38_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_86;
architecture Behavioral of route_86 is
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
	signal ne297_used , ne997_used , ne996_used : std_logic := '0';
	signal ne297_state : nodeStates := FREE;
	signal ne297_lock : objectLock := RELEASED;
	signal ne997_state : nodeStates := FREE;
	signal ne997_lock : objectLock := RELEASED;
	signal ne996_state : nodeStates := FREE;
	signal ne996_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal S126_aspectIn : signalStates := RED;
	signal S126_lock: objectLock := RELEASED;
	signal J38_aspectIn : signalStates := RED;
	signal J38_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne297_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne297)(2 to 3))));
	ne297_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne297)(0 to 1))));
	ne997_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne997)(2 to 3))));
	ne997_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne997)(0 to 1))));
	ne996_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne996)(2 to 3))));
	ne996_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne996)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	S126_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S126_state)(2 to 3))));
	S126_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S126_state)(0 to 1))));
	J38_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J38_state)(2 to 3))));
	J38_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J38_state)(0 to 1))));
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
				if ((ne297_lock = RELEASED and ne997_lock = RELEASED and ne996_lock = RELEASED) and (ne997_state = FREE and ne996_state = FREE)) then
					ne297_command <= RESERVE;
					ne997_command <= RESERVE;
					ne996_command <= RESERVE;
				end if;
				if (ne297_lock = RESERVED and ne997_lock = RESERVED and ne996_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne297_lock = RESERVED and ne997_lock = RESERVED and ne996_lock = RESERVED) and (ne997_state = FREE and ne996_state = FREE)) then
					ne297_command <= LOCK;
					ne997_command <= LOCK;
					ne996_command <= LOCK;
				end if;
				if (ne297_lock = LOCKED and ne997_lock = LOCKED and ne996_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw04_lock = RELEASED and Sw03_lock = RELEASED) then
					Sw04_command <= RESERVE;
					Sw03_command <= RESERVE;
				end if;
				if (Sw04_lock = RESERVED and Sw03_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw04_lock = RESERVED and Sw03_lock = RESERVED) then
					Sw04_command <= LOCK;
					Sw03_command <= LOCK;
				end if;
				if (Sw04_lock = LOCKED and Sw03_lock = LOCKED)then
					ne297_used <= '0';
					ne997_used <= '0';
					ne996_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S126_lock = RELEASED and J38_lock = RELEASED) then
					S126_command <= RESERVE;
					J38_command <= LOCK;
				end if;
				if (S126_lock = RESERVED and J38_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne297_used = '0' and ne297_state = OCCUPIED) then 
					ne297_used <= '1';
				end if;
				if (ne297_used = '1' and ne297_state = FREE) then
					ne297_used <= '0';
					ne297_command <= RELEASE;
				end if;
					---
				if (ne297_lock = RELEASED and ne997_used = '0' and ne997_state = OCCUPIED) then 
					ne997_used <= '1';
				end if;
				if (ne997_used = '1' and ne997_state = FREE) then
					ne997_used <= '0';
					ne997_command <= RELEASE;
				end if;
					---
				if (ne997_lock = RELEASED and ne996_used = '0' and ne996_state = OCCUPIED) then 
					ne996_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw04_command <= RELEASE;
				Sw03_command <= RELEASE;
				ne297_command <= RELEASE;
				ne997_command <= RELEASE;
				ne996_command <= RELEASE;
				S126_command <= RELEASE;
				J38_command <= RELEASE;
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