--  route_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R5 ['D19'] 
--dw  R5 [] 
--sc  R5 [] 
--lc  R5 [] 
	entity route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne421 : in hex_char;
			ne421_command : out routeCommands := RELEASE;
			track_ne126 : in hex_char;
			ne126_command : out routeCommands := RELEASE;
			D19_state : in hex_char;
			D19_command : out routeCommands := RELEASE;
			T06_state : in hex_char;
			T06_command : out routeCommands := RELEASE;
			T19_state : in hex_char;
			T19_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_4;
architecture Behavioral of route_4 is
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
	signal ne421_used , ne126_used : std_logic := '0';
	signal ne421_state : nodeStates := FREE;
	signal ne421_lock : objectLock := RELEASED;
	signal ne126_state : nodeStates := FREE;
	signal ne126_lock : objectLock := RELEASED;
	signal D19_position : singleSwitchStates := NORMAL;
	signal D19_lock : objectLock := RELEASED;
	signal T06_aspectIn : signalStates := RED;
	signal T06_lock: objectLock := RELEASED;
	signal T19_aspectIn : signalStates := RED;
	signal T19_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne421_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne421)(2 to 3))));
	ne421_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne421)(0 to 1))));
	ne126_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne126)(2 to 3))));
	ne126_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne126)(0 to 1))));
	D19_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D19_state)(2 to 3))));
	D19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D19_state)(0 to 1))));
	T06_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T06_state)(2 to 3))));
	T06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T06_state)(0 to 1))));
	T19_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T19_state)(2 to 3))));
	T19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T19_state)(0 to 1))));
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
				if ((ne421_lock = RELEASED and ne126_lock = RELEASED) and (ne126_state = FREE)) then
					ne421_command <= RESERVE;
					ne126_command <= RESERVE;
				end if;
				if (ne421_lock = RESERVED and ne126_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne421_lock = RESERVED and ne126_lock = RESERVED) and (ne126_state = FREE)) then
					ne421_command <= LOCK;
					ne126_command <= LOCK;
				end if;
				if (ne421_lock = LOCKED and ne126_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D19_lock = RELEASED) then
					D19_command <= RESERVE;
				end if;
				if (D19_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D19_lock = RESERVED) then
					D19_command <= LOCK;
				end if;
				if (D19_lock = LOCKED)then
					ne421_used <= '0';
					ne126_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T06_lock = RELEASED and T19_lock = RELEASED) then
					T06_command <= RESERVE;
					T19_command <= LOCK;
				end if;
				if (T06_lock = RESERVED and T19_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne421_used = '0' and ne421_state = OCCUPIED) then 
					ne421_used <= '1';
				end if;
				if (ne421_used = '1' and ne421_state = FREE) then
					ne421_used <= '0';
					ne421_command <= RELEASE;
				end if;
					---
				if (ne421_lock = RELEASED and ne126_used = '0' and ne126_state = OCCUPIED) then 
					ne126_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D19_command <= RELEASE;
				ne421_command <= RELEASE;
				ne126_command <= RELEASE;
				T06_command <= RELEASE;
				T19_command <= RELEASE;
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