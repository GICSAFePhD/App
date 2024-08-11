--  route_61.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R62 ['70W02', '71W01'] 
--dw  R62 [] 
--sc  R62 [] 
--lc  R62 [] 
	entity route_61 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne44 : in hex_char;
			ne44_command : out routeCommands := RELEASE;
			track_ne102 : in hex_char;
			ne102_command : out routeCommands := RELEASE;
			track_ne65 : in hex_char;
			ne65_command : out routeCommands := RELEASE;
			track_ne26 : in hex_char;
			ne26_command : out routeCommands := RELEASE;
			s70W02_state : in hex_char;
			s70W02_command : out routeCommands := RELEASE;
			s71W01_state : in hex_char;
			s71W01_command : out routeCommands := RELEASE;
			S105_state : in hex_char;
			S105_command : out routeCommands := RELEASE;
			S93_state : in hex_char;
			S93_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_61;
architecture Behavioral of route_61 is
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
	signal ne44_used , ne102_used , ne65_used , ne26_used : std_logic := '0';
	signal ne44_state : nodeStates := FREE;
	signal ne44_lock : objectLock := RELEASED;
	signal ne102_state : nodeStates := FREE;
	signal ne102_lock : objectLock := RELEASED;
	signal ne65_state : nodeStates := FREE;
	signal ne65_lock : objectLock := RELEASED;
	signal ne26_state : nodeStates := FREE;
	signal ne26_lock : objectLock := RELEASED;
	signal s70W02_position : singleSwitchStates := NORMAL;
	signal s70W02_lock : objectLock := RELEASED;
	signal s71W01_position : singleSwitchStates := NORMAL;
	signal s71W01_lock : objectLock := RELEASED;
	signal S105_aspectIn : signalStates := RED;
	signal S105_lock: objectLock := RELEASED;
	signal S93_aspectIn : signalStates := RED;
	signal S93_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne44_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne44)(2 to 3))));
	ne44_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne44)(0 to 1))));
	ne102_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne102)(2 to 3))));
	ne102_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne102)(0 to 1))));
	ne65_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne65)(2 to 3))));
	ne65_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne65)(0 to 1))));
	ne26_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne26)(2 to 3))));
	ne26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne26)(0 to 1))));
	s70W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s70W02_state)(2 to 3))));
	s70W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s70W02_state)(0 to 1))));
	s71W01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s71W01_state)(2 to 3))));
	s71W01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s71W01_state)(0 to 1))));
	S105_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S105_state)(2 to 3))));
	S105_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S105_state)(0 to 1))));
	S93_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S93_state)(2 to 3))));
	S93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S93_state)(0 to 1))));
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
				if ((ne44_lock = RELEASED and ne102_lock = RELEASED and ne65_lock = RELEASED and ne26_lock = RELEASED) and (ne102_state = FREE and ne65_state = FREE and ne26_state = FREE)) then
					ne44_command <= RESERVE;
					ne102_command <= RESERVE;
					ne65_command <= RESERVE;
					ne26_command <= RESERVE;
				end if;
				if (ne44_lock = RESERVED and ne102_lock = RESERVED and ne65_lock = RESERVED and ne26_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne44_lock = RESERVED and ne102_lock = RESERVED and ne65_lock = RESERVED and ne26_lock = RESERVED) and (ne102_state = FREE and ne65_state = FREE and ne26_state = FREE)) then
					ne44_command <= LOCK;
					ne102_command <= LOCK;
					ne65_command <= LOCK;
					ne26_command <= LOCK;
				end if;
				if (ne44_lock = LOCKED and ne102_lock = LOCKED and ne65_lock = LOCKED and ne26_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s70W02_lock = RELEASED and s71W01_lock = RELEASED) then
					s70W02_command <= RESERVE;
					s71W01_command <= RESERVE;
				end if;
				if (s70W02_lock = RESERVED and s71W01_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s70W02_lock = RESERVED and s71W01_lock = RESERVED) then
					s70W02_command <= LOCK;
					s71W01_command <= LOCK;
				end if;
				if (s70W02_lock = LOCKED and s71W01_lock = LOCKED)then
					ne44_used <= '0';
					ne102_used <= '0';
					ne65_used <= '0';
					ne26_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S105_lock = RELEASED and S93_lock = RELEASED) then
					S105_command <= RESERVE;
					S93_command <= LOCK;
				end if;
				if (S105_lock = RESERVED and S93_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne44_used = '0' and ne44_state = OCCUPIED) then 
					ne44_used <= '1';
				end if;
				if (ne44_used = '1' and ne44_state = FREE) then
					ne44_used <= '0';
					ne44_command <= RELEASE;
				end if;
					---
				if (ne44_lock = RELEASED and ne102_used = '0' and ne102_state = OCCUPIED) then 
					ne102_used <= '1';
				end if;
				if (ne102_used = '1' and ne102_state = FREE) then
					ne102_used <= '0';
					ne102_command <= RELEASE;
				end if;
					---
				if (ne102_lock = RELEASED and ne65_used = '0' and ne65_state = OCCUPIED) then 
					ne65_used <= '1';
				end if;
				if (ne65_used = '1' and ne65_state = FREE) then
					ne65_used <= '0';
					ne65_command <= RELEASE;
				end if;
					---
				if (ne65_lock = RELEASED and ne26_used = '0' and ne26_state = OCCUPIED) then 
					ne26_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s70W02_command <= RELEASE;
				s71W01_command <= RELEASE;
				ne44_command <= RELEASE;
				ne102_command <= RELEASE;
				ne65_command <= RELEASE;
				ne26_command <= RELEASE;
				S105_command <= RELEASE;
				S93_command <= RELEASE;
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