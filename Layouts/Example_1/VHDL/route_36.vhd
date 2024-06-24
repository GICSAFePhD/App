--  route_36.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
--XXX ['Sw13_state = NORMAL', 'Sw06_state = NORMAL'] | ['Sw13', 'Sw06'] 
--YYY None | None 
	entity route_36 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_lock : in objectLock;
			Sw13_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_lock : in objectLock;
			Sw06_command : out routeCommands;
			C34_state : in signalStates;
			C34_lock : in objectLock;
			C34_command : out routeCommands;
			C25_state : in signalStates;
			C25_lock : in objectLock;
			C25_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_36;
architecture Behavioral of route_36 is
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
	signal ne23_used , ne12_used : std_logic := '0';
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
				if ((ne23_lock = RELEASED and ne12_lock = RELEASED) and (ne23_state = FREE and ne12_state = FREE)) then
					restart <= '0';
					ne23_command <= RESERVE;
					ne12_command <= RESERVE;
				end if;
				if (ne23_lock = RESERVED and ne12_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if ((ne23_lock = RESERVED and ne12_lock = RESERVED) and (ne23_state = FREE and ne12_state = FREE)) then
					restart <= '0';
					ne23_command <= LOCK;
					ne12_command <= LOCK;
				end if;
				if (ne23_lock = LOCKED and ne12_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (Sw13_lock = RELEASED and Sw06_lock = RELEASED) then
					restart <= '0';
					Sw13_command <= RESERVE;
					Sw06_command <= RESERVE;
				end if;
				if (Sw13_lock = RESERVED and Sw06_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (Sw13_lock = RESERVED and Sw06_lock = RESERVED) then
					restart <= '0';
					Sw13_command <= LOCK;
					Sw06_command <= LOCK;
					routeState <= '0';
				end if;
				if (Sw13_lock = LOCKED and Sw06_lock = LOCKED)then
					restart <= '1';
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (C34_lock = RELEASED) then
					C34_command <= RESERVE;
				end if;
				if (C34_lock = RESERVED) then
					restart <= '0';
					C34_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne23_used = '0' and ne23_state = OCCUPIED) then 
					ne23_used <= '1';
				end if;
				if (ne23_used = '1' and ne23_state = FREE) then
					ne23_used <= '0';
					ne23_command <= RELEASE;
				end if;
				if (ne12_used = '0' and ne12_state = OCCUPIED) then 
					ne12_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw13_command <= RELEASE;
				Sw06_command <= RELEASE;
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne23_command <= RELEASE;
				ne12_command <= RELEASE;
				routingState <= WAITING_COMMAND;
			when others =>
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;