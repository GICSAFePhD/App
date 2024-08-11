--  route_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R2 ['D01', 'D14', 'D15'] 
--dw  R2 [] 
--sc  R2 [] 
--lc  R2 [] 
	entity route_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne377 : in hex_char;
			ne377_command : out routeCommands := RELEASE;
			track_ne111 : in hex_char;
			ne111_command : out routeCommands := RELEASE;
			track_ne290 : in hex_char;
			ne290_command : out routeCommands := RELEASE;
			D01_state : in hex_char;
			D01_command : out routeCommands := RELEASE;
			D14_state : in hex_char;
			D14_command : out routeCommands := RELEASE;
			D15_state : in hex_char;
			D15_command : out routeCommands := RELEASE;
			T04_state : in hex_char;
			T04_command : out routeCommands := RELEASE;
			J35_state : in hex_char;
			J35_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_1;
architecture Behavioral of route_1 is
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
	signal ne377_used , ne111_used , ne290_used : std_logic := '0';
	signal ne377_state : nodeStates := FREE;
	signal ne377_lock : objectLock := RELEASED;
	signal ne111_state : nodeStates := FREE;
	signal ne111_lock : objectLock := RELEASED;
	signal ne290_state : nodeStates := FREE;
	signal ne290_lock : objectLock := RELEASED;
	signal D01_position : singleSwitchStates := NORMAL;
	signal D01_lock : objectLock := RELEASED;
	signal D14_position : singleSwitchStates := NORMAL;
	signal D14_lock : objectLock := RELEASED;
	signal D15_position : singleSwitchStates := NORMAL;
	signal D15_lock : objectLock := RELEASED;
	signal T04_aspectIn : signalStates := RED;
	signal T04_lock: objectLock := RELEASED;
	signal J35_aspectIn : signalStates := RED;
	signal J35_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne377_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne377)(2 to 3))));
	ne377_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne377)(0 to 1))));
	ne111_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne111)(2 to 3))));
	ne111_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne111)(0 to 1))));
	ne290_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne290)(2 to 3))));
	ne290_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne290)(0 to 1))));
	D01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D01_state)(2 to 3))));
	D01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D01_state)(0 to 1))));
	D14_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D14_state)(2 to 3))));
	D14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D14_state)(0 to 1))));
	D15_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D15_state)(2 to 3))));
	D15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D15_state)(0 to 1))));
	T04_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T04_state)(2 to 3))));
	T04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T04_state)(0 to 1))));
	J35_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J35_state)(2 to 3))));
	J35_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J35_state)(0 to 1))));
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
				if ((ne377_lock = RELEASED and ne111_lock = RELEASED and ne290_lock = RELEASED) and (ne111_state = FREE and ne290_state = FREE)) then
					ne377_command <= RESERVE;
					ne111_command <= RESERVE;
					ne290_command <= RESERVE;
				end if;
				if (ne377_lock = RESERVED and ne111_lock = RESERVED and ne290_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne377_lock = RESERVED and ne111_lock = RESERVED and ne290_lock = RESERVED) and (ne111_state = FREE and ne290_state = FREE)) then
					ne377_command <= LOCK;
					ne111_command <= LOCK;
					ne290_command <= LOCK;
				end if;
				if (ne377_lock = LOCKED and ne111_lock = LOCKED and ne290_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D01_lock = RELEASED and D14_lock = RELEASED and D15_lock = RELEASED) then
					D01_command <= RESERVE;
					D14_command <= RESERVE;
					D15_command <= RESERVE;
				end if;
				if (D01_lock = RESERVED and D14_lock = RESERVED and D15_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D01_lock = RESERVED and D14_lock = RESERVED and D15_lock = RESERVED) then
					D01_command <= LOCK;
					D14_command <= LOCK;
					D15_command <= LOCK;
				end if;
				if (D01_lock = LOCKED and D14_lock = LOCKED and D15_lock = LOCKED)then
					ne377_used <= '0';
					ne111_used <= '0';
					ne290_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T04_lock = RELEASED and J35_lock = RELEASED) then
					T04_command <= RESERVE;
					J35_command <= LOCK;
				end if;
				if (T04_lock = RESERVED and J35_lock = LOCKED) then
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
				if (ne377_lock = RELEASED and ne111_used = '0' and ne111_state = OCCUPIED) then 
					ne111_used <= '1';
				end if;
				if (ne111_used = '1' and ne111_state = FREE) then
					ne111_used <= '0';
					ne111_command <= RELEASE;
				end if;
					---
				if (ne111_lock = RELEASED and ne290_used = '0' and ne290_state = OCCUPIED) then 
					ne290_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D01_command <= RELEASE;
				D14_command <= RELEASE;
				D15_command <= RELEASE;
				ne377_command <= RELEASE;
				ne111_command <= RELEASE;
				ne290_command <= RELEASE;
				T04_command <= RELEASE;
				J35_command <= RELEASE;
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