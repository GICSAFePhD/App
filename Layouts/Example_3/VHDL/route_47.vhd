--  route_47.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R48 ['70W01', '70W02'] 
--dw  R48 [] 
--sc  R48 [] 
--lc  R48 [] 
	entity route_47 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne64 : in hex_char;
			ne64_command : out routeCommands := RELEASE;
			track_ne24 : in hex_char;
			ne24_command : out routeCommands := RELEASE;
			s70W01_state : in hex_char;
			s70W01_command : out routeCommands := RELEASE;
			s70W02_state : in hex_char;
			s70W02_command : out routeCommands := RELEASE;
			S90_state : in hex_char;
			S90_command : out routeCommands := RELEASE;
			B92_state : in hex_char;
			B92_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_47;
architecture Behavioral of route_47 is
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
	signal ne64_used , ne24_used : std_logic := '0';
	signal ne64_state : nodeStates := FREE;
	signal ne64_lock : objectLock := RELEASED;
	signal ne24_state : nodeStates := FREE;
	signal ne24_lock : objectLock := RELEASED;
	signal s70W01_position : singleSwitchStates := NORMAL;
	signal s70W01_lock : objectLock := RELEASED;
	signal s70W02_position : singleSwitchStates := NORMAL;
	signal s70W02_lock : objectLock := RELEASED;
	signal S90_aspectIn : signalStates := RED;
	signal S90_lock: objectLock := RELEASED;
	signal B92_aspectIn : signalStates := RED;
	signal B92_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne64_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne64)(2 to 3))));
	ne64_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne64)(0 to 1))));
	ne24_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne24)(2 to 3))));
	ne24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne24)(0 to 1))));
	s70W01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s70W01_state)(2 to 3))));
	s70W01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s70W01_state)(0 to 1))));
	s70W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s70W02_state)(2 to 3))));
	s70W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s70W02_state)(0 to 1))));
	S90_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S90_state)(2 to 3))));
	S90_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S90_state)(0 to 1))));
	B92_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B92_state)(2 to 3))));
	B92_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B92_state)(0 to 1))));
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
				if ((ne64_lock = RELEASED and ne24_lock = RELEASED) and (ne24_state = FREE)) then
					ne64_command <= RESERVE;
					ne24_command <= RESERVE;
				end if;
				if (ne64_lock = RESERVED and ne24_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne64_lock = RESERVED and ne24_lock = RESERVED) and (ne24_state = FREE)) then
					ne64_command <= LOCK;
					ne24_command <= LOCK;
				end if;
				if (ne64_lock = LOCKED and ne24_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s70W01_lock = RELEASED and s70W02_lock = RELEASED) then
					s70W01_command <= RESERVE;
					s70W02_command <= RESERVE;
				end if;
				if (s70W01_lock = RESERVED and s70W02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s70W01_lock = RESERVED and s70W02_lock = RESERVED) then
					s70W01_command <= LOCK;
					s70W02_command <= LOCK;
				end if;
				if (s70W01_lock = LOCKED and s70W02_lock = LOCKED)then
					ne64_used <= '0';
					ne24_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S90_lock = RELEASED and B92_lock = RELEASED) then
					S90_command <= RESERVE;
					B92_command <= LOCK;
				end if;
				if (S90_lock = RESERVED and B92_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne64_used = '0' and ne64_state = OCCUPIED) then 
					ne64_used <= '1';
				end if;
				if (ne64_used = '1' and ne64_state = FREE) then
					ne64_used <= '0';
					ne64_command <= RELEASE;
				end if;
					---
				if (ne64_lock = RELEASED and ne24_used = '0' and ne24_state = OCCUPIED) then 
					ne24_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s70W01_command <= RELEASE;
				s70W02_command <= RELEASE;
				ne64_command <= RELEASE;
				ne24_command <= RELEASE;
				S90_command <= RELEASE;
				B92_command <= RELEASE;
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