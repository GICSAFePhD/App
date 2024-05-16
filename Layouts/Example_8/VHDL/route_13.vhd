--  route_13.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			ne27_state : in nodeStates;
			ne27_lock : in objectLock;
			ne27_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_lock : in objectLock;
			Lc06_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_lock : in objectLock;
			Sw11_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			S25_state : in signalStates;
			S25_lock : in objectLock;
			S25_command : out routeCommands;
			X12_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_13;
architecture Behavioral of route_13 is
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
	signal ne3_used , ne27_used , ne23_used : std_logic := '0';
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
				if ((ne3_lock = RELEASED and ne27_lock = RELEASED and ne23_lock = RELEASED) and (ne3_state = FREE and ne27_state = FREE and ne23_state = FREE)) then
					ne3_command <= RESERVE;
					ne27_command <= RESERVE;
					ne23_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne3_lock = RESERVED and ne27_lock = RESERVED and ne23_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne3_lock = RESERVED and ne27_lock = RESERVED and ne23_lock = RESERVED) and (ne3_state = FREE and ne27_state = FREE and ne23_state = FREE)) then
					ne3_command <= LOCK;
					ne27_command <= LOCK;
					ne23_command <= LOCK;
					restart <= '0';
				end if;
				if (ne3_lock = LOCKED and ne27_lock = LOCKED and ne23_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (Lc06_lock = RELEASED) then
					Lc06_command <= RESERVE;
					restart <= '0';
				end if;
				if (Sw11_lock = RELEASED and Sw12_lock = RELEASED) then
					Sw11_command <= RESERVE;
					Sw12_command <= RESERVE;
					restart <= '0';
				end if;
				if (Lc06_lock = RESERVED and Sw11_lock = RESERVED and Sw12_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (Lc06_lock = RESERVED and Lc06_state = DOWN) then
					Lc06_command <= LOCK;
					restart <= '0';
				end if;
				if (Sw11_lock = RELEASED and Sw12_lock = RELEASED and Sw11_state = REVERSE and Sw12_state = REVERSE) then
					Sw11_command <= LOCK;
					Sw12_command <= LOCK;
					restart <= '0';
				end if;
				if (Lc06_lock = LOCKED and Sw11_lock = LOCKED and Sw12_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (S25_lock = RELEASED) then
					S25_command <= RESERVE;
				end if;
				if (S25_lock = RESERVED and S25_state /= RED) then
					restart <= '0';
					routeState <= '1';
					S25_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne3_used = '0' and ne3_state = OCCUPIED) then 
					ne3_used <= '1';
				end if;
				if (ne3_used = '1' and ne3_state = FREE) then
					ne3_used <= '0';
					ne3_command <= RELEASE;
				end if;
				if (ne27_used = '0' and ne27_state = OCCUPIED) then 
					ne27_used <= '1';
				end if;
				if (ne27_used = '1' and ne27_state = FREE) then
					ne27_used <= '0';
					ne27_command <= RELEASE;
				end if;
				if (ne23_used = '0' and ne23_state = OCCUPIED) then 
					ne23_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc06_command <= RELEASE;
				Sw11_command <= RELEASE;
				Sw12_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne3_command <= RELEASE;
				ne27_command <= RELEASE;
				ne23_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;