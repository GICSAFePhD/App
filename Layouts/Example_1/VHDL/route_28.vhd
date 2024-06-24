--  route_28.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
--XXX ['Sw06_state = REVERSE'] | ['Sw06'] 
--YYY None | None 
	entity route_28 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			ne13_state : in nodeStates;
			ne13_lock : in objectLock;
			ne13_command : out routeCommands;
			Lc08_state : in levelCrossingStates;
			Lc08_lock : in objectLock;
			Lc08_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_lock : in objectLock;
			Sw06_command : out routeCommands;
			H28_state : in signalStates;
			H28_lock : in objectLock;
			H28_command : out routeCommands;
			T01_state : in signalStates;
			T01_lock : in objectLock;
			T01_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_28;
architecture Behavioral of route_28 is
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
	signal ne2_used , ne13_used : std_logic := '0';
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
				if ((ne2_lock = RELEASED and ne13_lock = RELEASED) and (ne2_state = FREE and ne13_state = FREE)) then
					restart <= '0';
					ne2_command <= RESERVE;
					ne13_command <= RESERVE;
				end if;
				if (ne2_lock = RESERVED and ne13_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if ((ne2_lock = RESERVED and ne13_lock = RESERVED) and (ne2_state = FREE and ne13_state = FREE)) then
					restart <= '0';
					ne2_command <= LOCK;
					ne13_command <= LOCK;
				end if;
				if (ne2_lock = LOCKED and ne13_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (Lc08_lock = RELEASED and Sw06_lock = RELEASED) then
					restart <= '0';
					Lc08_command <= RESERVE;
					Sw06_command <= RESERVE;
				end if;
				if (Lc08_lock = RESERVED and Sw06_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (Lc08_lock = RESERVED and Sw06_lock = RESERVED) then
					restart <= '0';
					Lc08_command <= LOCK;
					Sw06_command <= LOCK;
					routeState <= '0';
				end if;
				if (Lc08_lock = LOCKED and Sw06_lock = LOCKED)then
					restart <= '1';
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (H28_lock = RELEASED) then
					H28_command <= RESERVE;
				end if;
				if (H28_lock = RESERVED) then
					restart <= '0';
					H28_command <= LOCK;
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
				if (ne13_used = '0' and ne13_state = OCCUPIED) then 
					ne13_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc08_command <= RELEASE;
				Sw06_command <= RELEASE;
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne2_command <= RELEASE;
				ne13_command <= RELEASE;
				routingState <= WAITING_COMMAND;
			when others =>
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;