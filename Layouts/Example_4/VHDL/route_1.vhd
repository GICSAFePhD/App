--  route_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne377_state : in nodeStates;
			ne377_lock : in objectLock;
			ne377_command : out routeCommands;
			ne111_state : in nodeStates;
			ne111_lock : in objectLock;
			ne111_command : out routeCommands;
			ne290_state : in nodeStates;
			ne290_lock : in objectLock;
			ne290_command : out routeCommands;
			D14_state : in singleSwitchStates;
			D14_lock : in objectLock;
			D14_command : out routeCommands;
			D15_state : in singleSwitchStates;
			D15_lock : in objectLock;
			D15_command : out routeCommands;
			T04_state : in signalStates;
			T04_lock : in objectLock;
			T04_command : out routeCommands;
			J35_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_1;
architecture Behavioral of route_1 is
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
	signal ne377_used , ne111_used , ne290_used : std_logic := '0';
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
				if ((ne377_lock = RELEASED and ne111_lock = RELEASED and ne290_lock = RELEASED) and (ne377_state = FREE and ne111_state = FREE and ne290_state = FREE)) then
					ne377_command <= RESERVE;
					ne111_command <= RESERVE;
					ne290_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne377_lock = RESERVED and ne111_lock = RESERVED and ne290_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne377_lock = RESERVED and ne111_lock = RESERVED and ne290_lock = RESERVED) and (ne377_state = FREE and ne111_state = FREE and ne290_state = FREE)) then
					ne377_command <= LOCK;
					ne111_command <= LOCK;
					ne290_command <= LOCK;
					restart <= '0';
				end if;
				if (ne377_lock = LOCKED and ne111_lock = LOCKED and ne290_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (D14_lock = RELEASED and D15_lock = RELEASED) then
					D14_command <= RESERVE;
					D15_command <= RESERVE;
					restart <= '0';
				end if;
				if (D14_lock = RESERVED and D15_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (D14_lock = RELEASED and D15_lock = RELEASED and D14_state = REVERSE and D15_state = REVERSE) then
					D14_command <= LOCK;
					D15_command <= LOCK;
					restart <= '0';
				end if;
				if (D14_lock = LOCKED and D15_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (T04_lock = RELEASED) then
					T04_command <= RESERVE;
				end if;
				if (T04_lock = RESERVED and T04_state /= RED) then
					restart <= '0';
					routeState <= '1';
					T04_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne377_used = '0' and ne377_state = OCCUPIED) then 
					ne377_used <= '1';
				end if;
				if (ne377_used = '1' and ne377_state = FREE) then
					ne377_used <= '0';
					ne377_command <= RELEASE;
				end if;
				if (ne111_used = '0' and ne111_state = OCCUPIED) then 
					ne111_used <= '1';
				end if;
				if (ne111_used = '1' and ne111_state = FREE) then
					ne111_used <= '0';
					ne111_command <= RELEASE;
				end if;
				if (ne290_used = '0' and ne290_state = OCCUPIED) then 
					ne290_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D14_command <= RELEASE;
				D15_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne377_command <= RELEASE;
				ne111_command <= RELEASE;
				ne290_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;