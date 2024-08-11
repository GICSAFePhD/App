--  route_83.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R84 ['71W01', '71W02', 'Sw41'] 
--dw  R84 [] 
--sc  R84 [] 
--lc  R84 [] 
	entity route_83 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne110 : in hex_char;
			ne110_command : out routeCommands := RELEASE;
			track_ne100 : in hex_char;
			ne100_command : out routeCommands := RELEASE;
			track_ne101 : in hex_char;
			ne101_command : out routeCommands := RELEASE;
			track_ne44 : in hex_char;
			ne44_command : out routeCommands := RELEASE;
			s71W01_state : in hex_char;
			s71W01_command : out routeCommands := RELEASE;
			s71W02_state : in hex_char;
			s71W02_command : out routeCommands := RELEASE;
			Sw41_state : in hex_char;
			Sw41_command : out routeCommands := RELEASE;
			C138_state : in hex_char;
			C138_command : out routeCommands := RELEASE;
			S105_state : in hex_char;
			S105_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_83;
architecture Behavioral of route_83 is
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
	signal ne110_used , ne100_used , ne101_used , ne44_used : std_logic := '0';
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal ne44_state : nodeStates := FREE;
	signal ne44_lock : objectLock := RELEASED;
	signal s71W01_position : singleSwitchStates := NORMAL;
	signal s71W01_lock : objectLock := RELEASED;
	signal s71W02_position : singleSwitchStates := NORMAL;
	signal s71W02_lock : objectLock := RELEASED;
	signal Sw41_position : singleSwitchStates := NORMAL;
	signal Sw41_lock : objectLock := RELEASED;
	signal C138_aspectIn : signalStates := RED;
	signal C138_lock: objectLock := RELEASED;
	signal S105_aspectIn : signalStates := RED;
	signal S105_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	ne44_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne44)(2 to 3))));
	ne44_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne44)(0 to 1))));
	s71W01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s71W01_state)(2 to 3))));
	s71W01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s71W01_state)(0 to 1))));
	s71W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s71W02_state)(2 to 3))));
	s71W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s71W02_state)(0 to 1))));
	Sw41_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw41_state)(2 to 3))));
	Sw41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw41_state)(0 to 1))));
	C138_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C138_state)(2 to 3))));
	C138_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C138_state)(0 to 1))));
	S105_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S105_state)(2 to 3))));
	S105_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S105_state)(0 to 1))));
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
				if ((ne110_lock = RELEASED and ne100_lock = RELEASED and ne101_lock = RELEASED and ne44_lock = RELEASED) and (ne100_state = FREE and ne101_state = FREE and ne44_state = FREE)) then
					ne110_command <= RESERVE;
					ne100_command <= RESERVE;
					ne101_command <= RESERVE;
					ne44_command <= RESERVE;
				end if;
				if (ne110_lock = RESERVED and ne100_lock = RESERVED and ne101_lock = RESERVED and ne44_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne110_lock = RESERVED and ne100_lock = RESERVED and ne101_lock = RESERVED and ne44_lock = RESERVED) and (ne100_state = FREE and ne101_state = FREE and ne44_state = FREE)) then
					ne110_command <= LOCK;
					ne100_command <= LOCK;
					ne101_command <= LOCK;
					ne44_command <= LOCK;
				end if;
				if (ne110_lock = LOCKED and ne100_lock = LOCKED and ne101_lock = LOCKED and ne44_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s71W01_lock = RELEASED and s71W02_lock = RELEASED and Sw41_lock = RELEASED) then
					s71W01_command <= RESERVE;
					s71W02_command <= RESERVE;
					Sw41_command <= RESERVE;
				end if;
				if (s71W01_lock = RESERVED and s71W02_lock = RESERVED and Sw41_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s71W01_lock = RESERVED and s71W02_lock = RESERVED and Sw41_lock = RESERVED) then
					s71W01_command <= LOCK;
					s71W02_command <= LOCK;
					Sw41_command <= LOCK;
				end if;
				if (s71W01_lock = LOCKED and s71W02_lock = LOCKED and Sw41_lock = LOCKED)then
					ne110_used <= '0';
					ne100_used <= '0';
					ne101_used <= '0';
					ne44_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (C138_lock = RELEASED and S105_lock = RELEASED) then
					C138_command <= RESERVE;
					S105_command <= LOCK;
				end if;
				if (C138_lock = RESERVED and S105_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne110_used = '0' and ne110_state = OCCUPIED) then 
					ne110_used <= '1';
				end if;
				if (ne110_used = '1' and ne110_state = FREE) then
					ne110_used <= '0';
					ne110_command <= RELEASE;
				end if;
					---
				if (ne110_lock = RELEASED and ne100_used = '0' and ne100_state = OCCUPIED) then 
					ne100_used <= '1';
				end if;
				if (ne100_used = '1' and ne100_state = FREE) then
					ne100_used <= '0';
					ne100_command <= RELEASE;
				end if;
					---
				if (ne100_lock = RELEASED and ne101_used = '0' and ne101_state = OCCUPIED) then 
					ne101_used <= '1';
				end if;
				if (ne101_used = '1' and ne101_state = FREE) then
					ne101_used <= '0';
					ne101_command <= RELEASE;
				end if;
					---
				if (ne101_lock = RELEASED and ne44_used = '0' and ne44_state = OCCUPIED) then 
					ne44_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s71W01_command <= RELEASE;
				s71W02_command <= RELEASE;
				Sw41_command <= RELEASE;
				ne110_command <= RELEASE;
				ne100_command <= RELEASE;
				ne101_command <= RELEASE;
				ne44_command <= RELEASE;
				C138_command <= RELEASE;
				S105_command <= RELEASE;
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