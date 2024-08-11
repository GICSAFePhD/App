--  route_71.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R72 [] 
--dw  R72 ['D12'] 
--sc  R72 [] 
--lc  R72 [] 
	entity route_71 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne127 : in hex_char;
			ne127_command : out routeCommands := RELEASE;
			track_ne450 : in hex_char;
			ne450_command : out routeCommands := RELEASE;
			D12_state : in hex_char;
			D12_command : out routeCommands := RELEASE;
			S104_state : in hex_char;
			S104_command : out routeCommands := RELEASE;
			T07_state : in hex_char;
			T07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_71;
architecture Behavioral of route_71 is
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
	signal ne127_used , ne450_used : std_logic := '0';
	signal ne127_state : nodeStates := FREE;
	signal ne127_lock : objectLock := RELEASED;
	signal ne450_state : nodeStates := FREE;
	signal ne450_lock : objectLock := RELEASED;
	signal D12_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal D12_lock : objectLock := RELEASED;
	signal S104_aspectIn : signalStates := RED;
	signal S104_lock: objectLock := RELEASED;
	signal T07_aspectIn : signalStates := RED;
	signal T07_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne127_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne127)(2 to 3))));
	ne127_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne127)(0 to 1))));
	ne450_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne450)(2 to 3))));
	ne450_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne450)(0 to 1))));
	D12_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(D12_state)(2 to 3))));
	D12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D12_state)(0 to 1))));
	S104_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S104_state)(2 to 3))));
	S104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S104_state)(0 to 1))));
	T07_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T07_state)(2 to 3))));
	T07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T07_state)(0 to 1))));
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
				if ((ne127_lock = RELEASED and ne450_lock = RELEASED) and (ne450_state = FREE)) then
					ne127_command <= RESERVE;
					ne450_command <= RESERVE;
				end if;
				if (ne127_lock = RESERVED and ne450_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne127_lock = RESERVED and ne450_lock = RESERVED) and (ne450_state = FREE)) then
					ne127_command <= LOCK;
					ne450_command <= LOCK;
				end if;
				if (ne127_lock = LOCKED and ne450_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D12_lock = RELEASED) then
					D12_command <= RESERVE;
				end if;
				if (D12_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D12_lock = RESERVED) then
					D12_command <= LOCK;
				end if;
				if (D12_lock = LOCKED)then
					ne127_used <= '0';
					ne450_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S104_lock = RELEASED and T07_lock = RELEASED) then
					S104_command <= RESERVE;
					T07_command <= LOCK;
				end if;
				if (S104_lock = RESERVED and T07_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne127_used = '0' and ne127_state = OCCUPIED) then 
					ne127_used <= '1';
				end if;
				if (ne127_used = '1' and ne127_state = FREE) then
					ne127_used <= '0';
					ne127_command <= RELEASE;
				end if;
					---
				if (ne127_lock = RELEASED and ne450_used = '0' and ne450_state = OCCUPIED) then 
					ne450_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D12_command <= RELEASE;
				ne127_command <= RELEASE;
				ne450_command <= RELEASE;
				S104_command <= RELEASE;
				T07_command <= RELEASE;
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