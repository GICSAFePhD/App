--  route_51.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_51 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne123_state : in nodeStates;
			ne123_lock : in objectLock;
			ne123_command : out routeCommands;
			ne407_state : in nodeStates;
			ne407_lock : in objectLock;
			ne407_command : out routeCommands;
			ne400_state : in nodeStates;
			ne400_lock : in objectLock;
			ne400_command : out routeCommands;
			D07_state : in singleSwitchStates;
			D07_lock : in objectLock;
			D07_command : out routeCommands;
			D16_state : in singleSwitchStates;
			D16_lock : in objectLock;
			D16_command : out routeCommands;
			B77_state : in signalStates;
			B77_lock : in objectLock;
			B77_command : out routeCommands;
			S123_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_51;
architecture Behavioral of route_51 is
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
	signal ne123_used , ne407_used , ne400_used : std_logic := '0';
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
				if ((ne123_lock = RELEASED and ne407_lock = RELEASED and ne400_lock = RELEASED) and (ne123_state = FREE and ne407_state = FREE and ne400_state = FREE)) then
					ne123_command <= RESERVE;
					ne407_command <= RESERVE;
					ne400_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne123_lock = RESERVED and ne407_lock = RESERVED and ne400_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne123_lock = RESERVED and ne407_lock = RESERVED and ne400_lock = RESERVED) and (ne123_state = FREE and ne407_state = FREE and ne400_state = FREE)) then
					ne123_command <= LOCK;
					ne407_command <= LOCK;
					ne400_command <= LOCK;
					restart <= '0';
				end if;
				if (ne123_lock = LOCKED and ne407_lock = LOCKED and ne400_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (D07_lock = RELEASED and D16_lock = RELEASED) then
					D07_command <= RESERVE;
					D16_command <= RESERVE;
					restart <= '0';
				end if;
				if (D07_lock = RESERVED and D16_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (D07_lock = RELEASED and D16_lock = RELEASED and D07_state = REVERSE and D16_state = NORMAL) then
					D07_command <= LOCK;
					D16_command <= LOCK;
					restart <= '0';
				end if;
				if (D07_lock = LOCKED and D16_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (B77_lock = RELEASED) then
					B77_command <= RESERVE;
				end if;
				if (B77_lock = RESERVED and B77_state /= RED) then
					restart <= '0';
					routeState <= '1';
					B77_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne123_used = '0' and ne123_state = OCCUPIED) then 
					ne123_used <= '1';
				end if;
				if (ne123_used = '1' and ne123_state = FREE) then
					ne123_used <= '0';
					ne123_command <= RELEASE;
				end if;
				if (ne407_used = '0' and ne407_state = OCCUPIED) then 
					ne407_used <= '1';
				end if;
				if (ne407_used = '1' and ne407_state = FREE) then
					ne407_used <= '0';
					ne407_command <= RELEASE;
				end if;
				if (ne400_used = '0' and ne400_state = OCCUPIED) then 
					ne400_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D07_command <= RELEASE;
				D16_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne123_command <= RELEASE;
				ne407_command <= RELEASE;
				ne400_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;