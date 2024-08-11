--  route_34.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R35 ['D08', 'D05'] 
--dw  R35 [] 
--sc  R35 [] 
--lc  R35 [] 
	entity route_34 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne99 : in hex_char;
			ne99_command : out routeCommands := RELEASE;
			track_ne61 : in hex_char;
			ne61_command : out routeCommands := RELEASE;
			D08_state : in hex_char;
			D08_command : out routeCommands := RELEASE;
			D05_state : in hex_char;
			D05_command : out routeCommands := RELEASE;
			S55_state : in hex_char;
			S55_command : out routeCommands := RELEASE;
			S78_state : in hex_char;
			S78_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_34;
architecture Behavioral of route_34 is
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
	signal ne99_used , ne61_used : std_logic := '0';
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal ne61_state : nodeStates := FREE;
	signal ne61_lock : objectLock := RELEASED;
	signal D08_position : singleSwitchStates := NORMAL;
	signal D08_lock : objectLock := RELEASED;
	signal D05_position : singleSwitchStates := NORMAL;
	signal D05_lock : objectLock := RELEASED;
	signal S55_aspectIn : signalStates := RED;
	signal S55_lock: objectLock := RELEASED;
	signal S78_aspectIn : signalStates := RED;
	signal S78_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	ne61_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne61)(2 to 3))));
	ne61_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne61)(0 to 1))));
	D08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D08_state)(2 to 3))));
	D08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D08_state)(0 to 1))));
	D05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D05_state)(2 to 3))));
	D05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D05_state)(0 to 1))));
	S55_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S55_state)(2 to 3))));
	S55_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S55_state)(0 to 1))));
	S78_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S78_state)(2 to 3))));
	S78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S78_state)(0 to 1))));
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

				if (routingIn = ROUTE_REQUEST) then
					routeState <= RESERVING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne99_lock = RELEASED and ne61_lock = RELEASED) and (ne61_state = FREE)) then
					ne99_command <= RESERVE;
					ne61_command <= RESERVE;
				end if;
				if (ne99_lock = RESERVED and ne61_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne99_lock = RESERVED and ne61_lock = RESERVED) and (ne61_state = FREE)) then
					ne99_command <= LOCK;
					ne61_command <= LOCK;
				end if;
				if (ne99_lock = LOCKED and ne61_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D08_lock = RELEASED and D05_lock = RELEASED) then
					D08_command <= RESERVE;
					D05_command <= RESERVE;
				end if;
				if (D08_lock = RESERVED and D05_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D08_lock = RESERVED and D05_lock = RESERVED) then
					D08_command <= LOCK;
					D05_command <= LOCK;
				end if;
				if (D08_lock = LOCKED and D05_lock = LOCKED)then
					ne99_used <= '0';
					ne61_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S55_lock = RELEASED and S78_lock = RELEASED) then
					S55_command <= RESERVE;
					S78_command <= LOCK;
				end if;
				if (S55_lock = RESERVED and S78_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne99_used = '0' and ne99_state = OCCUPIED) then 
					ne99_used <= '1';
				end if;
				if (ne99_used = '1' and ne99_state = FREE) then
					ne99_used <= '0';
					ne99_command <= RELEASE;
				end if;
					---
				if (ne99_lock = RELEASED and ne61_used = '0' and ne61_state = OCCUPIED) then 
					ne61_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				D08_command <= RELEASE;
				D05_command <= RELEASE;
				ne99_command <= RELEASE;
				ne61_command <= RELEASE;
				S55_command <= RELEASE;
				S78_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;