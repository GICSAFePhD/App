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
			ne49_state : in nodeStates;
			ne49_lock : in objectLock;
			ne49_command : out routeCommands;
			ne48_state : in nodeStates;
			ne48_lock : in objectLock;
			ne48_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			Sw27_state : in singleSwitchStates;
			Sw27_lock : in objectLock;
			Sw27_command : out routeCommands;
			Sw29_state : in singleSwitchStates;
			Sw29_lock : in objectLock;
			Sw29_command : out routeCommands;
			C39_state : in signalStates;
			C39_lock : in objectLock;
			C39_command : out routeCommands;
			J24_state : in signalStates;
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
	signal ne49_used , ne48_used , ne40_used : std_logic := '0';
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
				if ((ne49_lock = RELEASED and ne48_lock = RELEASED and ne40_lock = RELEASED) and (ne49_state = FREE and ne48_state = FREE and ne40_state = FREE)) then
					ne49_command <= RESERVE;
					ne48_command <= RESERVE;
					ne40_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne49_lock = RESERVED and ne48_lock = RESERVED and ne40_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne49_lock = RESERVED and ne48_lock = RESERVED and ne40_lock = RESERVED) and (ne49_state = FREE and ne48_state = FREE and ne40_state = FREE)) then
					ne49_command <= LOCK;
					ne48_command <= LOCK;
					ne40_command <= LOCK;
					restart <= '0';
				end if;
				if (ne49_lock = LOCKED and ne48_lock = LOCKED and ne40_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (Sw27_lock = RELEASED and Sw29_lock = RELEASED) then
					Sw27_command <= RESERVE;
					Sw29_command <= RESERVE;
					restart <= '0';
				end if;
				if (Sw27_lock = RESERVED and Sw29_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (Sw27_lock = RELEASED and Sw29_lock = RELEASED and Sw27_state = REVERSE and Sw29_state = NORMAL) then
					Sw27_command <= LOCK;
					Sw29_command <= LOCK;
					restart <= '0';
				end if;
				if (Sw27_lock = LOCKED and Sw29_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (C39_lock = RELEASED) then
					C39_command <= RESERVE;
				end if;
				if (C39_lock = RESERVED and C39_state /= RED) then
					restart <= '0';
					routeState <= '1';
					C39_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne49_used = '0' and ne49_state = OCCUPIED) then 
					ne49_used <= '1';
				end if;
				if (ne49_used = '1' and ne49_state = FREE) then
					ne49_used <= '0';
					ne49_command <= RELEASE;
				end if;
				if (ne48_used = '0' and ne48_state = OCCUPIED) then 
					ne48_used <= '1';
				end if;
				if (ne48_used = '1' and ne48_state = FREE) then
					ne48_used <= '0';
					ne48_command <= RELEASE;
				end if;
				if (ne40_used = '0' and ne40_state = OCCUPIED) then 
					ne40_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw27_command <= RELEASE;
				Sw29_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne49_command <= RELEASE;
				ne48_command <= RELEASE;
				ne40_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;