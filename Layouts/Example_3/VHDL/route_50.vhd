--  route_50.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R51 ['70W02'] 
--dw  R51 [] 
--sc  R51 [] 
--lc  R51 [] 
	entity route_50 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne26 : in hex_char;
			ne26_command : out routeCommands := RELEASE;
			track_ne24 : in hex_char;
			ne24_command : out routeCommands := RELEASE;
			s70W02_state : in hex_char;
			s70W02_command : out routeCommands := RELEASE;
			S93_state : in hex_char;
			S93_command : out routeCommands := RELEASE;
			P63_state : in hex_char;
			P63_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_50;
architecture Behavioral of route_50 is
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
	signal ne26_used , ne24_used : std_logic := '0';
	signal ne26_state : nodeStates := FREE;
	signal ne26_lock : objectLock := RELEASED;
	signal ne24_state : nodeStates := FREE;
	signal ne24_lock : objectLock := RELEASED;
	signal s70W02_position : singleSwitchStates := NORMAL;
	signal s70W02_lock : objectLock := RELEASED;
	signal S93_aspectIn : signalStates := RED;
	signal S93_lock: objectLock := RELEASED;
	signal P63_aspectIn : signalStates := RED;
	signal P63_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne26_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne26)(2 to 3))));
	ne26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne26)(0 to 1))));
	ne24_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne24)(2 to 3))));
	ne24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne24)(0 to 1))));
	s70W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s70W02_state)(2 to 3))));
	s70W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s70W02_state)(0 to 1))));
	S93_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S93_state)(2 to 3))));
	S93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S93_state)(0 to 1))));
	P63_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P63_state)(2 to 3))));
	P63_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P63_state)(0 to 1))));
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
				if ((ne26_lock = RELEASED and ne24_lock = RELEASED) and (ne24_state = FREE)) then
					ne26_command <= RESERVE;
					ne24_command <= RESERVE;
				end if;
				if (ne26_lock = RESERVED and ne24_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne26_lock = RESERVED and ne24_lock = RESERVED) and (ne24_state = FREE)) then
					ne26_command <= LOCK;
					ne24_command <= LOCK;
				end if;
				if (ne26_lock = LOCKED and ne24_lock = LOCKED)then
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
					ne26_used <= '0';
					ne24_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S93_lock = RELEASED and P63_lock = RELEASED) then
					S93_command <= RESERVE;
					P63_command <= LOCK;
				end if;
				if (S93_lock = RESERVED and P63_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne26_used = '0' and ne26_state = OCCUPIED) then 
					ne26_used <= '1';
				end if;
				if (ne26_used = '1' and ne26_state = FREE) then
					ne26_used <= '0';
					ne26_command <= RELEASE;
				end if;
					---
				if (ne26_lock = RELEASED and ne24_used = '0' and ne24_state = OCCUPIED) then 
					ne24_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s70W02_command <= RELEASE;
				ne26_command <= RELEASE;
				ne24_command <= RELEASE;
				S93_command <= RELEASE;
				P63_command <= RELEASE;
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