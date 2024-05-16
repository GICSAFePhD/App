--  route_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne465_state : in nodeStates;
			ne465_lock : in objectLock;
			ne465_command : out routeCommands;
			ne131_state : in nodeStates;
			ne131_lock : in objectLock;
			ne131_command : out routeCommands;
			ne912_state : in nodeStates;
			ne912_lock : in objectLock;
			ne912_command : out routeCommands;
			D20_state : in singleSwitchStates;
			D20_lock : in objectLock;
			D20_command : out routeCommands;
			D21_state : in singleSwitchStates;
			D21_lock : in objectLock;
			D21_command : out routeCommands;
			T10_state : in signalStates;
			T10_lock : in objectLock;
			T10_command : out routeCommands;
			J45_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_7;
architecture Behavioral of route_7 is
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
	signal ne465_used , ne131_used , ne912_used : std_logic := '0';
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
				if ((ne465_lock = RELEASED and ne131_lock = RELEASED and ne912_lock = RELEASED) and (ne465_state = FREE and ne131_state = FREE and ne912_state = FREE)) then
					ne465_command <= RESERVE;
					ne131_command <= RESERVE;
					ne912_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne465_lock = RESERVED and ne131_lock = RESERVED and ne912_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne465_lock = RESERVED and ne131_lock = RESERVED and ne912_lock = RESERVED) and (ne465_state = FREE and ne131_state = FREE and ne912_state = FREE)) then
					ne465_command <= LOCK;
					ne131_command <= LOCK;
					ne912_command <= LOCK;
					restart <= '0';
				end if;
				if (ne465_lock = LOCKED and ne131_lock = LOCKED and ne912_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (D20_lock = RELEASED and D21_lock = RELEASED) then
					D20_command <= RESERVE;
					D21_command <= RESERVE;
					restart <= '0';
				end if;
				if (D20_lock = RESERVED and D21_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (D20_lock = RELEASED and D21_lock = RELEASED and D20_state = REVERSE and D21_state = REVERSE) then
					D20_command <= LOCK;
					D21_command <= LOCK;
					restart <= '0';
				end if;
				if (D20_lock = LOCKED and D21_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (T10_lock = RELEASED) then
					T10_command <= RESERVE;
				end if;
				if (T10_lock = RESERVED and T10_state /= RED) then
					restart <= '0';
					routeState <= '1';
					T10_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne465_used = '0' and ne465_state = OCCUPIED) then 
					ne465_used <= '1';
				end if;
				if (ne465_used = '1' and ne465_state = FREE) then
					ne465_used <= '0';
					ne465_command <= RELEASE;
				end if;
				if (ne131_used = '0' and ne131_state = OCCUPIED) then 
					ne131_used <= '1';
				end if;
				if (ne131_used = '1' and ne131_state = FREE) then
					ne131_used <= '0';
					ne131_command <= RELEASE;
				end if;
				if (ne912_used = '0' and ne912_state = OCCUPIED) then 
					ne912_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D20_command <= RELEASE;
				D21_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne465_command <= RELEASE;
				ne131_command <= RELEASE;
				ne912_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;