--  route_25.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
--XXX ['Sw06_state = NORMAL', 'Sw13_state = NORMAL'] | ['Sw06', 'Sw13'] 
--YYY None | None 
	entity route_25 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			Lc08_state : in levelCrossingStates;
			Lc08_lock : in objectLock;
			Lc08_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_lock : in objectLock;
			Sw06_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_lock : in objectLock;
			Sw13_command : out routeCommands;
			S27_state : in signalStates;
			S27_lock : in objectLock;
			S27_command : out routeCommands;
			S35_state : in signalStates;
			S35_lock : in objectLock;
			S35_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_25;
architecture Behavioral of route_25 is
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
	signal ne2_used , ne12_used : std_logic := '0';
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
				if ((ne2_lock = RELEASED and ne12_lock = RELEASED) and (ne2_state = FREE and ne12_state = FREE)) then
					restart <= '0';
					ne2_command <= RESERVE;
					ne12_command <= RESERVE;
				end if;
				if (ne2_lock = RESERVED and ne12_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if ((ne2_lock = RESERVED and ne12_lock = RESERVED) and (ne2_state = FREE and ne12_state = FREE)) then
					restart <= '0';
					ne2_command <= LOCK;
					ne12_command <= LOCK;
				end if;
				if (ne2_lock = LOCKED and ne12_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (Lc08_lock = RELEASED and Sw06_lock = RELEASED and Sw13_lock = RELEASED) then
					restart <= '0';
					Lc08_command <= RESERVE;
					Sw06_command <= RESERVE;
					Sw13_command <= RESERVE;
				end if;
				if (Lc08_lock = RESERVED and Sw06_lock = RESERVED and Sw13_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (Lc08_lock = RESERVED and Sw06_lock = RESERVED and Sw13_lock = RESERVED) then
					restart <= '0';
					Lc08_command <= LOCK;
					Sw06_command <= LOCK;
					Sw13_command <= LOCK;
					routeState <= '0';
				end if;
				if (Lc08_lock = LOCKED and Sw06_lock = LOCKED and Sw13_lock = LOCKED)then
					restart <= '1';
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (S27_lock = RELEASED) then
					S27_command <= RESERVE;
				end if;
				if (S27_lock = RESERVED) then
					restart <= '0';
					S27_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne2_used = '0' and ne2_state = OCCUPIED) then 
					ne2_used <= '1';
				end if;
				if (ne2_used = '1' and ne2_state = FREE) then
					ne2_used <= '0';
					ne2_command <= RELEASE;
				end if;
				if (ne12_used = '0' and ne12_state = OCCUPIED) then 
					ne12_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc08_command <= RELEASE;
				Sw06_command <= RELEASE;
				Sw13_command <= RELEASE;
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne2_command <= RELEASE;
				ne12_command <= RELEASE;
				routingState <= WAITING_COMMAND;
			when others =>
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;