--  route_38.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
--XXX ['Sw12_state = REVERSE', 'Sw13_state = REVERSE', 'Sw04_state = NORMAL'] | ['Sw12', 'Sw13', 'Sw04'] 
--YYY None | None 
	entity route_38 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			ne24_state : in nodeStates;
			ne24_lock : in objectLock;
			ne24_command : out routeCommands;
			ne8_state : in nodeStates;
			ne8_lock : in objectLock;
			ne8_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_lock : in objectLock;
			Sw13_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			S35_state : in signalStates;
			S35_lock : in objectLock;
			S35_command : out routeCommands;
			C21_state : in signalStates;
			C21_lock : in objectLock;
			C21_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_38;
architecture Behavioral of route_38 is
	component flipFlop is
		port(
			clock : in std_logic;
			reset : in std_logic;
			Q : out std_logic
		);
	end component flipFlop;
	signal restart : std_logic := '0';
	signal Q : std_logic_vector(27 downto 0) := (others => '0');
	signal routingState : routeStates := WAITING_COMMAND;
	signal ne12_used , ne24_used , ne8_used : std_logic := '0';
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
				if (routeRequest = '1') then
					routeState <= '1';
					routingState <= RESERVING_TRACKS;
				end if;
			when RESERVING_TRACKS =>
				if ((ne12_lock = RELEASED and ne24_lock = RELEASED and ne8_lock = RELEASED) and (ne12_state = FREE and ne24_state = FREE and ne8_state = FREE)) then
					restart <= '0';
					ne12_command <= RESERVE;
					ne24_command <= RESERVE;
					ne8_command <= RESERVE;
				end if;
				if (ne12_lock = RESERVED and ne24_lock = RESERVED and ne8_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if ((ne12_lock = RESERVED and ne24_lock = RESERVED and ne8_lock = RESERVED) and (ne12_state = FREE and ne24_state = FREE and ne8_state = FREE)) then
					restart <= '0';
					ne12_command <= LOCK;
					ne24_command <= LOCK;
					ne8_command <= LOCK;
				end if;
				if (ne12_lock = LOCKED and ne24_lock = LOCKED and ne8_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (Sw12_lock = RELEASED and Sw13_lock = RELEASED and Sw04_lock = RELEASED) then
					restart <= '0';
					Sw12_command <= RESERVE;
					Sw13_command <= RESERVE;
					Sw04_command <= RESERVE;
				end if;
				if (Sw12_lock = RESERVED and Sw13_lock = RESERVED and Sw04_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (Sw12_lock = RESERVED and Sw13_lock = RESERVED and Sw04_lock = RESERVED) then
					restart <= '0';
					Sw12_command <= LOCK;
					Sw13_command <= LOCK;
					Sw04_command <= LOCK;
					routeState <= '0';
				end if;
				if (Sw12_lock = LOCKED and Sw13_lock = LOCKED and Sw04_lock = LOCKED)then
					restart <= '1';
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (S35_lock = RELEASED) then
					S35_command <= RESERVE;
				end if;
				if (S35_lock = RESERVED) then
					restart <= '0';
					S35_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne12_used = '0' and ne12_state = OCCUPIED) then 
					ne12_used <= '1';
				end if;
				if (ne12_used = '1' and ne12_state = FREE) then
					ne12_used <= '0';
					ne12_command <= RELEASE;
				end if;
				if (ne24_used = '0' and ne24_state = OCCUPIED) then 
					ne24_used <= '1';
				end if;
				if (ne24_used = '1' and ne24_state = FREE) then
					ne24_used <= '0';
					ne24_command <= RELEASE;
				end if;
				if (ne8_used = '0' and ne8_state = OCCUPIED) then 
					ne8_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw12_command <= RELEASE;
				Sw13_command <= RELEASE;
				Sw04_command <= RELEASE;
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne12_command <= RELEASE;
				ne24_command <= RELEASE;
				ne8_command <= RELEASE;
				routingState <= WAITING_COMMAND;
			when others =>
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;