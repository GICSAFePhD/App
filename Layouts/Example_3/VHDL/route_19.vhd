--  route_19.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R20 ['Sw41'] 
--dw  R20 [] 
--sc  R20 [] 
--lc  R20 [] 
	entity route_19 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne101 : in hex_char;
			ne101_command : out routeCommands := RELEASE;
			track_ne100 : in hex_char;
			ne100_command : out routeCommands := RELEASE;
			Sw41_state : in hex_char;
			Sw41_command : out routeCommands := RELEASE;
			L40_state : in hex_char;
			L40_command : out routeCommands := RELEASE;
			S139_state : in hex_char;
			S139_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_19;
architecture Behavioral of route_19 is
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
	signal ne101_used , ne100_used : std_logic := '0';
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal Sw41_position : singleSwitchStates := NORMAL;
	signal Sw41_lock : objectLock := RELEASED;
	signal L40_aspectIn : signalStates := RED;
	signal L40_lock: objectLock := RELEASED;
	signal S139_aspectIn : signalStates := RED;
	signal S139_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	Sw41_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw41_state)(2 to 3))));
	Sw41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw41_state)(0 to 1))));
	L40_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L40_state)(2 to 3))));
	L40_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L40_state)(0 to 1))));
	S139_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S139_state)(2 to 3))));
	S139_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S139_state)(0 to 1))));
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
				if ((ne101_lock = RELEASED and ne100_lock = RELEASED) and (ne100_state = FREE)) then
					ne101_command <= RESERVE;
					ne100_command <= RESERVE;
				end if;
				if (ne101_lock = RESERVED and ne100_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne101_lock = RESERVED and ne100_lock = RESERVED) and (ne100_state = FREE)) then
					ne101_command <= LOCK;
					ne100_command <= LOCK;
				end if;
				if (ne101_lock = LOCKED and ne100_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw41_lock = RELEASED) then
					Sw41_command <= RESERVE;
				end if;
				if (Sw41_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw41_lock = RESERVED) then
					Sw41_command <= LOCK;
				end if;
				if (Sw41_lock = LOCKED)then
					ne101_used <= '0';
					ne100_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (L40_lock = RELEASED and S139_lock = RELEASED) then
					L40_command <= RESERVE;
					S139_command <= LOCK;
				end if;
				if (L40_lock = RESERVED and S139_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne101_used = '0' and ne101_state = OCCUPIED) then 
					ne101_used <= '1';
				end if;
				if (ne101_used = '1' and ne101_state = FREE) then
					ne101_used <= '0';
					ne101_command <= RELEASE;
				end if;
					---
				if (ne101_lock = RELEASED and ne100_used = '0' and ne100_state = OCCUPIED) then 
					ne100_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw41_command <= RELEASE;
				ne101_command <= RELEASE;
				ne100_command <= RELEASE;
				L40_command <= RELEASE;
				S139_command <= RELEASE;
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