--  route_76.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_76 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne127_state : in nodeStates;
			ne127_lock : in objectLock;
			ne127_command : out routeCommands;
			ne135_state : in nodeStates;
			ne135_lock : in objectLock;
			ne135_command : out routeCommands;
			ne910_state : in nodeStates;
			ne910_lock : in objectLock;
			ne910_command : out routeCommands;
			ne101_state : in nodeStates;
			ne101_lock : in objectLock;
			ne101_command : out routeCommands;
			D09_state : in singleSwitchStates;
			D09_lock : in objectLock;
			D09_command : out routeCommands;
			D10_state : in singleSwitchStates;
			D10_lock : in objectLock;
			D10_command : out routeCommands;
			D24_state : in singleSwitchStates;
			D24_lock : in objectLock;
			D24_command : out routeCommands;
			S117_state : in signalStates;
			S117_lock : in objectLock;
			S117_command : out routeCommands;
			J43_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_76;
architecture Behavioral of route_76 is
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
	signal ne127_used , ne135_used , ne910_used , ne101_used : std_logic := '0';
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
				if ((ne127_lock = RELEASED and ne135_lock = RELEASED and ne910_lock = RELEASED and ne101_lock = RELEASED) and (ne127_state = FREE and ne135_state = FREE and ne910_state = FREE and ne101_state = FREE)) then
					ne127_command <= RESERVE;
					ne135_command <= RESERVE;
					ne910_command <= RESERVE;
					ne101_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne127_lock = RESERVED and ne135_lock = RESERVED and ne910_lock = RESERVED and ne101_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne127_lock = RESERVED and ne135_lock = RESERVED and ne910_lock = RESERVED and ne101_lock = RESERVED) and (ne127_state = FREE and ne135_state = FREE and ne910_state = FREE and ne101_state = FREE)) then
					ne127_command <= LOCK;
					ne135_command <= LOCK;
					ne910_command <= LOCK;
					ne101_command <= LOCK;
					restart <= '0';
				end if;
				if (ne127_lock = LOCKED and ne135_lock = LOCKED and ne910_lock = LOCKED and ne101_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (D09_lock = RELEASED and D10_lock = RELEASED and D24_lock = RELEASED) then
					D09_command <= RESERVE;
					D10_command <= RESERVE;
					D24_command <= RESERVE;
					restart <= '0';
				end if;
				if (D09_lock = RESERVED and D10_lock = RESERVED and D24_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (D09_lock = RELEASED and D10_lock = RELEASED and D24_lock = RELEASED and D09_state = REVERSE and D10_state = REVERSE and D24_state = NORMAL) then
					D09_command <= LOCK;
					D10_command <= LOCK;
					D24_command <= LOCK;
					restart <= '0';
				end if;
				if (D09_lock = LOCKED and D10_lock = LOCKED and D24_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (S117_lock = RELEASED) then
					S117_command <= RESERVE;
				end if;
				if (S117_lock = RESERVED and S117_state /= RED) then
					restart <= '0';
					routeState <= '1';
					S117_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne127_used = '0' and ne127_state = OCCUPIED) then 
					ne127_used <= '1';
				end if;
				if (ne127_used = '1' and ne127_state = FREE) then
					ne127_used <= '0';
					ne127_command <= RELEASE;
				end if;
				if (ne135_used = '0' and ne135_state = OCCUPIED) then 
					ne135_used <= '1';
				end if;
				if (ne135_used = '1' and ne135_state = FREE) then
					ne135_used <= '0';
					ne135_command <= RELEASE;
				end if;
				if (ne910_used = '0' and ne910_state = OCCUPIED) then 
					ne910_used <= '1';
				end if;
				if (ne910_used = '1' and ne910_state = FREE) then
					ne910_used <= '0';
					ne910_command <= RELEASE;
				end if;
				if (ne101_used = '0' and ne101_state = OCCUPIED) then 
					ne101_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D09_command <= RELEASE;
				D10_command <= RELEASE;
				D24_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne127_command <= RELEASE;
				ne135_command <= RELEASE;
				ne910_command <= RELEASE;
				ne101_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;