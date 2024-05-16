--  route_16.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_16 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne7_state : in nodeStates;
			ne7_lock : in objectLock;
			ne7_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			C29_state : in signalStates;
			C29_lock : in objectLock;
			C29_command : out routeCommands;
			J18_state : in signalStates;
			routeState : out std_logic
		);
	end entity route_16;
architecture Behavioral of route_16 is
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
	signal ne7_used , ne2_used , ne1_used : std_logic := '0';
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
				if ((ne7_lock = RELEASED and ne2_lock = RELEASED and ne1_lock = RELEASED) and (ne7_state = FREE and ne2_state = FREE and ne1_state = FREE)) then
					ne7_command <= RESERVE;
					ne2_command <= RESERVE;
					ne1_command <= RESERVE;
					restart <= '0';
				end if;
				if (ne7_lock = RESERVED and ne2_lock = RESERVED and ne1_lock = RESERVED)then
					routingState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= WAITING_COMMAND;
				end if;
				if ((ne7_lock = RESERVED and ne2_lock = RESERVED and ne1_lock = RESERVED) and (ne7_state = FREE and ne2_state = FREE and ne1_state = FREE)) then
					ne7_command <= LOCK;
					ne2_command <= LOCK;
					ne1_command <= LOCK;
					restart <= '0';
				end if;
				if (ne7_lock = LOCKED and ne2_lock = LOCKED and ne1_lock = LOCKED)then
					restart <= '1';
					routingState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_TRACKS;
				end if;
				if (Sw01_lock = RELEASED and Sw03_lock = RELEASED) then
					Sw01_command <= RESERVE;
					Sw03_command <= RESERVE;
					restart <= '0';
				end if;
				if (Sw01_lock = RESERVED and Sw03_lock = RESERVED)then
					routingState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (Sw01_lock = RELEASED and Sw03_lock = RELEASED and Sw01_state = REVERSE and Sw03_state = NORMAL) then
					Sw01_command <= LOCK;
					Sw03_command <= LOCK;
					restart <= '0';
				end if;
				if (Sw01_lock = LOCKED and Sw03_lock = LOCKED)then
					routingState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				if (reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
					restart <= '1';
					routeState <= '0';
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
				if (C29_lock = RELEASED) then
					C29_command <= RESERVE;
				end if;
				if (C29_lock = RESERVED and C29_state /= RED) then
					restart <= '0';
					routeState <= '1';
					C29_command <= LOCK;
					routingState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				--- Sequential release
				if (ne7_used = '0' and ne7_state = OCCUPIED) then 
					ne7_used <= '1';
				end if;
				if (ne7_used = '1' and ne7_state = FREE) then
					ne7_used <= '0';
					ne7_command <= RELEASE;
				end if;
				if (ne2_used = '0' and ne2_state = OCCUPIED) then 
					ne2_used <= '1';
				end if;
				if (ne2_used = '1' and ne2_state = FREE) then
					ne2_used <= '0';
					ne2_command <= RELEASE;
				end if;
				if (ne1_used = '0' and ne1_state = OCCUPIED) then 
					ne1_used <= '1';
					--- Finish -> Release all
					routingState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw01_command <= RELEASE;
				Sw03_command <= RELEASE;
				routeState <= '0';
				routingState <= RELEASING_TRACKS;
			when RELEASING_TRACKS =>
				ne7_command <= RELEASE;
				ne2_command <= RELEASE;
				ne1_command <= RELEASE;
				routeState <= '0';
				routingState <= WAITING_COMMAND;
			when others =>
				routeState <= '0';
				routingState <= WAITING_COMMAND;
		end case;
		end if;
	end process;
end Behavioral;