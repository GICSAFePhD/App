--  route_50.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_50 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne404_state : in nodeStates;
			ne404_lock : in objectLock;
			ne404_command : out routeCommands;
			ne61_state : in nodeStates;
			ne61_lock : in objectLock;
			ne61_command : out routeCommands;
			ne99_state : in nodeStates;
			ne99_lock : in objectLock;
			ne99_command : out routeCommands;
			ne98_state : in nodeStates;
			ne98_lock : in objectLock;
			ne98_command : out routeCommands;
			D05_state : in singleSwitchStates;
			D05_lock : in objectLock;
			D05_command : out routeCommands;
			D08_state : in singleSwitchStates;
			D08_lock : in objectLock;
			D08_command : out routeCommands;
			C76_state : in signalStates;
			C76_lock : in objectLock;
			C76_command : out routeCommands;
			X51_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_50;
architecture Behavioral of route_50 is
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
	signal ne404_used , ne61_used , ne99_used , ne98_used : std_logic := '0';
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
				if ((ne404_lock = RELEASED and ne61_lock = RELEASED and ne99_lock = RELEASED and ne98_lock = RELEASED) and (ne404_state = FREE and ne61_state = FREE and ne99_state = FREE and ne98_state = FREE)) then
					ne404_command <= RESERVE;
					ne61_command <= RESERVE;
					ne99_command <= RESERVE;
					ne98_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne404_lock = RESERVED and ne61_lock = RESERVED and ne99_lock = RESERVED and ne98_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne404_lock = RESERVED and ne61_lock = RESERVED and ne99_lock = RESERVED and ne98_lock = RESERVED) and (ne404_state = FREE and ne61_state = FREE and ne99_state = FREE and ne98_state = FREE)) then
					ne404_command <= LOCK;
					ne61_command <= LOCK;
					ne99_command <= LOCK;
					ne98_command <= LOCK;
					restart <= '0';
				end if;
				if (ne404_lock = LOCKED and ne61_lock = LOCKED and ne99_lock = LOCKED and ne98_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (D05_lock = RELEASED and D08_lock = RELEASED) then
					D05_command <= RESERVE;
					D08_command <= RESERVE;
					restart <= '0';
				end if;
				if (D05_lock = RESERVED and D08_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (D05_lock = RELEASED and D08_lock = RELEASED and D05_state = REVERSE and D08_state = NORMAL) then
					D05_command <= LOCK;
					D08_command <= LOCK;
					restart <= '0';
				end if;
				if (D05_lock = LOCKED and D08_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (C76_lock = RELEASED) then
					C76_command <= RESERVE;
				end if;
				if (C76_lock = RESERVED and C76_state /= RED) then
					restart <= '0';
					routeState <= '1';
					C76_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne404_used = '0' and ne404_state = OCCUPIED) then 
					ne404_used <= '1';
				end if;
				if (ne404_used = '1' and ne404_state = FREE) then
					ne404_used <= '0';
					ne404_command <= RELEASE;
				end if;
				if (ne61_used = '0' and ne61_state = OCCUPIED) then 
					ne61_used <= '1';
				end if;
				if (ne61_used = '1' and ne61_state = FREE) then
					ne61_used <= '0';
					ne61_command <= RELEASE;
				end if;
				if (ne99_used = '0' and ne99_state = OCCUPIED) then 
					ne99_used <= '1';
				end if;
				if (ne99_used = '1' and ne99_state = FREE) then
					ne99_used <= '0';
					ne99_command <= RELEASE;
				end if;
				if (ne98_used = '0' and ne98_state = OCCUPIED) then 
					ne98_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D05_command <= RELEASE;
				D08_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne404_command <= RELEASE;
				ne61_command <= RELEASE;
				ne99_command <= RELEASE;
				ne98_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;