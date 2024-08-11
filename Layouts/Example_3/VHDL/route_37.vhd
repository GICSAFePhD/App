--  route_37.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R38 ['68W02'] 
--dw  R38 [] 
--sc  R38 [] 
--lc  R38 [] 
	entity route_37 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne9 : in hex_char;
			ne9_command : out routeCommands := RELEASE;
			s68W02_state : in hex_char;
			s68W02_command : out routeCommands := RELEASE;
			C78_state : in hex_char;
			C78_command : out routeCommands := RELEASE;
			J46_state : in hex_char;
			J46_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_37;
architecture Behavioral of route_37 is
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
	signal ne1_used , ne9_used : std_logic := '0';
	signal ne1_state : nodeStates := FREE;
	signal ne1_lock : objectLock := RELEASED;
	signal ne9_state : nodeStates := FREE;
	signal ne9_lock : objectLock := RELEASED;
	signal s68W02_position : singleSwitchStates := NORMAL;
	signal s68W02_lock : objectLock := RELEASED;
	signal C78_aspectIn : signalStates := RED;
	signal C78_lock: objectLock := RELEASED;
	signal J46_aspectIn : signalStates := RED;
	signal J46_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne1_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne1)(2 to 3))));
	ne1_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne1)(0 to 1))));
	ne9_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne9)(2 to 3))));
	ne9_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne9)(0 to 1))));
	s68W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s68W02_state)(2 to 3))));
	s68W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s68W02_state)(0 to 1))));
	C78_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C78_state)(2 to 3))));
	C78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C78_state)(0 to 1))));
	J46_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J46_state)(2 to 3))));
	J46_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J46_state)(0 to 1))));
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
				if ((ne1_lock = RELEASED and ne9_lock = RELEASED) and (ne9_state = FREE)) then
					ne1_command <= RESERVE;
					ne9_command <= RESERVE;
				end if;
				if (ne1_lock = RESERVED and ne9_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne1_lock = RESERVED and ne9_lock = RESERVED) and (ne9_state = FREE)) then
					ne1_command <= LOCK;
					ne9_command <= LOCK;
				end if;
				if (ne1_lock = LOCKED and ne9_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s68W02_lock = RELEASED) then
					s68W02_command <= RESERVE;
				end if;
				if (s68W02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s68W02_lock = RESERVED) then
					s68W02_command <= LOCK;
				end if;
				if (s68W02_lock = LOCKED)then
					ne1_used <= '0';
					ne9_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (C78_lock = RELEASED and J46_lock = RELEASED) then
					C78_command <= RESERVE;
					J46_command <= LOCK;
				end if;
				if (C78_lock = RESERVED and J46_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne1_used = '0' and ne1_state = OCCUPIED) then 
					ne1_used <= '1';
				end if;
				if (ne1_used = '1' and ne1_state = FREE) then
					ne1_used <= '0';
					ne1_command <= RELEASE;
				end if;
					---
				if (ne1_lock = RELEASED and ne9_used = '0' and ne9_state = OCCUPIED) then 
					ne9_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s68W02_command <= RELEASE;
				ne1_command <= RELEASE;
				ne9_command <= RELEASE;
				C78_command <= RELEASE;
				J46_command <= RELEASE;
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