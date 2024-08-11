--  route_80.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R81 ['Sw01', 'D07', 'Sw05'] 
--dw  R81 [] 
--sc  R81 [] 
--lc  R81 [] 
	entity route_80 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne992 : in hex_char;
			ne992_command : out routeCommands := RELEASE;
			track_ne994 : in hex_char;
			ne994_command : out routeCommands := RELEASE;
			track_ne400 : in hex_char;
			ne400_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			D07_state : in hex_char;
			D07_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			S120_state : in hex_char;
			S120_command : out routeCommands := RELEASE;
			S74_state : in hex_char;
			S74_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_80;
architecture Behavioral of route_80 is
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
	signal ne992_used , ne994_used , ne400_used : std_logic := '0';
	signal ne992_state : nodeStates := FREE;
	signal ne992_lock : objectLock := RELEASED;
	signal ne994_state : nodeStates := FREE;
	signal ne994_lock : objectLock := RELEASED;
	signal ne400_state : nodeStates := FREE;
	signal ne400_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
	signal D07_position : singleSwitchStates := NORMAL;
	signal D07_lock : objectLock := RELEASED;
	signal Sw05_position : singleSwitchStates := NORMAL;
	signal Sw05_lock : objectLock := RELEASED;
	signal S120_aspectIn : signalStates := RED;
	signal S120_lock: objectLock := RELEASED;
	signal S74_aspectIn : signalStates := RED;
	signal S74_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne992_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne992)(2 to 3))));
	ne992_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne992)(0 to 1))));
	ne994_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne994)(2 to 3))));
	ne994_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne994)(0 to 1))));
	ne400_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne400)(2 to 3))));
	ne400_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne400)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	D07_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D07_state)(2 to 3))));
	D07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D07_state)(0 to 1))));
	Sw05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	S120_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S120_state)(2 to 3))));
	S120_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S120_state)(0 to 1))));
	S74_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S74_state)(2 to 3))));
	S74_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S74_state)(0 to 1))));
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
				if ((ne992_lock = RELEASED and ne994_lock = RELEASED and ne400_lock = RELEASED) and (ne994_state = FREE and ne400_state = FREE)) then
					ne992_command <= RESERVE;
					ne994_command <= RESERVE;
					ne400_command <= RESERVE;
				end if;
				if (ne992_lock = RESERVED and ne994_lock = RESERVED and ne400_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne992_lock = RESERVED and ne994_lock = RESERVED and ne400_lock = RESERVED) and (ne994_state = FREE and ne400_state = FREE)) then
					ne992_command <= LOCK;
					ne994_command <= LOCK;
					ne400_command <= LOCK;
				end if;
				if (ne992_lock = LOCKED and ne994_lock = LOCKED and ne400_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw01_lock = RELEASED and D07_lock = RELEASED and Sw05_lock = RELEASED) then
					Sw01_command <= RESERVE;
					D07_command <= RESERVE;
					Sw05_command <= RESERVE;
				end if;
				if (Sw01_lock = RESERVED and D07_lock = RESERVED and Sw05_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw01_lock = RESERVED and D07_lock = RESERVED and Sw05_lock = RESERVED) then
					Sw01_command <= LOCK;
					D07_command <= LOCK;
					Sw05_command <= LOCK;
				end if;
				if (Sw01_lock = LOCKED and D07_lock = LOCKED and Sw05_lock = LOCKED)then
					ne992_used <= '0';
					ne994_used <= '0';
					ne400_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S120_lock = RELEASED and S74_lock = RELEASED) then
					S120_command <= RESERVE;
					S74_command <= LOCK;
				end if;
				if (S120_lock = RESERVED and S74_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne992_used = '0' and ne992_state = OCCUPIED) then 
					ne992_used <= '1';
				end if;
				if (ne992_used = '1' and ne992_state = FREE) then
					ne992_used <= '0';
					ne992_command <= RELEASE;
				end if;
					---
				if (ne992_lock = RELEASED and ne994_used = '0' and ne994_state = OCCUPIED) then 
					ne994_used <= '1';
				end if;
				if (ne994_used = '1' and ne994_state = FREE) then
					ne994_used <= '0';
					ne994_command <= RELEASE;
				end if;
					---
				if (ne994_lock = RELEASED and ne400_used = '0' and ne400_state = OCCUPIED) then 
					ne400_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw01_command <= RELEASE;
				D07_command <= RELEASE;
				Sw05_command <= RELEASE;
				ne992_command <= RELEASE;
				ne994_command <= RELEASE;
				ne400_command <= RELEASE;
				S120_command <= RELEASE;
				S74_command <= RELEASE;
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