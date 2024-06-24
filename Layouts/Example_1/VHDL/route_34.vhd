--  route_34.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
--XXX ['Sw12_state = NORMAL'] | ['Sw12'] 
--YYY None | None 
	entity route_34 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne8_state : in nodeStates;
			ne8_lock : in objectLock;
			ne8_command : out routeCommands;
			ne22_state : in nodeStates;
			ne22_lock : in objectLock;
			ne22_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			H33_state : in signalStates;
			H33_lock : in objectLock;
			H33_command : out routeCommands;
			J11_state : in signalStates;
			J11_lock : in objectLock;
			J11_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_34;
architecture Behavioral of route_34 is
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
	signal ne8_used , ne22_used : std_logic := '0';
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
				if ((ne8_lock = RELEASED and ne22_lock = RELEASED) and (ne8_state = FREE and ne22_state = FREE)) then
					restart <= '0';
					ne8_command <= RESERVE;
					ne22_command <= RESERVE;
				end if;
				if (ne8_lock = RESERVED and ne22_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if ((ne8_lock = RESERVED and ne22_lock = RESERVED) and (ne8_state = FREE and ne22_state = FREE)) then
					restart <= '0';
					ne8_command <= LOCK;
					ne22_command <= LOCK;
				end if;
				if (ne8_lock = LOCKED and ne22_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (Sw12_lock = RELEASED) then
					restart <= '0';
					Sw12_command <= RESERVE;
				end if;
				if (Sw12_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (Sw12_lock = RESERVED) then
					restart <= '0';
					Sw12_command <= LOCK;
					routeState <= '0';
				end if;
				if (Sw12_lock = LOCKED)then
					restart <= '1';
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (H33_lock = RELEASED) then
					H33_command <= RESERVE;
				end if;
				if (H33_lock = RESERVED) then
					restart <= '0';
					H33_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne8_used = '0' and ne8_state = OCCUPIED) then 
					ne8_used <= '1';
				end if;
				if (ne8_used = '1' and ne8_state = FREE) then
					ne8_used <= '0';
					ne8_command <= RELEASE;
				end if;
				if (ne22_used = '0' and ne22_state = OCCUPIED) then 
					ne22_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw12_command <= RELEASE;
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne8_command <= RELEASE;
				ne22_command <= RELEASE;
				routingState <= WAITING_COMMAND;
			when others =>
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;