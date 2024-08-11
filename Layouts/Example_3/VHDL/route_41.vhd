--  route_41.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R42 ['69W03', '69W04'] 
--dw  R42 [] 
--sc  R42 [] 
--lc  R42 [] 
	entity route_41 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne59 : in hex_char;
			ne59_command : out routeCommands := RELEASE;
			track_ne11 : in hex_char;
			ne11_command : out routeCommands := RELEASE;
			track_ne52 : in hex_char;
			ne52_command : out routeCommands := RELEASE;
			s69W03_state : in hex_char;
			s69W03_command : out routeCommands := RELEASE;
			s69W04_state : in hex_char;
			s69W04_command : out routeCommands := RELEASE;
			S83_state : in hex_char;
			S83_command : out routeCommands := RELEASE;
			S146_state : in hex_char;
			S146_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_41;
architecture Behavioral of route_41 is
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
	signal ne59_used , ne11_used , ne52_used : std_logic := '0';
	signal ne59_state : nodeStates := FREE;
	signal ne59_lock : objectLock := RELEASED;
	signal ne11_state : nodeStates := FREE;
	signal ne11_lock : objectLock := RELEASED;
	signal ne52_state : nodeStates := FREE;
	signal ne52_lock : objectLock := RELEASED;
	signal s69W03_position : singleSwitchStates := NORMAL;
	signal s69W03_lock : objectLock := RELEASED;
	signal s69W04_position : singleSwitchStates := NORMAL;
	signal s69W04_lock : objectLock := RELEASED;
	signal S83_aspectIn : signalStates := RED;
	signal S83_lock: objectLock := RELEASED;
	signal S146_aspectIn : signalStates := RED;
	signal S146_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne59_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne59)(2 to 3))));
	ne59_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne59)(0 to 1))));
	ne11_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne11)(2 to 3))));
	ne11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne11)(0 to 1))));
	ne52_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne52)(2 to 3))));
	ne52_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne52)(0 to 1))));
	s69W03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s69W03_state)(2 to 3))));
	s69W03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s69W03_state)(0 to 1))));
	s69W04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s69W04_state)(2 to 3))));
	s69W04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s69W04_state)(0 to 1))));
	S83_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S83_state)(2 to 3))));
	S83_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S83_state)(0 to 1))));
	S146_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S146_state)(2 to 3))));
	S146_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S146_state)(0 to 1))));
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
				if ((ne59_lock = RELEASED and ne11_lock = RELEASED and ne52_lock = RELEASED) and (ne11_state = FREE and ne52_state = FREE)) then
					ne59_command <= RESERVE;
					ne11_command <= RESERVE;
					ne52_command <= RESERVE;
				end if;
				if (ne59_lock = RESERVED and ne11_lock = RESERVED and ne52_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne59_lock = RESERVED and ne11_lock = RESERVED and ne52_lock = RESERVED) and (ne11_state = FREE and ne52_state = FREE)) then
					ne59_command <= LOCK;
					ne11_command <= LOCK;
					ne52_command <= LOCK;
				end if;
				if (ne59_lock = LOCKED and ne11_lock = LOCKED and ne52_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s69W03_lock = RELEASED and s69W04_lock = RELEASED) then
					s69W03_command <= RESERVE;
					s69W04_command <= RESERVE;
				end if;
				if (s69W03_lock = RESERVED and s69W04_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s69W03_lock = RESERVED and s69W04_lock = RESERVED) then
					s69W03_command <= LOCK;
					s69W04_command <= LOCK;
				end if;
				if (s69W03_lock = LOCKED and s69W04_lock = LOCKED)then
					ne59_used <= '0';
					ne11_used <= '0';
					ne52_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S83_lock = RELEASED and S146_lock = RELEASED) then
					S83_command <= RESERVE;
					S146_command <= LOCK;
				end if;
				if (S83_lock = RESERVED and S146_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne59_used = '0' and ne59_state = OCCUPIED) then 
					ne59_used <= '1';
				end if;
				if (ne59_used = '1' and ne59_state = FREE) then
					ne59_used <= '0';
					ne59_command <= RELEASE;
				end if;
					---
				if (ne59_lock = RELEASED and ne11_used = '0' and ne11_state = OCCUPIED) then 
					ne11_used <= '1';
				end if;
				if (ne11_used = '1' and ne11_state = FREE) then
					ne11_used <= '0';
					ne11_command <= RELEASE;
				end if;
					---
				if (ne11_lock = RELEASED and ne52_used = '0' and ne52_state = OCCUPIED) then 
					ne52_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s69W03_command <= RELEASE;
				s69W04_command <= RELEASE;
				ne59_command <= RELEASE;
				ne11_command <= RELEASE;
				ne52_command <= RELEASE;
				S83_command <= RELEASE;
				S146_command <= RELEASE;
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