--  route_56.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R57 ['D10', 'D23'] 
--dw  R57 [] 
--sc  R57 [] 
--lc  R57 [] 
	entity route_56 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne910 : in hex_char;
			ne910_command : out routeCommands := RELEASE;
			track_ne130 : in hex_char;
			ne130_command : out routeCommands := RELEASE;
			D10_state : in hex_char;
			D10_command : out routeCommands := RELEASE;
			D23_state : in hex_char;
			D23_command : out routeCommands := RELEASE;
			S81_state : in hex_char;
			S81_command : out routeCommands := RELEASE;
			S107_state : in hex_char;
			S107_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_56;
architecture Behavioral of route_56 is
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
	signal ne910_used , ne130_used : std_logic := '0';
	signal ne910_state : nodeStates := FREE;
	signal ne910_lock : objectLock := RELEASED;
	signal ne130_state : nodeStates := FREE;
	signal ne130_lock : objectLock := RELEASED;
	signal D10_position : singleSwitchStates := NORMAL;
	signal D10_lock : objectLock := RELEASED;
	signal D23_position : singleSwitchStates := NORMAL;
	signal D23_lock : objectLock := RELEASED;
	signal S81_aspectIn : signalStates := RED;
	signal S81_lock: objectLock := RELEASED;
	signal S107_aspectIn : signalStates := RED;
	signal S107_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne910_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne910)(2 to 3))));
	ne910_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne910)(0 to 1))));
	ne130_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne130)(2 to 3))));
	ne130_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne130)(0 to 1))));
	D10_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D10_state)(2 to 3))));
	D10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D10_state)(0 to 1))));
	D23_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D23_state)(2 to 3))));
	D23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D23_state)(0 to 1))));
	S81_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S81_state)(2 to 3))));
	S81_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S81_state)(0 to 1))));
	S107_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S107_state)(2 to 3))));
	S107_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S107_state)(0 to 1))));
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
				if ((ne910_lock = RELEASED and ne130_lock = RELEASED) and (ne130_state = FREE)) then
					ne910_command <= RESERVE;
					ne130_command <= RESERVE;
				end if;
				if (ne910_lock = RESERVED and ne130_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne910_lock = RESERVED and ne130_lock = RESERVED) and (ne130_state = FREE)) then
					ne910_command <= LOCK;
					ne130_command <= LOCK;
				end if;
				if (ne910_lock = LOCKED and ne130_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D10_lock = RELEASED and D23_lock = RELEASED) then
					D10_command <= RESERVE;
					D23_command <= RESERVE;
				end if;
				if (D10_lock = RESERVED and D23_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D10_lock = RESERVED and D23_lock = RESERVED) then
					D10_command <= LOCK;
					D23_command <= LOCK;
				end if;
				if (D10_lock = LOCKED and D23_lock = LOCKED)then
					ne910_used <= '0';
					ne130_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S81_lock = RELEASED and S107_lock = RELEASED) then
					S81_command <= RESERVE;
					S107_command <= LOCK;
				end if;
				if (S81_lock = RESERVED and S107_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne910_used = '0' and ne910_state = OCCUPIED) then 
					ne910_used <= '1';
				end if;
				if (ne910_used = '1' and ne910_state = FREE) then
					ne910_used <= '0';
					ne910_command <= RELEASE;
				end if;
					---
				if (ne910_lock = RELEASED and ne130_used = '0' and ne130_state = OCCUPIED) then 
					ne130_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D10_command <= RELEASE;
				D23_command <= RELEASE;
				ne910_command <= RELEASE;
				ne130_command <= RELEASE;
				S81_command <= RELEASE;
				S107_command <= RELEASE;
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