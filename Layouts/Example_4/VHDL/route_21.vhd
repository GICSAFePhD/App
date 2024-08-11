--  route_21.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R22 ['D01', 'D14'] 
--dw  R22 [] 
--sc  R22 [] 
--lc  R22 [] 
	entity route_21 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne292 : in hex_char;
			ne292_command : out routeCommands := RELEASE;
			track_ne290 : in hex_char;
			ne290_command : out routeCommands := RELEASE;
			D01_state : in hex_char;
			D01_command : out routeCommands := RELEASE;
			D14_state : in hex_char;
			D14_command : out routeCommands := RELEASE;
			J37_state : in hex_char;
			J37_command : out routeCommands := RELEASE;
			J35_state : in hex_char;
			J35_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_21;
architecture Behavioral of route_21 is
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
	signal ne292_used , ne290_used : std_logic := '0';
	signal ne292_state : nodeStates := FREE;
	signal ne292_lock : objectLock := RELEASED;
	signal ne290_state : nodeStates := FREE;
	signal ne290_lock : objectLock := RELEASED;
	signal D01_position : singleSwitchStates := NORMAL;
	signal D01_lock : objectLock := RELEASED;
	signal D14_position : singleSwitchStates := NORMAL;
	signal D14_lock : objectLock := RELEASED;
	signal J37_aspectIn : signalStates := RED;
	signal J37_lock: objectLock := RELEASED;
	signal J35_aspectIn : signalStates := RED;
	signal J35_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne292_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne292)(2 to 3))));
	ne292_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne292)(0 to 1))));
	ne290_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne290)(2 to 3))));
	ne290_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne290)(0 to 1))));
	D01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D01_state)(2 to 3))));
	D01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D01_state)(0 to 1))));
	D14_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D14_state)(2 to 3))));
	D14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D14_state)(0 to 1))));
	J37_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J37_state)(2 to 3))));
	J37_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J37_state)(0 to 1))));
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
				if ((ne292_lock = RELEASED and ne290_lock = RELEASED) and (ne290_state = FREE)) then
					ne292_command <= RESERVE;
					ne290_command <= RESERVE;
				end if;
				if (ne292_lock = RESERVED and ne290_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne292_lock = RESERVED and ne290_lock = RESERVED) and (ne290_state = FREE)) then
					ne292_command <= LOCK;
					ne290_command <= LOCK;
				end if;
				if (ne292_lock = LOCKED and ne290_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D01_lock = RELEASED and D14_lock = RELEASED) then
					D01_command <= RESERVE;
					D14_command <= RESERVE;
				end if;
				if (D01_lock = RESERVED and D14_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D01_lock = RESERVED and D14_lock = RESERVED) then
					D01_command <= LOCK;
					D14_command <= LOCK;
				end if;
				if (D01_lock = LOCKED and D14_lock = LOCKED)then
					ne292_used <= '0';
					ne290_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (J37_lock = RELEASED and J35_lock = RELEASED) then
					J37_command <= RESERVE;
					J35_command <= LOCK;
				end if;
				if (J37_lock = RESERVED and J35_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne292_used = '0' and ne292_state = OCCUPIED) then 
					ne292_used <= '1';
				end if;
				if (ne292_used = '1' and ne292_state = FREE) then
					ne292_used <= '0';
					ne292_command <= RELEASE;
				end if;
					---
				if (ne292_lock = RELEASED and ne290_used = '0' and ne290_state = OCCUPIED) then 
					ne290_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D01_command <= RELEASE;
				D14_command <= RELEASE;
				ne292_command <= RELEASE;
				ne290_command <= RELEASE;
				J37_command <= RELEASE;
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