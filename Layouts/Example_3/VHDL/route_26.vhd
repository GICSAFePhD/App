--  route_26.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R27 ['70W02'] 
--dw  R27 [] 
--sc  R27 [] 
--lc  R27 [] 
	entity route_26 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			track_ne26 : in hex_char;
			ne26_command : out routeCommands := RELEASE;
			s70W02_state : in hex_char;
			s70W02_command : out routeCommands := RELEASE;
			P60_state : in hex_char;
			P60_command : out routeCommands := RELEASE;
			L27_state : in hex_char;
			L27_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_26;
architecture Behavioral of route_26 is
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
	signal ne23_used , ne26_used : std_logic := '0';
	signal ne23_state : nodeStates := FREE;
	signal ne23_lock : objectLock := RELEASED;
	signal ne26_state : nodeStates := FREE;
	signal ne26_lock : objectLock := RELEASED;
	signal s70W02_position : singleSwitchStates := NORMAL;
	signal s70W02_lock : objectLock := RELEASED;
	signal P60_aspectIn : signalStates := RED;
	signal P60_lock: objectLock := RELEASED;
	signal L27_aspectIn : signalStates := RED;
	signal L27_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne23_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne23)(2 to 3))));
	ne23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne23)(0 to 1))));
	ne26_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne26)(2 to 3))));
	ne26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne26)(0 to 1))));
	s70W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s70W02_state)(2 to 3))));
	s70W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s70W02_state)(0 to 1))));
	P60_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P60_state)(2 to 3))));
	P60_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P60_state)(0 to 1))));
	L27_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L27_state)(2 to 3))));
	L27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L27_state)(0 to 1))));
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
				if ((ne23_lock = RELEASED and ne26_lock = RELEASED) and (ne26_state = FREE)) then
					ne23_command <= RESERVE;
					ne26_command <= RESERVE;
				end if;
				if (ne23_lock = RESERVED and ne26_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne23_lock = RESERVED and ne26_lock = RESERVED) and (ne26_state = FREE)) then
					ne23_command <= LOCK;
					ne26_command <= LOCK;
				end if;
				if (ne23_lock = LOCKED and ne26_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s70W02_lock = RELEASED) then
					s70W02_command <= RESERVE;
				end if;
				if (s70W02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s70W02_lock = RESERVED) then
					s70W02_command <= LOCK;
				end if;
				if (s70W02_lock = LOCKED)then
					ne23_used <= '0';
					ne26_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (P60_lock = RELEASED and L27_lock = RELEASED) then
					P60_command <= RESERVE;
					L27_command <= LOCK;
				end if;
				if (P60_lock = RESERVED and L27_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne23_used = '0' and ne23_state = OCCUPIED) then 
					ne23_used <= '1';
				end if;
				if (ne23_used = '1' and ne23_state = FREE) then
					ne23_used <= '0';
					ne23_command <= RELEASE;
				end if;
					---
				if (ne23_lock = RELEASED and ne26_used = '0' and ne26_state = OCCUPIED) then 
					ne26_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s70W02_command <= RELEASE;
				ne23_command <= RELEASE;
				ne26_command <= RELEASE;
				P60_command <= RELEASE;
				L27_command <= RELEASE;
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