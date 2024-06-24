--  route_22.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
--XXX ['Sw04_state = REVERSE', 'Sw07_state = NORMAL'] | ['Sw04', 'Sw07'] 
--YYY None | None 
	entity route_22 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_lock : in objectLock;
			ne9_command : out routeCommands;
			ne15_state : in nodeStates;
			ne15_lock : in objectLock;
			ne15_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_lock : in objectLock;
			Lc06_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_lock : in objectLock;
			Sw07_command : out routeCommands;
			H24_state : in signalStates;
			H24_lock : in objectLock;
			H24_command : out routeCommands;
			T05_state : in signalStates;
			T05_lock : in objectLock;
			T05_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_22;
architecture Behavioral of route_22 is
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
	signal ne1_used , ne9_used , ne15_used : std_logic := '0';
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
				if ((ne1_lock = RELEASED and ne9_lock = RELEASED and ne15_lock = RELEASED) and (ne1_state = FREE and ne9_state = FREE and ne15_state = FREE)) then
					restart <= '0';
					ne1_command <= RESERVE;
					ne9_command <= RESERVE;
					ne15_command <= RESERVE;
				end if;
				if (ne1_lock = RESERVED and ne9_lock = RESERVED and ne15_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if ((ne1_lock = RESERVED and ne9_lock = RESERVED and ne15_lock = RESERVED) and (ne1_state = FREE and ne9_state = FREE and ne15_state = FREE)) then
					restart <= '0';
					ne1_command <= LOCK;
					ne9_command <= LOCK;
					ne15_command <= LOCK;
				end if;
				if (ne1_lock = LOCKED and ne9_lock = LOCKED and ne15_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (Lc06_lock = RELEASED and Sw04_lock = RELEASED and Sw07_lock = RELEASED) then
					restart <= '0';
					Lc06_command <= RESERVE;
					Sw04_command <= RESERVE;
					Sw07_command <= RESERVE;
				end if;
				if (Lc06_lock = RESERVED and Sw04_lock = RESERVED and Sw07_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (Lc06_lock = RESERVED and Sw04_lock = RESERVED and Sw07_lock = RESERVED) then
					restart <= '0';
					Lc06_command <= LOCK;
					Sw04_command <= LOCK;
					Sw07_command <= LOCK;
					routeState <= '0';
				end if;
				if (Lc06_lock = LOCKED and Sw04_lock = LOCKED and Sw07_lock = LOCKED)then
					restart <= '1';
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (H24_lock = RELEASED) then
					H24_command <= RESERVE;
				end if;
				if (H24_lock = RESERVED) then
					restart <= '0';
					H24_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne1_used = '0' and ne1_state = OCCUPIED) then 
					ne1_used <= '1';
				end if;
				if (ne1_used = '1' and ne1_state = FREE) then
					ne1_used <= '0';
					ne1_command <= RELEASE;
				end if;
				if (ne9_used = '0' and ne9_state = OCCUPIED) then 
					ne9_used <= '1';
				end if;
				if (ne9_used = '1' and ne9_state = FREE) then
					ne9_used <= '0';
					ne9_command <= RELEASE;
				end if;
				if (ne15_used = '0' and ne15_state = OCCUPIED) then 
					ne15_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc06_command <= RELEASE;
				Sw04_command <= RELEASE;
				Sw07_command <= RELEASE;
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne1_command <= RELEASE;
				ne9_command <= RELEASE;
				ne15_command <= RELEASE;
				routingState <= WAITING_COMMAND;
			when others =>
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;