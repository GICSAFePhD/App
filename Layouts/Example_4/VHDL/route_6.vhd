--  route_6.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R7 ['D10', 'D09'] 
--dw  R7 ['D12'] 
--sc  R7 [] 
--lc  R7 [] 
	entity route_6 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne450 : in hex_char;
			ne450_command : out routeCommands := RELEASE;
			track_ne130 : in hex_char;
			ne130_command : out routeCommands := RELEASE;
			D10_state : in hex_char;
			D10_command : out routeCommands := RELEASE;
			D09_state : in hex_char;
			D09_command : out routeCommands := RELEASE;
			D12_state : in hex_char;
			D12_command : out routeCommands := RELEASE;
			T08_state : in hex_char;
			T08_command : out routeCommands := RELEASE;
			C79_state : in hex_char;
			C79_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_6;
architecture Behavioral of route_6 is
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
	signal ne450_used , ne130_used : std_logic := '0';
	signal ne450_state : nodeStates := FREE;
	signal ne450_lock : objectLock := RELEASED;
	signal ne130_state : nodeStates := FREE;
	signal ne130_lock : objectLock := RELEASED;
	signal D10_position : singleSwitchStates := NORMAL;
	signal D10_lock : objectLock := RELEASED;
	signal D09_position : singleSwitchStates := NORMAL;
	signal D09_lock : objectLock := RELEASED;
	signal D12_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal D12_lock : objectLock := RELEASED;
	signal T08_aspectIn : signalStates := RED;
	signal T08_lock: objectLock := RELEASED;
	signal C79_aspectIn : signalStates := RED;
	signal C79_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne450_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne450)(2 to 3))));
	ne450_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne450)(0 to 1))));
	ne130_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne130)(2 to 3))));
	ne130_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne130)(0 to 1))));
	D10_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D10_state)(2 to 3))));
	D10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D10_state)(0 to 1))));
	D09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D09_state)(2 to 3))));
	D09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D09_state)(0 to 1))));
	D12_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(D12_state)(2 to 3))));
	D12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D12_state)(0 to 1))));
	T08_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T08_state)(2 to 3))));
	T08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T08_state)(0 to 1))));
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
				if ((ne450_lock = RELEASED and ne130_lock = RELEASED) and (ne130_state = FREE)) then
					ne450_command <= RESERVE;
					ne130_command <= RESERVE;
				end if;
				if (ne450_lock = RESERVED and ne130_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne450_lock = RESERVED and ne130_lock = RESERVED) and (ne130_state = FREE)) then
					ne450_command <= LOCK;
					ne130_command <= LOCK;
				end if;
				if (ne450_lock = LOCKED and ne130_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D10_lock = RELEASED and D09_lock = RELEASED and D12_lock = RELEASED) then
					D10_command <= RESERVE;
					D09_command <= RESERVE;
					D12_command <= RESERVE;
				end if;
				if (D10_lock = RESERVED and D09_lock = RESERVED and D12_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D10_lock = RESERVED and D09_lock = RESERVED and D12_lock = RESERVED) then
					D10_command <= LOCK;
					D09_command <= LOCK;
					D12_command <= LOCK;
				end if;
				if (D10_lock = LOCKED and D09_lock = LOCKED and D12_lock = LOCKED)then
					ne450_used <= '0';
					ne130_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T08_lock = RELEASED and C79_lock = RELEASED) then
					T08_command <= RESERVE;
					C79_command <= LOCK;
				end if;
				if (T08_lock = RESERVED and C79_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne450_used = '0' and ne450_state = OCCUPIED) then 
					ne450_used <= '1';
				end if;
				if (ne450_used = '1' and ne450_state = FREE) then
					ne450_used <= '0';
					ne450_command <= RELEASE;
				end if;
					---
				if (ne450_lock = RELEASED and ne130_used = '0' and ne130_state = OCCUPIED) then 
					ne130_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D10_command <= RELEASE;
				D09_command <= RELEASE;
				D12_command <= RELEASE;
				ne450_command <= RELEASE;
				ne130_command <= RELEASE;
				T08_command <= RELEASE;
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