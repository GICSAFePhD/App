--  route_25.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R26 ['D09'] 
--dw  R26 [] 
--sc  R26 [] 
--lc  R26 [] 
	entity route_25 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne912 : in hex_char;
			ne912_command : out routeCommands := RELEASE;
			track_ne101 : in hex_char;
			ne101_command : out routeCommands := RELEASE;
			D09_state : in hex_char;
			D09_command : out routeCommands := RELEASE;
			J45_state : in hex_char;
			J45_command : out routeCommands := RELEASE;
			J43_state : in hex_char;
			J43_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_25;
architecture Behavioral of route_25 is
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
	signal ne912_used , ne101_used : std_logic := '0';
	signal ne912_state : nodeStates := FREE;
	signal ne912_lock : objectLock := RELEASED;
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal D09_position : singleSwitchStates := NORMAL;
	signal D09_lock : objectLock := RELEASED;
	signal J45_aspectIn : signalStates := RED;
	signal J45_lock: objectLock := RELEASED;
	signal J43_aspectIn : signalStates := RED;
	signal J43_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne912_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne912)(2 to 3))));
	ne912_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne912)(0 to 1))));
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	D09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D09_state)(2 to 3))));
	D09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D09_state)(0 to 1))));
	J45_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J45_state)(2 to 3))));
	J45_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J45_state)(0 to 1))));
	J43_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J43_state)(2 to 3))));
	J43_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J43_state)(0 to 1))));
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
				if ((ne912_lock = RELEASED and ne101_lock = RELEASED) and (ne101_state = FREE)) then
					ne912_command <= RESERVE;
					ne101_command <= RESERVE;
				end if;
				if (ne912_lock = RESERVED and ne101_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne912_lock = RESERVED and ne101_lock = RESERVED) and (ne101_state = FREE)) then
					ne912_command <= LOCK;
					ne101_command <= LOCK;
				end if;
				if (ne912_lock = LOCKED and ne101_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D09_lock = RELEASED) then
					D09_command <= RESERVE;
				end if;
				if (D09_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D09_lock = RESERVED) then
					D09_command <= LOCK;
				end if;
				if (D09_lock = LOCKED)then
					ne912_used <= '0';
					ne101_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (J45_lock = RELEASED and J43_lock = RELEASED) then
					J45_command <= RESERVE;
					J43_command <= LOCK;
				end if;
				if (J45_lock = RESERVED and J43_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne912_used = '0' and ne912_state = OCCUPIED) then 
					ne912_used <= '1';
				end if;
				if (ne912_used = '1' and ne912_state = FREE) then
					ne912_used <= '0';
					ne912_command <= RELEASE;
				end if;
					---
				if (ne912_lock = RELEASED and ne101_used = '0' and ne101_state = OCCUPIED) then 
					ne101_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D09_command <= RELEASE;
				ne912_command <= RELEASE;
				ne101_command <= RELEASE;
				J45_command <= RELEASE;
				J43_command <= RELEASE;
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