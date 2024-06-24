--  route_39.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
--XXX ['Sw13_state = NORMAL'] | ['Sw13'] 
--YYY None | None 
	entity route_39 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_lock : in objectLock;
			Sw13_command : out routeCommands;
			H36_state : in signalStates;
			H36_lock : in objectLock;
			H36_command : out routeCommands;
			J14_state : in signalStates;
			J14_lock : in objectLock;
			J14_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_39;
architecture Behavioral of route_39 is
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
	signal ne12_used , ne23_used : std_logic := '0';
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
				if ((ne12_lock = RELEASED and ne23_lock = RELEASED) and (ne12_state = FREE and ne23_state = FREE)) then
					restart <= '0';
					ne12_command <= RESERVE;
					ne23_command <= RESERVE;
				end if;
				if (ne12_lock = RESERVED and ne23_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if ((ne12_lock = RESERVED and ne23_lock = RESERVED) and (ne12_state = FREE and ne23_state = FREE)) then
					restart <= '0';
					ne12_command <= LOCK;
					ne23_command <= LOCK;
				end if;
				if (ne12_lock = LOCKED and ne23_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (Sw13_lock = RELEASED) then
					restart <= '0';
					Sw13_command <= RESERVE;
				end if;
				if (Sw13_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (Sw13_lock = RESERVED) then
					restart <= '0';
					Sw13_command <= LOCK;
					routeState <= '0';
				end if;
				if (Sw13_lock = LOCKED)then
					restart <= '1';
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (H36_lock = RELEASED) then
					H36_command <= RESERVE;
				end if;
				if (H36_lock = RESERVED) then
					restart <= '0';
					H36_command <= LOCK;
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
				if (ne23_used = '0' and ne23_state = OCCUPIED) then 
					ne23_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw13_command <= RELEASE;
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne12_command <= RELEASE;
				ne23_command <= RELEASE;
				routingState <= WAITING_COMMAND;
			when others =>
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;