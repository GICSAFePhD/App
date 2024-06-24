--  route_23.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
--XXX ['Sw06_state = NORMAL'] | ['Sw06'] 
--YYY None | None 
	entity route_23 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_lock : in objectLock;
			Sw06_command : out routeCommands;
			C25_state : in signalStates;
			C25_lock : in objectLock;
			C25_command : out routeCommands;
			L08_state : in signalStates;
			L08_lock : in objectLock;
			L08_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_23;
architecture Behavioral of route_23 is
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
	signal ne12_used , ne2_used : std_logic := '0';
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
				if ((ne12_lock = RELEASED and ne2_lock = RELEASED) and (ne12_state = FREE and ne2_state = FREE)) then
					restart <= '0';
					ne12_command <= RESERVE;
					ne2_command <= RESERVE;
				end if;
				if (ne12_lock = RESERVED and ne2_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if ((ne12_lock = RESERVED and ne2_lock = RESERVED) and (ne12_state = FREE and ne2_state = FREE)) then
					restart <= '0';
					ne12_command <= LOCK;
					ne2_command <= LOCK;
				end if;
				if (ne12_lock = LOCKED and ne2_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (Sw06_lock = RELEASED) then
					restart <= '0';
					Sw06_command <= RESERVE;
				end if;
				if (Sw06_lock = RESERVED)then
					restart <= '1';
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (Sw06_lock = RESERVED) then
					restart <= '0';
					Sw06_command <= LOCK;
					routeState <= '0';
				end if;
				if (Sw06_lock = LOCKED)then
					restart <= '1';
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (C25_lock = RELEASED) then
					C25_command <= RESERVE;
				end if;
				if (C25_lock = RESERVED) then
					restart <= '0';
					C25_command <= LOCK;
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
				if (ne2_used = '0' and ne2_state = OCCUPIED) then 
					ne2_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw06_command <= RELEASE;
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne12_command <= RELEASE;
				ne2_command <= RELEASE;
				routingState <= WAITING_COMMAND;
			when others =>
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;