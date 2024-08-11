--  route_79.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R80 ['D18', 'Sw01'] 
--dw  R80 [] 
--sc  R80 [] 
--lc  R80 [] 
	entity route_79 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne992 : in hex_char;
			ne992_command : out routeCommands := RELEASE;
			track_ne65 : in hex_char;
			ne65_command : out routeCommands := RELEASE;
			D18_state : in hex_char;
			D18_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			S120_state : in hex_char;
			S120_command : out routeCommands := RELEASE;
			C94_state : in hex_char;
			C94_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_79;
architecture Behavioral of route_79 is
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
	signal ne992_used , ne65_used : std_logic := '0';
	signal ne992_state : nodeStates := FREE;
	signal ne992_lock : objectLock := RELEASED;
	signal ne65_state : nodeStates := FREE;
	signal ne65_lock : objectLock := RELEASED;
	signal D18_position : singleSwitchStates := NORMAL;
	signal D18_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
	signal S120_aspectIn : signalStates := RED;
	signal S120_lock: objectLock := RELEASED;
	signal C94_aspectIn : signalStates := RED;
	signal C94_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne992_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne992)(2 to 3))));
	ne992_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne992)(0 to 1))));
	ne65_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne65)(2 to 3))));
	ne65_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne65)(0 to 1))));
	D18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D18_state)(2 to 3))));
	D18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D18_state)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	S120_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S120_state)(2 to 3))));
	S120_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S120_state)(0 to 1))));
	C94_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C94_state)(2 to 3))));
	C94_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C94_state)(0 to 1))));
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
				if ((ne992_lock = RELEASED and ne65_lock = RELEASED) and (ne65_state = FREE)) then
					ne992_command <= RESERVE;
					ne65_command <= RESERVE;
				end if;
				if (ne992_lock = RESERVED and ne65_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne992_lock = RESERVED and ne65_lock = RESERVED) and (ne65_state = FREE)) then
					ne992_command <= LOCK;
					ne65_command <= LOCK;
				end if;
				if (ne992_lock = LOCKED and ne65_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D18_lock = RELEASED and Sw01_lock = RELEASED) then
					D18_command <= RESERVE;
					Sw01_command <= RESERVE;
				end if;
				if (D18_lock = RESERVED and Sw01_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D18_lock = RESERVED and Sw01_lock = RESERVED) then
					D18_command <= LOCK;
					Sw01_command <= LOCK;
				end if;
				if (D18_lock = LOCKED and Sw01_lock = LOCKED)then
					ne992_used <= '0';
					ne65_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S120_lock = RELEASED and C94_lock = RELEASED) then
					S120_command <= RESERVE;
					C94_command <= LOCK;
				end if;
				if (S120_lock = RESERVED and C94_lock = LOCKED) then
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
				if (ne992_lock = RELEASED and ne65_used = '0' and ne65_state = OCCUPIED) then 
					ne65_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D18_command <= RELEASE;
				Sw01_command <= RELEASE;
				ne992_command <= RELEASE;
				ne65_command <= RELEASE;
				S120_command <= RELEASE;
				C94_command <= RELEASE;
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