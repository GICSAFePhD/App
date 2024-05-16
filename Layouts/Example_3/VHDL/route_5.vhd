--  route_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne84_state : in nodeStates;
			ne84_lock : in objectLock;
			ne84_command : out routeCommands;
			ne85_state : in nodeStates;
			ne85_lock : in objectLock;
			ne85_command : out routeCommands;
			ne100_state : in nodeStates;
			ne100_lock : in objectLock;
			ne100_command : out routeCommands;
			ne101_state : in nodeStates;
			ne101_lock : in objectLock;
			ne101_command : out routeCommands;
			ne44_state : in nodeStates;
			ne44_lock : in objectLock;
			ne44_command : out routeCommands;
			Sw05_state : in doubleSwitchStates;
			Sw05_lock : in objectLock;
			Sw05_command : out routeCommands;
			Sw41_state : in singleSwitchStates;
			Sw41_lock : in objectLock;
			Sw41_command : out routeCommands;
			T14_state : in signalStates;
			T14_lock : in objectLock;
			T14_command : out routeCommands;
			S105_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_5;
architecture Behavioral of route_5 is
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
	signal ne84_used , ne85_used , ne100_used , ne101_used , ne44_used : std_logic := '0';
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
				if ((ne84_lock = RELEASED and ne85_lock = RELEASED and ne100_lock = RELEASED and ne101_lock = RELEASED and ne44_lock = RELEASED) and (ne84_state = FREE and ne85_state = FREE and ne100_state = FREE and ne101_state = FREE and ne44_state = FREE)) then
					ne84_command <= RESERVE;
					ne85_command <= RESERVE;
					ne100_command <= RESERVE;
					ne101_command <= RESERVE;
					ne44_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne84_lock = RESERVED and ne85_lock = RESERVED and ne100_lock = RESERVED and ne101_lock = RESERVED and ne44_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne84_lock = RESERVED and ne85_lock = RESERVED and ne100_lock = RESERVED and ne101_lock = RESERVED and ne44_lock = RESERVED) and (ne84_state = FREE and ne85_state = FREE and ne100_state = FREE and ne101_state = FREE and ne44_state = FREE)) then
					ne84_command <= LOCK;
					ne85_command <= LOCK;
					ne100_command <= LOCK;
					ne101_command <= LOCK;
					ne44_command <= LOCK;
					restart <= '0';
				end if;
				if (ne84_lock = LOCKED and ne85_lock = LOCKED and ne100_lock = LOCKED and ne101_lock = LOCKED and ne44_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (Sw05_lock = RELEASED and Sw41_lock = RELEASED) then
					Sw05_command <= RESERVE;
					Sw41_command <= RESERVE;
					restart <= '0';
				end if;
				if (Sw05_lock = RESERVED and Sw41_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (Sw05_lock = RELEASED and Sw41_lock = RELEASED and Sw05_state = NORMAL_REVERSE and Sw41_state = REVERSE) then
					Sw05_command <= LOCK;
					Sw41_command <= LOCK;
					restart <= '0';
				end if;
				if (Sw05_lock = LOCKED and Sw41_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (T14_lock = RELEASED) then
					T14_command <= RESERVE;
				end if;
				if (T14_lock = RESERVED and T14_state /= RED) then
					restart <= '0';
					routeState <= '1';
					T14_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne84_used = '0' and ne84_state = OCCUPIED) then 
					ne84_used <= '1';
				end if;
				if (ne84_used = '1' and ne84_state = FREE) then
					ne84_used <= '0';
					ne84_command <= RELEASE;
				end if;
				if (ne85_used = '0' and ne85_state = OCCUPIED) then 
					ne85_used <= '1';
				end if;
				if (ne85_used = '1' and ne85_state = FREE) then
					ne85_used <= '0';
					ne85_command <= RELEASE;
				end if;
				if (ne100_used = '0' and ne100_state = OCCUPIED) then 
					ne100_used <= '1';
				end if;
				if (ne100_used = '1' and ne100_state = FREE) then
					ne100_used <= '0';
					ne100_command <= RELEASE;
				end if;
				if (ne101_used = '0' and ne101_state = OCCUPIED) then 
					ne101_used <= '1';
				end if;
				if (ne101_used = '1' and ne101_state = FREE) then
					ne101_used <= '0';
					ne101_command <= RELEASE;
				end if;
				if (ne44_used = '0' and ne44_state = OCCUPIED) then 
					ne44_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw05_command <= RELEASE;
				Sw41_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne84_command <= RELEASE;
				ne85_command <= RELEASE;
				ne100_command <= RELEASE;
				ne101_command <= RELEASE;
				ne44_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;