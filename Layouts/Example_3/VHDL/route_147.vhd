--  route_147.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_147 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne86_state : in nodeStates;
			ne86_lock : in objectLock;
			ne86_command : out routeCommands;
			ne87_state : in nodeStates;
			ne87_lock : in objectLock;
			ne87_command : out routeCommands;
			ne91_state : in nodeStates;
			ne91_lock : in objectLock;
			ne91_command : out routeCommands;
			ne30_state : in nodeStates;
			ne30_lock : in objectLock;
			ne30_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_lock : in objectLock;
			Sw11_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_lock : in objectLock;
			Sw13_command : out routeCommands;
			H120_state : in signalStates;
			H120_lock : in objectLock;
			H120_command : out routeCommands;
			S97_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_147;
architecture Behavioral of route_147 is
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
	signal ne86_used , ne87_used , ne91_used , ne30_used : std_logic := '0';
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
				if ((ne86_lock = RELEASED and ne87_lock = RELEASED and ne91_lock = RELEASED and ne30_lock = RELEASED) and (ne86_state = FREE and ne87_state = FREE and ne91_state = FREE and ne30_state = FREE)) then
					ne86_command <= RESERVE;
					ne87_command <= RESERVE;
					ne91_command <= RESERVE;
					ne30_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne86_lock = RESERVED and ne87_lock = RESERVED and ne91_lock = RESERVED and ne30_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne86_lock = RESERVED and ne87_lock = RESERVED and ne91_lock = RESERVED and ne30_lock = RESERVED) and (ne86_state = FREE and ne87_state = FREE and ne91_state = FREE and ne30_state = FREE)) then
					ne86_command <= LOCK;
					ne87_command <= LOCK;
					ne91_command <= LOCK;
					ne30_command <= LOCK;
					restart <= '0';
				end if;
				if (ne86_lock = LOCKED and ne87_lock = LOCKED and ne91_lock = LOCKED and ne30_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (Sw11_lock = RELEASED and Sw12_lock = RELEASED and Sw13_lock = RELEASED) then
					Sw11_command <= RESERVE;
					Sw12_command <= RESERVE;
					Sw13_command <= RESERVE;
					restart <= '0';
				end if;
				if (Sw11_lock = RESERVED and Sw12_lock = RESERVED and Sw13_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (Sw11_lock = RELEASED and Sw12_lock = RELEASED and Sw13_lock = RELEASED and Sw11_state = REVERSE and Sw12_state = REVERSE and Sw13_state = NORMAL) then
					Sw11_command <= LOCK;
					Sw12_command <= LOCK;
					Sw13_command <= LOCK;
					restart <= '0';
				end if;
				if (Sw11_lock = LOCKED and Sw12_lock = LOCKED and Sw13_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (H120_lock = RELEASED) then
					H120_command <= RESERVE;
				end if;
				if (H120_lock = RESERVED and H120_state /= RED) then
					restart <= '0';
					routeState <= '1';
					H120_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne86_used = '0' and ne86_state = OCCUPIED) then 
					ne86_used <= '1';
				end if;
				if (ne86_used = '1' and ne86_state = FREE) then
					ne86_used <= '0';
					ne86_command <= RELEASE;
				end if;
				if (ne87_used = '0' and ne87_state = OCCUPIED) then 
					ne87_used <= '1';
				end if;
				if (ne87_used = '1' and ne87_state = FREE) then
					ne87_used <= '0';
					ne87_command <= RELEASE;
				end if;
				if (ne91_used = '0' and ne91_state = OCCUPIED) then 
					ne91_used <= '1';
				end if;
				if (ne91_used = '1' and ne91_state = FREE) then
					ne91_used <= '0';
					ne91_command <= RELEASE;
				end if;
				if (ne30_used = '0' and ne30_state = OCCUPIED) then 
					ne30_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw11_command <= RELEASE;
				Sw12_command <= RELEASE;
				Sw13_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne86_command <= RELEASE;
				ne87_command <= RELEASE;
				ne91_command <= RELEASE;
				ne30_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;