--  route_89.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_89 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne77_state : in nodeStates;
			ne77_lock : in objectLock;
			ne77_command : out routeCommands;
			ne94_state : in nodeStates;
			ne94_lock : in objectLock;
			ne94_command : out routeCommands;
			ne97_state : in nodeStates;
			ne97_lock : in objectLock;
			ne97_command : out routeCommands;
			ne99_state : in nodeStates;
			ne99_lock : in objectLock;
			ne99_command : out routeCommands;
			Sw07_state : in doubleSwitchStates;
			Sw07_lock : in objectLock;
			Sw07_command : out routeCommands;
			B145_state : in signalStates;
			B145_lock : in objectLock;
			B145_command : out routeCommands;
			P69_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_89;
architecture Behavioral of route_89 is
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
	signal ne77_used , ne94_used , ne97_used , ne99_used : std_logic := '0';
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
				if ((ne77_lock = RELEASED and ne94_lock = RELEASED and ne97_lock = RELEASED and ne99_lock = RELEASED) and (ne77_state = FREE and ne94_state = FREE and ne97_state = FREE and ne99_state = FREE)) then
					ne77_command <= RESERVE;
					ne94_command <= RESERVE;
					ne97_command <= RESERVE;
					ne99_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne77_lock = RESERVED and ne94_lock = RESERVED and ne97_lock = RESERVED and ne99_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne77_lock = RESERVED and ne94_lock = RESERVED and ne97_lock = RESERVED and ne99_lock = RESERVED) and (ne77_state = FREE and ne94_state = FREE and ne97_state = FREE and ne99_state = FREE)) then
					ne77_command <= LOCK;
					ne94_command <= LOCK;
					ne97_command <= LOCK;
					ne99_command <= LOCK;
					restart <= '0';
				end if;
				if (ne77_lock = LOCKED and ne94_lock = LOCKED and ne97_lock = LOCKED and ne99_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (Sw07_lock = RELEASED) then
					Sw07_command <= RESERVE;
					restart <= '0';
				end if;
				if (Sw07_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (Sw07_lock = RELEASED and Sw07_state = NORMAL_REVERSE) then
					Sw07_command <= LOCK;
					restart <= '0';
				end if;
				if (Sw07_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (B145_lock = RELEASED) then
					B145_command <= RESERVE;
				end if;
				if (B145_lock = RESERVED and B145_state /= RED) then
					restart <= '0';
					routeState <= '1';
					B145_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne77_used = '0' and ne77_state = OCCUPIED) then 
					ne77_used <= '1';
				end if;
				if (ne77_used = '1' and ne77_state = FREE) then
					ne77_used <= '0';
					ne77_command <= RELEASE;
				end if;
				if (ne94_used = '0' and ne94_state = OCCUPIED) then 
					ne94_used <= '1';
				end if;
				if (ne94_used = '1' and ne94_state = FREE) then
					ne94_used <= '0';
					ne94_command <= RELEASE;
				end if;
				if (ne97_used = '0' and ne97_state = OCCUPIED) then 
					ne97_used <= '1';
				end if;
				if (ne97_used = '1' and ne97_state = FREE) then
					ne97_used <= '0';
					ne97_command <= RELEASE;
				end if;
				if (ne99_used = '0' and ne99_state = OCCUPIED) then 
					ne99_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw07_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne77_command <= RELEASE;
				ne94_command <= RELEASE;
				ne97_command <= RELEASE;
				ne99_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;