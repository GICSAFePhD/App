--  route_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R2 ['68W02'] 
--dw  R2 [] 
--sc  R2 [] 
--lc  R2 [] 
	entity route_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne7 : in hex_char;
			ne7_command : out routeCommands := RELEASE;
			s68W02_state : in hex_char;
			s68W02_command : out routeCommands := RELEASE;
			T06_state : in hex_char;
			T06_command : out routeCommands := RELEASE;
			J43_state : in hex_char;
			J43_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_1;
architecture Behavioral of route_1 is
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
	signal ne7_used : std_logic := '0';
	signal ne7_state : nodeStates := FREE;
	signal ne7_lock : objectLock := RELEASED;
	signal s68W02_position : singleSwitchStates := NORMAL;
	signal s68W02_lock : objectLock := RELEASED;
	signal T06_aspectIn : signalStates := RED;
	signal T06_lock: objectLock := RELEASED;
	signal J43_aspectIn : signalStates := RED;
	signal J43_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne7_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne7)(2 to 3))));
	ne7_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne7)(0 to 1))));
	s68W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s68W02_state)(2 to 3))));
	s68W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s68W02_state)(0 to 1))));
	T06_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T06_state)(2 to 3))));
	T06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T06_state)(0 to 1))));
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
				if (ne7_lock = RELEASED) then
					ne7_command <= RESERVE;
				end if;
				if (ne7_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne7_lock = RESERVED) then
					ne7_command <= LOCK;
				end if;
				if (ne7_lock = LOCKED)then
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
					ne7_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T06_lock = RELEASED and J43_lock = RELEASED) then
					T06_command <= RESERVE;
					J43_command <= LOCK;
				end if;
				if (T06_lock = RESERVED and J43_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne7_used = '0' and ne7_state = OCCUPIED) then 
					ne7_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s68W02_command <= RELEASE;
				ne7_command <= RELEASE;
				T06_command <= RELEASE;
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