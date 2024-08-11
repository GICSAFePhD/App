--  route_64.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R65 ['D05', 'D18'] 
--dw  R65 [] 
--sc  R65 [] 
--lc  R65 [] 
	entity route_64 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne65 : in hex_char;
			ne65_command : out routeCommands := RELEASE;
			track_ne63 : in hex_char;
			ne63_command : out routeCommands := RELEASE;
			D05_state : in hex_char;
			D05_command : out routeCommands := RELEASE;
			D18_state : in hex_char;
			D18_command : out routeCommands := RELEASE;
			C94_state : in hex_char;
			C94_command : out routeCommands := RELEASE;
			C54_state : in hex_char;
			C54_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_64;
architecture Behavioral of route_64 is
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
	signal ne65_used , ne63_used : std_logic := '0';
	signal ne65_state : nodeStates := FREE;
	signal ne65_lock : objectLock := RELEASED;
	signal ne63_state : nodeStates := FREE;
	signal ne63_lock : objectLock := RELEASED;
	signal D05_position : singleSwitchStates := NORMAL;
	signal D05_lock : objectLock := RELEASED;
	signal D18_position : singleSwitchStates := NORMAL;
	signal D18_lock : objectLock := RELEASED;
	signal C94_aspectIn : signalStates := RED;
	signal C94_lock: objectLock := RELEASED;
	signal C54_aspectIn : signalStates := RED;
	signal C54_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne65_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne65)(2 to 3))));
	ne65_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne65)(0 to 1))));
	ne63_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne63)(2 to 3))));
	ne63_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne63)(0 to 1))));
	D05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D05_state)(2 to 3))));
	D05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D05_state)(0 to 1))));
	D18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D18_state)(2 to 3))));
	D18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D18_state)(0 to 1))));
	C94_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C94_state)(2 to 3))));
	C94_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C94_state)(0 to 1))));
	C54_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C54_state)(2 to 3))));
	C54_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C54_state)(0 to 1))));
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
				if ((ne65_lock = RELEASED and ne63_lock = RELEASED) and (ne63_state = FREE)) then
					ne65_command <= RESERVE;
					ne63_command <= RESERVE;
				end if;
				if (ne65_lock = RESERVED and ne63_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne65_lock = RESERVED and ne63_lock = RESERVED) and (ne63_state = FREE)) then
					ne65_command <= LOCK;
					ne63_command <= LOCK;
				end if;
				if (ne65_lock = LOCKED and ne63_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D05_lock = RELEASED and D18_lock = RELEASED) then
					D05_command <= RESERVE;
					D18_command <= RESERVE;
				end if;
				if (D05_lock = RESERVED and D18_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D05_lock = RESERVED and D18_lock = RESERVED) then
					D05_command <= LOCK;
					D18_command <= LOCK;
				end if;
				if (D05_lock = LOCKED and D18_lock = LOCKED)then
					ne65_used <= '0';
					ne63_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (C94_lock = RELEASED and C54_lock = RELEASED) then
					C94_command <= RESERVE;
					C54_command <= LOCK;
				end if;
				if (C94_lock = RESERVED and C54_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne65_used = '0' and ne65_state = OCCUPIED) then 
					ne65_used <= '1';
				end if;
				if (ne65_used = '1' and ne65_state = FREE) then
					ne65_used <= '0';
					ne65_command <= RELEASE;
				end if;
					---
				if (ne65_lock = RELEASED and ne63_used = '0' and ne63_state = OCCUPIED) then 
					ne63_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D05_command <= RELEASE;
				D18_command <= RELEASE;
				ne65_command <= RELEASE;
				ne63_command <= RELEASE;
				C94_command <= RELEASE;
				C54_command <= RELEASE;
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