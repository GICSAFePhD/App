--  route_29.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
--XXX ['Sw04_state = REVERSE', 'Sw07_state = NORMAL'] | ['Sw04', 'Sw07'] 
--YYY None | None 
	entity route_29 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne15_state : in nodeStates;
			ne15_lock : in objectLock;
			ne15_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_lock : in objectLock;
			ne9_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_lock : in objectLock;
			Sw07_command : out routeCommands;
			C29_state : in signalStates;
			C29_lock : in objectLock;
			C29_command : out routeCommands;
			L07_state : in signalStates;
			L07_lock : in objectLock;
			L07_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_29;
architecture Behavioral of route_29 is
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
	signal ne15_used , ne9_used , ne1_used : std_logic := '0';
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
				if ((ne15_lock = RELEASED and ne9_lock = RELEASED and ne1_lock = RELEASED) and (ne15_state = FREE and ne9_state = FREE and ne1_state = FREE)) then
					restart <= '0';
					ne15_command <= RESERVE;
					ne9_command <= RESERVE;
					ne1_command <= RESERVE;
				end if;
				if (ne15_lock = RESERVED and ne9_lock = RESERVED and ne1_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if ((ne15_lock = RESERVED and ne9_lock = RESERVED and ne1_lock = RESERVED) and (ne15_state = FREE and ne9_state = FREE and ne1_state = FREE)) then
					restart <= '0';
					ne15_command <= LOCK;
					ne9_command <= LOCK;
					ne1_command <= LOCK;
				end if;
				if (ne15_lock = LOCKED and ne9_lock = LOCKED and ne1_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (Sw04_lock = RELEASED and Sw07_lock = RELEASED) then
					restart <= '0';
					Sw04_command <= RESERVE;
					Sw07_command <= RESERVE;
				end if;
				if (Sw04_lock = RESERVED and Sw07_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (Sw04_lock = RESERVED and Sw07_lock = RESERVED) then
					restart <= '0';
					Sw04_command <= LOCK;
					Sw07_command <= LOCK;
					routeState <= '0';
				end if;
				if (Sw04_lock = LOCKED and Sw07_lock = LOCKED)then
					restart <= '1';
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (C29_lock = RELEASED) then
					C29_command <= RESERVE;
				end if;
				if (C29_lock = RESERVED) then
					restart <= '0';
					C29_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne15_used = '0' and ne15_state = OCCUPIED) then 
					ne15_used <= '1';
				end if;
				if (ne15_used = '1' and ne15_state = FREE) then
					ne15_used <= '0';
					ne15_command <= RELEASE;
				end if;
				if (ne9_used = '0' and ne9_state = OCCUPIED) then 
					ne9_used <= '1';
				end if;
				if (ne9_used = '1' and ne9_state = FREE) then
					ne9_used <= '0';
					ne9_command <= RELEASE;
				end if;
				if (ne1_used = '0' and ne1_state = OCCUPIED) then 
					ne1_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw04_command <= RELEASE;
				Sw07_command <= RELEASE;
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne15_command <= RELEASE;
				ne9_command <= RELEASE;
				ne1_command <= RELEASE;
				routingState <= WAITING_COMMAND;
			when others =>
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;