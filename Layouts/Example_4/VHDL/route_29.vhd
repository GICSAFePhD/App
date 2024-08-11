--  route_29.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R30 ['D05'] 
--dw  R30 [] 
--sc  R30 [] 
--lc  R30 ['Lc01'] 
	entity route_29 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne98 : in hex_char;
			ne98_command : out routeCommands := RELEASE;
			track_ne99 : in hex_char;
			ne99_command : out routeCommands := RELEASE;
			Lc01_state : in hex_char;
			Lc01_command : out routeCommands := RELEASE;
			D05_state : in hex_char;
			D05_command : out routeCommands := RELEASE;
			X50_state : in hex_char;
			X50_command : out routeCommands := RELEASE;
			S55_state : in hex_char;
			S55_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_29;
architecture Behavioral of route_29 is
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
	signal ne98_used , ne99_used : std_logic := '0';
	signal ne98_state : nodeStates := FREE;
	signal ne98_lock : objectLock := RELEASED;
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal Lc01_position : levelCrossingStates := UP;
	signal Lc01_lock : objectLock := RELEASED;
	signal D05_position : singleSwitchStates := NORMAL;
	signal D05_lock : objectLock := RELEASED;
	signal X50_aspectIn : signalStates := RED;
	signal X50_lock: objectLock := RELEASED;
	signal S55_aspectIn : signalStates := RED;
	signal S55_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne98_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne98)(0 to 1))));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	D05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D05_state)(2 to 3))));
	D05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D05_state)(0 to 1))));
	X50_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X50_state)(2 to 3))));
	X50_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X50_state)(0 to 1))));
	S55_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S55_state)(2 to 3))));
	S55_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S55_state)(0 to 1))));
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
				if ((ne98_lock = RELEASED and ne99_lock = RELEASED) and (ne99_state = FREE)) then
					ne98_command <= RESERVE;
					ne99_command <= RESERVE;
				end if;
				if (ne98_lock = RESERVED and ne99_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne98_lock = RESERVED and ne99_lock = RESERVED) and (ne99_state = FREE)) then
					ne98_command <= LOCK;
					ne99_command <= LOCK;
				end if;
				if (ne98_lock = LOCKED and ne99_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RELEASED and D05_lock = RELEASED) then
					Lc01_command <= RESERVE;
					D05_command <= RESERVE;
				end if;
				if (Lc01_lock = RESERVED and D05_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RESERVED and D05_lock = RESERVED) then
					Lc01_command <= LOCK;
					D05_command <= LOCK;
				end if;
				if (Lc01_lock = LOCKED and D05_lock = LOCKED)then
					ne98_used <= '0';
					ne99_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (X50_lock = RELEASED and S55_lock = RELEASED) then
					X50_command <= RESERVE;
					S55_command <= LOCK;
				end if;
				if (X50_lock = RESERVED and S55_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne98_used = '0' and ne98_state = OCCUPIED) then 
					ne98_used <= '1';
				end if;
				if (ne98_used = '1' and ne98_state = FREE) then
					ne98_used <= '0';
					ne98_command <= RELEASE;
				end if;
					---
				if (ne98_lock = RELEASED and ne99_used = '0' and ne99_state = OCCUPIED) then 
					ne99_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc01_command <= RELEASE;
				D05_command <= RELEASE;
				ne98_command <= RELEASE;
				ne99_command <= RELEASE;
				X50_command <= RELEASE;
				S55_command <= RELEASE;
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