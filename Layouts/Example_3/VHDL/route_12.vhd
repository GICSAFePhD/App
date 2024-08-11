--  route_12.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R13 ['71W01'] 
--dw  R13 [] 
--sc  R13 [] 
--lc  R13 [] 
	entity route_12 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne65 : in hex_char;
			ne65_command : out routeCommands := RELEASE;
			track_ne102 : in hex_char;
			ne102_command : out routeCommands := RELEASE;
			s71W01_state : in hex_char;
			s71W01_command : out routeCommands := RELEASE;
			L30_state : in hex_char;
			L30_command : out routeCommands := RELEASE;
			C104_state : in hex_char;
			C104_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_12;
architecture Behavioral of route_12 is
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
	signal ne65_used , ne102_used : std_logic := '0';
	signal ne65_state : nodeStates := FREE;
	signal ne65_lock : objectLock := RELEASED;
	signal ne102_state : nodeStates := FREE;
	signal ne102_lock : objectLock := RELEASED;
	signal s71W01_position : singleSwitchStates := NORMAL;
	signal s71W01_lock : objectLock := RELEASED;
	signal L30_aspectIn : signalStates := RED;
	signal L30_lock: objectLock := RELEASED;
	signal C104_aspectIn : signalStates := RED;
	signal C104_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne65_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne65)(2 to 3))));
	ne65_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne65)(0 to 1))));
	ne102_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne102)(2 to 3))));
	ne102_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne102)(0 to 1))));
	s71W01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s71W01_state)(2 to 3))));
	s71W01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s71W01_state)(0 to 1))));
	L30_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L30_state)(2 to 3))));
	L30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L30_state)(0 to 1))));
	C104_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C104_state)(2 to 3))));
	C104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C104_state)(0 to 1))));
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

				if (routingIn = ROUTE_REQUEST) then
					routeState <= RESERVING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne65_lock = RELEASED and ne102_lock = RELEASED) and (ne102_state = FREE)) then
					ne65_command <= RESERVE;
					ne102_command <= RESERVE;
				end if;
				if (ne65_lock = RESERVED and ne102_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne65_lock = RESERVED and ne102_lock = RESERVED) and (ne102_state = FREE)) then
					ne65_command <= LOCK;
					ne102_command <= LOCK;
				end if;
				if (ne65_lock = LOCKED and ne102_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s71W01_lock = RELEASED) then
					s71W01_command <= RESERVE;
				end if;
				if (s71W01_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s71W01_lock = RESERVED) then
					s71W01_command <= LOCK;
				end if;
				if (s71W01_lock = LOCKED)then
					ne65_used <= '0';
					ne102_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (L30_lock = RELEASED and C104_lock = RELEASED) then
					L30_command <= RESERVE;
					C104_command <= LOCK;
				end if;
				if (L30_lock = RESERVED and C104_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne65_used = '0' and ne65_state = OCCUPIED) then 
					ne65_used <= '1';
				end if;
				if (ne65_used = '1' and ne65_state = FREE) then
					ne65_used <= '0';
					ne65_command <= RELEASE;
				end if;
					---
				if (ne65_lock = RELEASED and ne102_used = '0' and ne102_state = OCCUPIED) then 
					ne102_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				s71W01_command <= RELEASE;
				ne65_command <= RELEASE;
				ne102_command <= RELEASE;
				L30_command <= RELEASE;
				C104_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;