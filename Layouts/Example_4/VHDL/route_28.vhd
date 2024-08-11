--  route_28.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R29 [] 
--dw  R29 [] 
--sc  R29 [] 
--lc  R29 [] 
	entity route_28 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne114 : in hex_char;
			ne114_command : out routeCommands := RELEASE;
			track_ne102 : in hex_char;
			ne102_command : out routeCommands := RELEASE;
			J48_state : in hex_char;
			J48_command : out routeCommands := RELEASE;
			T11_state : in hex_char;
			T11_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_28;
architecture Behavioral of route_28 is
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
	signal ne114_used , ne102_used : std_logic := '0';
	signal ne114_state : nodeStates := FREE;
	signal ne114_lock : objectLock := RELEASED;
	signal ne102_state : nodeStates := FREE;
	signal ne102_lock : objectLock := RELEASED;
	signal J48_aspectIn : signalStates := RED;
	signal J48_lock: objectLock := RELEASED;
	signal T11_aspectIn : signalStates := RED;
	signal T11_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne114_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne114)(2 to 3))));
	ne114_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne114)(0 to 1))));
	ne102_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne102)(2 to 3))));
	ne102_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne102)(0 to 1))));
	J48_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J48_state)(2 to 3))));
	J48_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J48_state)(0 to 1))));
	T11_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T11_state)(2 to 3))));
	T11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T11_state)(0 to 1))));
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
				if ((ne114_lock = RELEASED and ne102_lock = RELEASED) and (ne102_state = FREE)) then
					ne114_command <= RESERVE;
					ne102_command <= RESERVE;
				end if;
				if (ne114_lock = RESERVED and ne102_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne114_lock = RESERVED and ne102_lock = RESERVED) and (ne102_state = FREE)) then
					ne114_command <= LOCK;
					ne102_command <= LOCK;
				end if;
				if (ne114_lock = LOCKED and ne102_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					restart <= '1';
				routeState <= LOCKING_INFRASTRUCTURE;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					ne114_used <= '0';
					ne102_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (J48_lock = RELEASED and T11_lock = RELEASED) then
					J48_command <= RESERVE;
					T11_command <= LOCK;
				end if;
				if (J48_lock = RESERVED and T11_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne114_used = '0' and ne114_state = OCCUPIED) then 
					ne114_used <= '1';
				end if;
				if (ne114_used = '1' and ne114_state = FREE) then
					ne114_used <= '0';
					ne114_command <= RELEASE;
				end if;
					---
				if (ne114_lock = RELEASED and ne102_used = '0' and ne102_state = OCCUPIED) then 
					ne102_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne114_command <= RELEASE;
				ne102_command <= RELEASE;
				J48_command <= RELEASE;
				T11_command <= RELEASE;
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