--  route_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R3 ['D15'] 
--dw  R3 [] 
--sc  R3 [] 
--lc  R3 [] 
	entity route_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne377 : in hex_char;
			ne377_command : out routeCommands := RELEASE;
			track_ne113 : in hex_char;
			ne113_command : out routeCommands := RELEASE;
			D15_state : in hex_char;
			D15_command : out routeCommands := RELEASE;
			T04_state : in hex_char;
			T04_command : out routeCommands := RELEASE;
			T15_state : in hex_char;
			T15_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_2;
architecture Behavioral of route_2 is
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
	signal ne377_used , ne113_used : std_logic := '0';
	signal ne377_state : nodeStates := FREE;
	signal ne377_lock : objectLock := RELEASED;
	signal ne113_state : nodeStates := FREE;
	signal ne113_lock : objectLock := RELEASED;
	signal D15_position : singleSwitchStates := NORMAL;
	signal D15_lock : objectLock := RELEASED;
	signal T04_aspectIn : signalStates := RED;
	signal T04_lock: objectLock := RELEASED;
	signal T15_aspectIn : signalStates := RED;
	signal T15_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne377_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne377)(2 to 3))));
	ne377_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne377)(0 to 1))));
	ne113_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne113)(2 to 3))));
	ne113_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne113)(0 to 1))));
	D15_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D15_state)(2 to 3))));
	D15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D15_state)(0 to 1))));
	T04_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T04_state)(2 to 3))));
	T04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T04_state)(0 to 1))));
	T15_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T15_state)(2 to 3))));
	T15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T15_state)(0 to 1))));
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
				if ((ne377_lock = RELEASED and ne113_lock = RELEASED) and (ne113_state = FREE)) then
					ne377_command <= RESERVE;
					ne113_command <= RESERVE;
				end if;
				if (ne377_lock = RESERVED and ne113_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne377_lock = RESERVED and ne113_lock = RESERVED) and (ne113_state = FREE)) then
					ne377_command <= LOCK;
					ne113_command <= LOCK;
				end if;
				if (ne377_lock = LOCKED and ne113_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D15_lock = RELEASED) then
					D15_command <= RESERVE;
				end if;
				if (D15_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D15_lock = RESERVED) then
					D15_command <= LOCK;
				end if;
				if (D15_lock = LOCKED)then
					ne377_used <= '0';
					ne113_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T04_lock = RELEASED and T15_lock = RELEASED) then
					T04_command <= RESERVE;
					T15_command <= LOCK;
				end if;
				if (T04_lock = RESERVED and T15_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne377_used = '0' and ne377_state = OCCUPIED) then 
					ne377_used <= '1';
				end if;
				if (ne377_used = '1' and ne377_state = FREE) then
					ne377_used <= '0';
					ne377_command <= RELEASE;
				end if;
					---
				if (ne377_lock = RELEASED and ne113_used = '0' and ne113_state = OCCUPIED) then 
					ne113_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D15_command <= RELEASE;
				ne377_command <= RELEASE;
				ne113_command <= RELEASE;
				T04_command <= RELEASE;
				T15_command <= RELEASE;
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