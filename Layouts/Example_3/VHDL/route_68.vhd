--  route_68.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R69 ['Sw04'] 
--dw  R69 ['Sw05'] 
--sc  R69 [] 
--lc  R69 [] 
	entity route_68 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne32 : in hex_char;
			ne32_command : out routeCommands := RELEASE;
			track_ne82 : in hex_char;
			ne82_command : out routeCommands := RELEASE;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			S115_state : in hex_char;
			S115_command : out routeCommands := RELEASE;
			P58_state : in hex_char;
			P58_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_68;
architecture Behavioral of route_68 is
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
	signal ne32_used , ne82_used , ne41_used : std_logic := '0';
	signal ne32_state : nodeStates := FREE;
	signal ne32_lock : objectLock := RELEASED;
	signal ne82_state : nodeStates := FREE;
	signal ne82_lock : objectLock := RELEASED;
	signal ne41_state : nodeStates := FREE;
	signal ne41_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw05_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw05_lock : objectLock := RELEASED;
	signal S115_aspectIn : signalStates := RED;
	signal S115_lock: objectLock := RELEASED;
	signal P58_aspectIn : signalStates := RED;
	signal P58_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne32_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne32)(2 to 3))));
	ne32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne32)(0 to 1))));
	ne82_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne82)(2 to 3))));
	ne82_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne82)(0 to 1))));
	ne41_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne41)(2 to 3))));
	ne41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne41)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw05_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	S115_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S115_state)(2 to 3))));
	S115_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S115_state)(0 to 1))));
	P58_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P58_state)(2 to 3))));
	P58_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P58_state)(0 to 1))));
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
				if ((ne32_lock = RELEASED and ne82_lock = RELEASED and ne41_lock = RELEASED) and (ne82_state = FREE and ne41_state = FREE)) then
					ne32_command <= RESERVE;
					ne82_command <= RESERVE;
					ne41_command <= RESERVE;
				end if;
				if (ne32_lock = RESERVED and ne82_lock = RESERVED and ne41_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne32_lock = RESERVED and ne82_lock = RESERVED and ne41_lock = RESERVED) and (ne82_state = FREE and ne41_state = FREE)) then
					ne32_command <= LOCK;
					ne82_command <= LOCK;
					ne41_command <= LOCK;
				end if;
				if (ne32_lock = LOCKED and ne82_lock = LOCKED and ne41_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw04_lock = RELEASED and Sw05_lock = RELEASED) then
					Sw04_command <= RESERVE;
					Sw05_command <= RESERVE;
				end if;
				if (Sw04_lock = RESERVED and Sw05_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw04_lock = RESERVED and Sw05_lock = RESERVED) then
					Sw04_command <= LOCK;
					Sw05_command <= LOCK;
				end if;
				if (Sw04_lock = LOCKED and Sw05_lock = LOCKED)then
					ne32_used <= '0';
					ne82_used <= '0';
					ne41_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S115_lock = RELEASED and P58_lock = RELEASED) then
					S115_command <= RESERVE;
					P58_command <= LOCK;
				end if;
				if (S115_lock = RESERVED and P58_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne32_used = '0' and ne32_state = OCCUPIED) then 
					ne32_used <= '1';
				end if;
				if (ne32_used = '1' and ne32_state = FREE) then
					ne32_used <= '0';
					ne32_command <= RELEASE;
				end if;
					---
				if (ne32_lock = RELEASED and ne82_used = '0' and ne82_state = OCCUPIED) then 
					ne82_used <= '1';
				end if;
				if (ne82_used = '1' and ne82_state = FREE) then
					ne82_used <= '0';
					ne82_command <= RELEASE;
				end if;
					---
				if (ne82_lock = RELEASED and ne41_used = '0' and ne41_state = OCCUPIED) then 
					ne41_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw04_command <= RELEASE;
				Sw05_command <= RELEASE;
				ne32_command <= RELEASE;
				ne82_command <= RELEASE;
				ne41_command <= RELEASE;
				S115_command <= RELEASE;
				P58_command <= RELEASE;
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