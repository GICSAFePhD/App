--  route_40.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_40 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne295_state : in nodeStates;
			ne295_lock : in objectLock;
			ne295_command : out routeCommands;
			ne288_state : in nodeStates;
			ne288_lock : in objectLock;
			ne288_command : out routeCommands;
			ne991_state : in nodeStates;
			ne991_lock : in objectLock;
			ne991_command : out routeCommands;
			D01_state : in singleSwitchStates;
			D01_lock : in objectLock;
			D01_command : out routeCommands;
			D03_state : in singleSwitchStates;
			D03_lock : in objectLock;
			D03_command : out routeCommands;
			C67_state : in signalStates;
			C67_lock : in objectLock;
			C67_command : out routeCommands;
			T01_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_40;
architecture Behavioral of route_40 is
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
	signal ne295_used , ne288_used , ne991_used : std_logic := '0';
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
				if ((ne295_lock = RELEASED and ne288_lock = RELEASED and ne991_lock = RELEASED) and (ne295_state = FREE and ne288_state = FREE and ne991_state = FREE)) then
					ne295_command <= RESERVE;
					ne288_command <= RESERVE;
					ne991_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne295_lock = RESERVED and ne288_lock = RESERVED and ne991_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne295_lock = RESERVED and ne288_lock = RESERVED and ne991_lock = RESERVED) and (ne295_state = FREE and ne288_state = FREE and ne991_state = FREE)) then
					ne295_command <= LOCK;
					ne288_command <= LOCK;
					ne991_command <= LOCK;
					restart <= '0';
				end if;
				if (ne295_lock = LOCKED and ne288_lock = LOCKED and ne991_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (D01_lock = RELEASED and D03_lock = RELEASED) then
					D01_command <= RESERVE;
					D03_command <= RESERVE;
					restart <= '0';
				end if;
				if (D01_lock = RESERVED and D03_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (D01_lock = RELEASED and D03_lock = RELEASED and D01_state = REVERSE and D03_state = NORMAL) then
					D01_command <= LOCK;
					D03_command <= LOCK;
					restart <= '0';
				end if;
				if (D01_lock = LOCKED and D03_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (C67_lock = RELEASED) then
					C67_command <= RESERVE;
				end if;
				if (C67_lock = RESERVED and C67_state /= RED) then
					restart <= '0';
					routeState <= '1';
					C67_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne295_used = '0' and ne295_state = OCCUPIED) then 
					ne295_used <= '1';
				end if;
				if (ne295_used = '1' and ne295_state = FREE) then
					ne295_used <= '0';
					ne295_command <= RELEASE;
				end if;
				if (ne288_used = '0' and ne288_state = OCCUPIED) then 
					ne288_used <= '1';
				end if;
				if (ne288_used = '1' and ne288_state = FREE) then
					ne288_used <= '0';
					ne288_command <= RELEASE;
				end if;
				if (ne991_used = '0' and ne991_state = OCCUPIED) then 
					ne991_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D01_command <= RELEASE;
				D03_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne295_command <= RELEASE;
				ne288_command <= RELEASE;
				ne991_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;