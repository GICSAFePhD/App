--  route_52.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R53 ['D08', 'D07'] 
--dw  R53 [] 
--sc  R53 [] 
--lc  R53 [] 
	entity route_52 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne61 : in hex_char;
			ne61_command : out routeCommands := RELEASE;
			track_ne404 : in hex_char;
			ne404_command : out routeCommands := RELEASE;
			D08_state : in hex_char;
			D08_command : out routeCommands := RELEASE;
			D07_state : in hex_char;
			D07_command : out routeCommands := RELEASE;
			S78_state : in hex_char;
			S78_command : out routeCommands := RELEASE;
			C73_state : in hex_char;
			C73_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_52;
architecture Behavioral of route_52 is
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
	signal ne61_used , ne404_used : std_logic := '0';
	signal ne61_state : nodeStates := FREE;
	signal ne61_lock : objectLock := RELEASED;
	signal ne404_state : nodeStates := FREE;
	signal ne404_lock : objectLock := RELEASED;
	signal D08_position : singleSwitchStates := NORMAL;
	signal D08_lock : objectLock := RELEASED;
	signal D07_position : singleSwitchStates := NORMAL;
	signal D07_lock : objectLock := RELEASED;
	signal S78_aspectIn : signalStates := RED;
	signal S78_lock: objectLock := RELEASED;
	signal C73_aspectIn : signalStates := RED;
	signal C73_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne61_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne61)(2 to 3))));
	ne61_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne61)(0 to 1))));
	ne404_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne404)(2 to 3))));
	ne404_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne404)(0 to 1))));
	D08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D08_state)(2 to 3))));
	D08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D08_state)(0 to 1))));
	D07_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D07_state)(2 to 3))));
	D07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D07_state)(0 to 1))));
	S78_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S78_state)(2 to 3))));
	S78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S78_state)(0 to 1))));
	C73_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C73_state)(2 to 3))));
	C73_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C73_state)(0 to 1))));
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
				if ((ne61_lock = RELEASED and ne404_lock = RELEASED) and (ne404_state = FREE)) then
					ne61_command <= RESERVE;
					ne404_command <= RESERVE;
				end if;
				if (ne61_lock = RESERVED and ne404_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne61_lock = RESERVED and ne404_lock = RESERVED) and (ne404_state = FREE)) then
					ne61_command <= LOCK;
					ne404_command <= LOCK;
				end if;
				if (ne61_lock = LOCKED and ne404_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D08_lock = RELEASED and D07_lock = RELEASED) then
					D08_command <= RESERVE;
					D07_command <= RESERVE;
				end if;
				if (D08_lock = RESERVED and D07_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D08_lock = RESERVED and D07_lock = RESERVED) then
					D08_command <= LOCK;
					D07_command <= LOCK;
				end if;
				if (D08_lock = LOCKED and D07_lock = LOCKED)then
					ne61_used <= '0';
					ne404_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S78_lock = RELEASED and C73_lock = RELEASED) then
					S78_command <= RESERVE;
					C73_command <= LOCK;
				end if;
				if (S78_lock = RESERVED and C73_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne61_used = '0' and ne61_state = OCCUPIED) then 
					ne61_used <= '1';
				end if;
				if (ne61_used = '1' and ne61_state = FREE) then
					ne61_used <= '0';
					ne61_command <= RELEASE;
				end if;
					---
				if (ne61_lock = RELEASED and ne404_used = '0' and ne404_state = OCCUPIED) then 
					ne404_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D08_command <= RELEASE;
				D07_command <= RELEASE;
				ne61_command <= RELEASE;
				ne404_command <= RELEASE;
				S78_command <= RELEASE;
				C73_command <= RELEASE;
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