--  route_128.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_128 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne78_state : in nodeStates;
			ne78_lock : in objectLock;
			ne78_command : out routeCommands;
			ne79_state : in nodeStates;
			ne79_lock : in objectLock;
			ne79_command : out routeCommands;
			ne77_state : in nodeStates;
			ne77_lock : in objectLock;
			ne77_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_lock : in objectLock;
			Sw06_command : out routeCommands;
			Sw07_state : in doubleSwitchStates;
			Sw07_lock : in objectLock;
			Sw07_command : out routeCommands;
			H112_state : in signalStates;
			H112_lock : in objectLock;
			H112_command : out routeCommands;
			B133_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_128;
architecture Behavioral of route_128 is
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
	signal ne78_used , ne79_used , ne77_used : std_logic := '0';
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
				if ((ne78_lock = RELEASED and ne79_lock = RELEASED and ne77_lock = RELEASED) and (ne78_state = FREE and ne79_state = FREE and ne77_state = FREE)) then
					ne78_command <= RESERVE;
					ne79_command <= RESERVE;
					ne77_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne78_lock = RESERVED and ne79_lock = RESERVED and ne77_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne78_lock = RESERVED and ne79_lock = RESERVED and ne77_lock = RESERVED) and (ne78_state = FREE and ne79_state = FREE and ne77_state = FREE)) then
					ne78_command <= LOCK;
					ne79_command <= LOCK;
					ne77_command <= LOCK;
					restart <= '0';
				end if;
				if (ne78_lock = LOCKED and ne79_lock = LOCKED and ne77_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (Sw06_lock = RELEASED and Sw07_lock = RELEASED) then
					Sw06_command <= RESERVE;
					Sw07_command <= RESERVE;
					restart <= '0';
				end if;
				if (Sw06_lock = RESERVED and Sw07_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (Sw06_lock = RELEASED and Sw07_lock = RELEASED and Sw06_state = REVERSE and Sw07_state = DOUBLE_REVERSE) then
					Sw06_command <= LOCK;
					Sw07_command <= LOCK;
					restart <= '0';
				end if;
				if (Sw06_lock = LOCKED and Sw07_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (H112_lock = RELEASED) then
					H112_command <= RESERVE;
				end if;
				if (H112_lock = RESERVED and H112_state /= RED) then
					restart <= '0';
					routeState <= '1';
					H112_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne78_used = '0' and ne78_state = OCCUPIED) then 
					ne78_used <= '1';
				end if;
				if (ne78_used = '1' and ne78_state = FREE) then
					ne78_used <= '0';
					ne78_command <= RELEASE;
				end if;
				if (ne79_used = '0' and ne79_state = OCCUPIED) then 
					ne79_used <= '1';
				end if;
				if (ne79_used = '1' and ne79_state = FREE) then
					ne79_used <= '0';
					ne79_command <= RELEASE;
				end if;
				if (ne77_used = '0' and ne77_state = OCCUPIED) then 
					ne77_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw06_command <= RELEASE;
				Sw07_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne78_command <= RELEASE;
				ne79_command <= RELEASE;
				ne77_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;