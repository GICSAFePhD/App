--  route_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R6 ['D10', 'D09', 'D24'] 
--dw  R6 ['D12'] 
--sc  R6 [] 
--lc  R6 [] 
	entity route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne450 : in hex_char;
			ne450_command : out routeCommands := RELEASE;
			track_ne127 : in hex_char;
			ne127_command : out routeCommands := RELEASE;
			D10_state : in hex_char;
			D10_command : out routeCommands := RELEASE;
			D09_state : in hex_char;
			D09_command : out routeCommands := RELEASE;
			D24_state : in hex_char;
			D24_command : out routeCommands := RELEASE;
			D12_state : in hex_char;
			D12_command : out routeCommands := RELEASE;
			T08_state : in hex_char;
			T08_command : out routeCommands := RELEASE;
			S117_state : in hex_char;
			S117_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_5;
architecture Behavioral of route_5 is
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
	signal ne450_used , ne127_used : std_logic := '0';
	signal ne450_state : nodeStates := FREE;
	signal ne450_lock : objectLock := RELEASED;
	signal ne127_state : nodeStates := FREE;
	signal ne127_lock : objectLock := RELEASED;
	signal D10_position : singleSwitchStates := NORMAL;
	signal D10_lock : objectLock := RELEASED;
	signal D09_position : singleSwitchStates := NORMAL;
	signal D09_lock : objectLock := RELEASED;
	signal D24_position : singleSwitchStates := NORMAL;
	signal D24_lock : objectLock := RELEASED;
	signal D12_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal D12_lock : objectLock := RELEASED;
	signal T08_aspectIn : signalStates := RED;
	signal T08_lock: objectLock := RELEASED;
	signal S117_aspectIn : signalStates := RED;
	signal S117_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne450_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne450)(2 to 3))));
	ne450_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne450)(0 to 1))));
	ne127_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne127)(2 to 3))));
	ne127_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne127)(0 to 1))));
	D10_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D10_state)(2 to 3))));
	D10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D10_state)(0 to 1))));
	D09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D09_state)(2 to 3))));
	D09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D09_state)(0 to 1))));
	D24_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D24_state)(2 to 3))));
	D24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D24_state)(0 to 1))));
	D12_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(D12_state)(2 to 3))));
	D12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D12_state)(0 to 1))));
	T08_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T08_state)(2 to 3))));
	T08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T08_state)(0 to 1))));
	S117_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S117_state)(2 to 3))));
	S117_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S117_state)(0 to 1))));
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
				if ((ne450_lock = RELEASED and ne127_lock = RELEASED) and (ne127_state = FREE)) then
					ne450_command <= RESERVE;
					ne127_command <= RESERVE;
				end if;
				if (ne450_lock = RESERVED and ne127_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne450_lock = RESERVED and ne127_lock = RESERVED) and (ne127_state = FREE)) then
					ne450_command <= LOCK;
					ne127_command <= LOCK;
				end if;
				if (ne450_lock = LOCKED and ne127_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D10_lock = RELEASED and D09_lock = RELEASED and D24_lock = RELEASED and D12_lock = RELEASED) then
					D10_command <= RESERVE;
					D09_command <= RESERVE;
					D24_command <= RESERVE;
					D12_command <= RESERVE;
				end if;
				if (D10_lock = RESERVED and D09_lock = RESERVED and D24_lock = RESERVED and D12_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D10_lock = RESERVED and D09_lock = RESERVED and D24_lock = RESERVED and D12_lock = RESERVED) then
					D10_command <= LOCK;
					D09_command <= LOCK;
					D24_command <= LOCK;
					D12_command <= LOCK;
				end if;
				if (D10_lock = LOCKED and D09_lock = LOCKED and D24_lock = LOCKED and D12_lock = LOCKED)then
					ne450_used <= '0';
					ne127_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T08_lock = RELEASED and S117_lock = RELEASED) then
					T08_command <= RESERVE;
					S117_command <= LOCK;
				end if;
				if (T08_lock = RESERVED and S117_lock = LOCKED) then
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
				if (ne450_lock = RELEASED and ne127_used = '0' and ne127_state = OCCUPIED) then 
					ne127_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D10_command <= RELEASE;
				D09_command <= RELEASE;
				D24_command <= RELEASE;
				D12_command <= RELEASE;
				ne450_command <= RELEASE;
				ne127_command <= RELEASE;
				T08_command <= RELEASE;
				S117_command <= RELEASE;
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