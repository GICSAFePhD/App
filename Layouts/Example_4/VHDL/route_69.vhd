--  route_69.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_69 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne114_state : in nodeStates;
			ne114_lock : in objectLock;
			ne114_command : out routeCommands;
			ne129_state : in nodeStates;
			ne129_lock : in objectLock;
			ne129_command : out routeCommands;
			ne130_state : in nodeStates;
			ne130_lock : in objectLock;
			ne130_command : out routeCommands;
			D23_state : in singleSwitchStates;
			D23_lock : in objectLock;
			D23_command : out routeCommands;
			D12_state : in doubleSwitchStates;
			D12_lock : in objectLock;
			D12_command : out routeCommands;
			S101_state : in signalStates;
			S101_lock : in objectLock;
			S101_command : out routeCommands;
			C79_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_69;
architecture Behavioral of route_69 is
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
	signal ne114_used , ne129_used , ne130_used : std_logic := '0';
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
				if ((ne114_lock = RELEASED and ne129_lock = RELEASED and ne130_lock = RELEASED) and (ne114_state = FREE and ne129_state = FREE and ne130_state = FREE)) then
					ne114_command <= RESERVE;
					ne129_command <= RESERVE;
					ne130_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne114_lock = RESERVED and ne129_lock = RESERVED and ne130_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne114_lock = RESERVED and ne129_lock = RESERVED and ne130_lock = RESERVED) and (ne114_state = FREE and ne129_state = FREE and ne130_state = FREE)) then
					ne114_command <= LOCK;
					ne129_command <= LOCK;
					ne130_command <= LOCK;
					restart <= '0';
				end if;
				if (ne114_lock = LOCKED and ne129_lock = LOCKED and ne130_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (D23_lock = RELEASED and D12_lock = RELEASED) then
					D23_command <= RESERVE;
					D12_command <= RESERVE;
					restart <= '0';
				end if;
				if (D23_lock = RESERVED and D12_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (D23_lock = RELEASED and D12_lock = RELEASED and D23_state = REVERSE and D12_state = NORMAL_REVERSE) then
					D23_command <= LOCK;
					D12_command <= LOCK;
					restart <= '0';
				end if;
				if (D23_lock = LOCKED and D12_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (S101_lock = RELEASED) then
					S101_command <= RESERVE;
				end if;
				if (S101_lock = RESERVED and S101_state /= RED) then
					restart <= '0';
					routeState <= '1';
					S101_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne114_used = '0' and ne114_state = OCCUPIED) then 
					ne114_used <= '1';
				end if;
				if (ne114_used = '1' and ne114_state = FREE) then
					ne114_used <= '0';
					ne114_command <= RELEASE;
				end if;
				if (ne129_used = '0' and ne129_state = OCCUPIED) then 
					ne129_used <= '1';
				end if;
				if (ne129_used = '1' and ne129_state = FREE) then
					ne129_used <= '0';
					ne129_command <= RELEASE;
				end if;
				if (ne130_used = '0' and ne130_state = OCCUPIED) then 
					ne130_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D23_command <= RELEASE;
				D12_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne114_command <= RELEASE;
				ne129_command <= RELEASE;
				ne130_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;