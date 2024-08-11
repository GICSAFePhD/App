--  route_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R5 ['Sw09', 'Sw04'] 
--dw  R5 ['Sw05'] 
--sc  R5 [] 
--lc  R5 [] 
	entity route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne84 : in hex_char;
			ne84_command : out routeCommands := RELEASE;
			track_ne82 : in hex_char;
			ne82_command : out routeCommands := RELEASE;
			track_ne32 : in hex_char;
			ne32_command : out routeCommands := RELEASE;
			Sw09_state : in hex_char;
			Sw09_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			T14_state : in hex_char;
			T14_command : out routeCommands := RELEASE;
			C100_state : in hex_char;
			C100_command : out routeCommands := RELEASE;
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
	signal ne84_used , ne82_used , ne32_used : std_logic := '0';
	signal ne84_state : nodeStates := FREE;
	signal ne84_lock : objectLock := RELEASED;
	signal ne82_state : nodeStates := FREE;
	signal ne82_lock : objectLock := RELEASED;
	signal ne32_state : nodeStates := FREE;
	signal ne32_lock : objectLock := RELEASED;
	signal Sw09_position : singleSwitchStates := NORMAL;
	signal Sw09_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw05_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw05_lock : objectLock := RELEASED;
	signal T14_aspectIn : signalStates := RED;
	signal T14_lock: objectLock := RELEASED;
	signal C100_aspectIn : signalStates := RED;
	signal C100_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne84_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne84)(2 to 3))));
	ne84_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne84)(0 to 1))));
	ne82_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne82)(2 to 3))));
	ne82_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne82)(0 to 1))));
	ne32_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne32)(2 to 3))));
	ne32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne32)(0 to 1))));
	Sw09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw09_state)(2 to 3))));
	Sw09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw09_state)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw05_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	T14_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T14_state)(2 to 3))));
	T14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T14_state)(0 to 1))));
	C100_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C100_state)(2 to 3))));
	C100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C100_state)(0 to 1))));
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
				if ((ne84_lock = RELEASED and ne82_lock = RELEASED and ne32_lock = RELEASED) and (ne82_state = FREE and ne32_state = FREE)) then
					ne84_command <= RESERVE;
					ne82_command <= RESERVE;
					ne32_command <= RESERVE;
				end if;
				if (ne84_lock = RESERVED and ne82_lock = RESERVED and ne32_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne84_lock = RESERVED and ne82_lock = RESERVED and ne32_lock = RESERVED) and (ne82_state = FREE and ne32_state = FREE)) then
					ne84_command <= LOCK;
					ne82_command <= LOCK;
					ne32_command <= LOCK;
				end if;
				if (ne84_lock = LOCKED and ne82_lock = LOCKED and ne32_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw09_lock = RELEASED and Sw04_lock = RELEASED and Sw05_lock = RELEASED) then
					Sw09_command <= RESERVE;
					Sw04_command <= RESERVE;
					Sw05_command <= RESERVE;
				end if;
				if (Sw09_lock = RESERVED and Sw04_lock = RESERVED and Sw05_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw09_lock = RESERVED and Sw04_lock = RESERVED and Sw05_lock = RESERVED) then
					Sw09_command <= LOCK;
					Sw04_command <= LOCK;
					Sw05_command <= LOCK;
				end if;
				if (Sw09_lock = LOCKED and Sw04_lock = LOCKED and Sw05_lock = LOCKED)then
					ne84_used <= '0';
					ne82_used <= '0';
					ne32_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T14_lock = RELEASED and C100_lock = RELEASED) then
					T14_command <= RESERVE;
					C100_command <= LOCK;
				end if;
				if (T14_lock = RESERVED and C100_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne84_used = '0' and ne84_state = OCCUPIED) then 
					ne84_used <= '1';
				end if;
				if (ne84_used = '1' and ne84_state = FREE) then
					ne84_used <= '0';
					ne84_command <= RELEASE;
				end if;
					---
				if (ne84_lock = RELEASED and ne82_used = '0' and ne82_state = OCCUPIED) then 
					ne82_used <= '1';
				end if;
				if (ne82_used = '1' and ne82_state = FREE) then
					ne82_used <= '0';
					ne82_command <= RELEASE;
				end if;
					---
				if (ne82_lock = RELEASED and ne32_used = '0' and ne32_state = OCCUPIED) then 
					ne32_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw09_command <= RELEASE;
				Sw04_command <= RELEASE;
				Sw05_command <= RELEASE;
				ne84_command <= RELEASE;
				ne82_command <= RELEASE;
				ne32_command <= RELEASE;
				T14_command <= RELEASE;
				C100_command <= RELEASE;
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