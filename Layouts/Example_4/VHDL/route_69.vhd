--  route_69.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R70 ['D10', 'D09', 'D23'] 
--dw  R70 ['D12'] 
--sc  R70 [] 
--lc  R70 [] 
	entity route_69 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne114 : in hex_char;
			ne114_command : out routeCommands := RELEASE;
			track_ne129 : in hex_char;
			ne129_command : out routeCommands := RELEASE;
			track_ne130 : in hex_char;
			ne130_command : out routeCommands := RELEASE;
			D10_state : in hex_char;
			D10_command : out routeCommands := RELEASE;
			D09_state : in hex_char;
			D09_command : out routeCommands := RELEASE;
			D23_state : in hex_char;
			D23_command : out routeCommands := RELEASE;
			D12_state : in hex_char;
			D12_command : out routeCommands := RELEASE;
			S101_state : in hex_char;
			S101_command : out routeCommands := RELEASE;
			C79_state : in hex_char;
			C79_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_69;
architecture Behavioral of route_69 is
	component flipFlop is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			Q : out std_logic := '0'
		);
	end component flipFlop;
	signal restart : std_logic := '1';
	signal Q : std_logic_vector(32 downto 0) := (others => '0');
	signal clock_in : std_logic_vector(32 downto 0) := (others => '0');
	signal timeout : std_logic := '0';
	signal routeState : routeStates := WAITING_COMMAND;
	signal routingIn : routeStates;
	signal ne114_used , ne129_used , ne130_used : std_logic := '0';
	signal ne114_state : nodeStates := FREE;
	signal ne114_lock : objectLock := RELEASED;
	signal ne129_state : nodeStates := FREE;
	signal ne129_lock : objectLock := RELEASED;
	signal ne130_state : nodeStates := FREE;
	signal ne130_lock : objectLock := RELEASED;
	signal D10_position : singleSwitchStates := NORMAL;
	signal D10_lock : objectLock := RELEASED;
	signal D09_position : singleSwitchStates := NORMAL;
	signal D09_lock : objectLock := RELEASED;
	signal D23_position : singleSwitchStates := NORMAL;
	signal D23_lock : objectLock := RELEASED;
	signal D12_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal D12_lock : objectLock := RELEASED;
	signal S101_aspectIn : signalStates := RED;
	signal S101_lock: objectLock := RELEASED;
	signal C79_aspectIn : signalStates := RED;
	signal C79_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne114_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne114)(2 to 3))));
	ne114_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne114)(0 to 1))));
	ne129_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne129)(2 to 3))));
	ne129_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne129)(0 to 1))));
	ne130_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne130)(2 to 3))));
	ne130_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne130)(0 to 1))));
	D10_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D10_state)(2 to 3))));
	D10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D10_state)(0 to 1))));
	D09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D09_state)(2 to 3))));
	D09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D09_state)(0 to 1))));
	D23_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D23_state)(2 to 3))));
	D23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D23_state)(0 to 1))));
	D12_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(D12_state)(2 to 3))));
	D12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D12_state)(0 to 1))));
	S101_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S101_state)(2 to 3))));
	S101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S101_state)(0 to 1))));
	C79_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C79_state)(2 to 3))));
	C79_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C79_state)(0 to 1))));
	gen : for i in 0 to 31 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "010110010110100000101111000000000") then
			timeout <= '1';
		end if;
		if (restart = '1') then
			timeout <= '0';
		end if;
	end process;

	process(clock)
	begin
	if (clock'Event and clock = '1') then
		case routeState is
			when WAITING_COMMAND =>
				if (routingIn = ROUTE_REQUEST) then
					routeState <= RESERVING_TRACKS;
				end if;
			when RESERVING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne114_lock = RELEASED and ne129_lock = RELEASED and ne130_lock = RELEASED) and (ne129_state = FREE and ne130_state = FREE)) then
					ne114_command <= RESERVE;
					ne129_command <= RESERVE;
					ne130_command <= RESERVE;
				end if;
				if (ne114_lock = RESERVED and ne129_lock = RESERVED and ne130_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne114_lock = RESERVED and ne129_lock = RESERVED and ne130_lock = RESERVED) and (ne129_state = FREE and ne130_state = FREE)) then
					ne114_command <= LOCK;
					ne129_command <= LOCK;
					ne130_command <= LOCK;
				end if;
				if (ne114_lock = LOCKED and ne129_lock = LOCKED and ne130_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D10_lock = RELEASED and D09_lock = RELEASED and D23_lock = RELEASED and D12_lock = RELEASED) then
					D10_command <= RESERVE;
					D09_command <= RESERVE;
					D23_command <= RESERVE;
					D12_command <= RESERVE;
				end if;
				if (D10_lock = RESERVED and D09_lock = RESERVED and D23_lock = RESERVED and D12_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D10_lock = RESERVED and D09_lock = RESERVED and D23_lock = RESERVED and D12_lock = RESERVED) then
					D10_command <= LOCK;
					D09_command <= LOCK;
					D23_command <= LOCK;
					D12_command <= LOCK;
				end if;
				if (D10_lock = LOCKED and D09_lock = LOCKED and D23_lock = LOCKED and D12_lock = LOCKED)then
					ne114_used <= '0';
					ne129_used <= '0';
					ne130_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S101_lock = RELEASED and C79_lock = RELEASED) then
					S101_command <= RESERVE;
					C79_command <= LOCK;
				end if;
				if (S101_lock = RESERVED and C79_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne114_used = '0' and ne114_state = OCCUPIED) then 
					ne114_used <= '1';
				end if;
				if (ne114_used = '1' and ne114_state = FREE) then
					ne114_used <= '0';
					ne114_command <= RELEASE;
				end if;
					---
				if (ne114_lock = RELEASED and ne129_used = '0' and ne129_state = OCCUPIED) then 
					ne129_used <= '1';
				end if;
				if (ne129_used = '1' and ne129_state = FREE) then
					ne129_used <= '0';
					ne129_command <= RELEASE;
				end if;
					---
				if (ne129_lock = RELEASED and ne130_used = '0' and ne130_state = OCCUPIED) then 
					ne130_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D10_command <= RELEASE;
				D09_command <= RELEASE;
				D23_command <= RELEASE;
				D12_command <= RELEASE;
				ne114_command <= RELEASE;
				ne129_command <= RELEASE;
				ne130_command <= RELEASE;
				S101_command <= RELEASE;
				C79_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;
			when CANCEL_ROUTE =>
				routeState <= RELEASING_INFRASTRUCTURE;
			when others =>
				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;