--  route_35.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R36 ['D05', 'D18'] 
--dw  R36 [] 
--sc  R36 [] 
--lc  R36 [] 
	entity route_35 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne99 : in hex_char;
			ne99_command : out routeCommands := RELEASE;
			track_ne63 : in hex_char;
			ne63_command : out routeCommands := RELEASE;
			D05_state : in hex_char;
			D05_command : out routeCommands := RELEASE;
			D18_state : in hex_char;
			D18_command : out routeCommands := RELEASE;
			S55_state : in hex_char;
			S55_command : out routeCommands := RELEASE;
			S95_state : in hex_char;
			S95_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_35;
architecture Behavioral of route_35 is
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
	signal ne99_used , ne63_used : std_logic := '0';
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal ne63_state : nodeStates := FREE;
	signal ne63_lock : objectLock := RELEASED;
	signal D05_position : singleSwitchStates := NORMAL;
	signal D05_lock : objectLock := RELEASED;
	signal D18_position : singleSwitchStates := NORMAL;
	signal D18_lock : objectLock := RELEASED;
	signal S55_aspectIn : signalStates := RED;
	signal S55_lock: objectLock := RELEASED;
	signal S95_aspectIn : signalStates := RED;
	signal S95_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	ne63_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne63)(2 to 3))));
	ne63_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne63)(0 to 1))));
	D05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D05_state)(2 to 3))));
	D05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D05_state)(0 to 1))));
	D18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D18_state)(2 to 3))));
	D18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D18_state)(0 to 1))));
	S55_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S55_state)(2 to 3))));
	S55_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S55_state)(0 to 1))));
	S95_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S95_state)(2 to 3))));
	S95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S95_state)(0 to 1))));
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
				if ((ne99_lock = RELEASED and ne63_lock = RELEASED) and (ne63_state = FREE)) then
					ne99_command <= RESERVE;
					ne63_command <= RESERVE;
				end if;
				if (ne99_lock = RESERVED and ne63_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne99_lock = RESERVED and ne63_lock = RESERVED) and (ne63_state = FREE)) then
					ne99_command <= LOCK;
					ne63_command <= LOCK;
				end if;
				if (ne99_lock = LOCKED and ne63_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D05_lock = RELEASED and D18_lock = RELEASED) then
					D05_command <= RESERVE;
					D18_command <= RESERVE;
				end if;
				if (D05_lock = RESERVED and D18_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D05_lock = RESERVED and D18_lock = RESERVED) then
					D05_command <= LOCK;
					D18_command <= LOCK;
				end if;
				if (D05_lock = LOCKED and D18_lock = LOCKED)then
					ne99_used <= '0';
					ne63_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S55_lock = RELEASED and S95_lock = RELEASED) then
					S55_command <= RESERVE;
					S95_command <= LOCK;
				end if;
				if (S55_lock = RESERVED and S95_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
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
				if (ne99_lock = RELEASED and ne63_used = '0' and ne63_state = OCCUPIED) then 
					ne63_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D05_command <= RELEASE;
				D18_command <= RELEASE;
				ne99_command <= RELEASE;
				ne63_command <= RELEASE;
				S55_command <= RELEASE;
				S95_command <= RELEASE;
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