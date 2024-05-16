--  route_118.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_118 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne44_state : in nodeStates;
			ne44_lock : in objectLock;
			ne44_command : out routeCommands;
			ne102_state : in nodeStates;
			ne102_lock : in objectLock;
			ne102_command : out routeCommands;
			ne65_state : in nodeStates;
			ne65_lock : in objectLock;
			ne65_command : out routeCommands;
			ne26_state : in nodeStates;
			ne26_lock : in objectLock;
			ne26_command : out routeCommands;
			s71W01_state : in singleSwitchStates;
			s71W01_lock : in objectLock;
			s71W01_command : out routeCommands;
			C107_state : in signalStates;
			C107_lock : in objectLock;
			C107_command : out routeCommands;
			C88_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_118;
architecture Behavioral of route_118 is
	component flipFlop is
		port(
			clock : in std_logic;
			reset : in std_logic;
			Q : out std_logic
		);
	end component flipFlop;
	signal restart : std_logic := '0';
	signal Q : std_logic_vector(27 downto 0) := (others => '0');
	signal routingState : routeStates;
	signal ne44_used , ne102_used , ne65_used , ne26_used : std_logic := '0';
begin
	gen : for i in 0 to 26 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;
	Q(0) <= clock;

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
		case routingState is
			when WAITING_COMMAND =>
				restart <= '0';
				routeState <= '0';
				if (routeRequest = '1') then
					routingState <= RESERVING_TRACKS;
				end if;
			when RESERVING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne44_lock = RELEASED and ne102_lock = RELEASED and ne65_lock = RELEASED and ne26_lock = RELEASED) and (ne44_state = FREE and ne102_state = FREE and ne65_state = FREE and ne26_state = FREE)) then
					ne44_command <= RESERVE;
					ne102_command <= RESERVE;
					ne65_command <= RESERVE;
					ne26_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne44_lock = RESERVED and ne102_lock = RESERVED and ne65_lock = RESERVED and ne26_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne44_lock = RESERVED and ne102_lock = RESERVED and ne65_lock = RESERVED and ne26_lock = RESERVED) and (ne44_state = FREE and ne102_state = FREE and ne65_state = FREE and ne26_state = FREE)) then
					ne44_command <= LOCK;
					ne102_command <= LOCK;
					ne65_command <= LOCK;
					ne26_command <= LOCK;
					restart <= '0';
				end if;
				if (ne44_lock = LOCKED and ne102_lock = LOCKED and ne65_lock = LOCKED and ne26_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (s71W01_lock = RELEASED) then
					s71W01_command <= RESERVE;
					restart <= '0';
				end if;
				if (s71W01_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (s71W01_lock = RELEASED and s71W01_state = NORMAL) then
					s71W01_command <= LOCK;
					restart <= '0';
				end if;
				if (s71W01_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (C107_lock = RELEASED) then
					C107_command <= RESERVE;
				end if;
				if (C107_lock = RESERVED and C107_state /= RED) then
					restart <= '0';
					routeState <= '1';
					C107_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne44_used = '0' and ne44_state = OCCUPIED) then 
					ne44_used <= '1';
				end if;
				if (ne44_used = '1' and ne44_state = FREE) then
					ne44_used <= '0';
					ne44_command <= RELEASE;
				end if;
				if (ne102_used = '0' and ne102_state = OCCUPIED) then 
					ne102_used <= '1';
				end if;
				if (ne102_used = '1' and ne102_state = FREE) then
					ne102_used <= '0';
					ne102_command <= RELEASE;
				end if;
				if (ne65_used = '0' and ne65_state = OCCUPIED) then 
					ne65_used <= '1';
				end if;
				if (ne65_used = '1' and ne65_state = FREE) then
					ne65_used <= '0';
					ne65_command <= RELEASE;
				end if;
				if (ne26_used = '0' and ne26_state = OCCUPIED) then 
					ne26_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s71W01_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne44_command <= RELEASE;
				ne102_command <= RELEASE;
				ne65_command <= RELEASE;
				ne26_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;