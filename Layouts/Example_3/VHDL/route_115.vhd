--  route_115.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_115 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne44_state : in nodeStates;
			ne44_lock : in objectLock;
			ne44_command : out routeCommands;
			ne43_state : in nodeStates;
			ne43_lock : in objectLock;
			ne43_command : out routeCommands;
			ne48_state : in nodeStates;
			ne48_lock : in objectLock;
			ne48_command : out routeCommands;
			s71W01_state : in singleSwitchStates;
			s71W01_lock : in objectLock;
			s71W01_command : out routeCommands;
			s71W02_state : in singleSwitchStates;
			s71W02_lock : in objectLock;
			s71W02_command : out routeCommands;
			H106_state : in signalStates;
			H106_lock : in objectLock;
			H106_command : out routeCommands;
			L29_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_115;
architecture Behavioral of route_115 is
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
	signal ne44_used , ne43_used , ne48_used : std_logic := '0';
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
				if ((ne44_lock = RELEASED and ne43_lock = RELEASED and ne48_lock = RELEASED) and (ne44_state = FREE and ne43_state = FREE and ne48_state = FREE)) then
					ne44_command <= RESERVE;
					ne43_command <= RESERVE;
					ne48_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne44_lock = RESERVED and ne43_lock = RESERVED and ne48_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne44_lock = RESERVED and ne43_lock = RESERVED and ne48_lock = RESERVED) and (ne44_state = FREE and ne43_state = FREE and ne48_state = FREE)) then
					ne44_command <= LOCK;
					ne43_command <= LOCK;
					ne48_command <= LOCK;
					restart <= '0';
				end if;
				if (ne44_lock = LOCKED and ne43_lock = LOCKED and ne48_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (s71W01_lock = RELEASED and s71W02_lock = RELEASED) then
					s71W01_command <= RESERVE;
					s71W02_command <= RESERVE;
					restart <= '0';
				end if;
				if (s71W01_lock = RESERVED and s71W02_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (s71W01_lock = RELEASED and s71W02_lock = RELEASED and s71W01_state = REVERSE and s71W02_state = NORMAL) then
					s71W01_command <= LOCK;
					s71W02_command <= LOCK;
					restart <= '0';
				end if;
				if (s71W01_lock = LOCKED and s71W02_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (H106_lock = RELEASED) then
					H106_command <= RESERVE;
				end if;
				if (H106_lock = RESERVED and H106_state /= RED) then
					restart <= '0';
					routeState <= '1';
					H106_command <= LOCK;
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
				if (ne43_used = '0' and ne43_state = OCCUPIED) then 
					ne43_used <= '1';
				end if;
				if (ne43_used = '1' and ne43_state = FREE) then
					ne43_used <= '0';
					ne43_command <= RELEASE;
				end if;
				if (ne48_used = '0' and ne48_state = OCCUPIED) then 
					ne48_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s71W01_command <= RELEASE;
				s71W02_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne44_command <= RELEASE;
				ne43_command <= RELEASE;
				ne48_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;