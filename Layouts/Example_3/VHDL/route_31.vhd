--  route_31.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R32 [] 
--dw  R32 [] 
--sc  R32 [] 
--lc  R32 [] 
	entity route_31 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne99 : in hex_char;
			ne99_command : out routeCommands := RELEASE;
			track_ne106 : in hex_char;
			ne106_command : out routeCommands := RELEASE;
			track_ne4 : in hex_char;
			ne4_command : out routeCommands := RELEASE;
			P69_state : in hex_char;
			P69_command : out routeCommands := RELEASE;
			T03_state : in hex_char;
			T03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_31;
architecture Behavioral of route_31 is
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
	signal ne99_used , ne106_used , ne4_used : std_logic := '0';
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal ne106_state : nodeStates := FREE;
	signal ne106_lock : objectLock := RELEASED;
	signal ne4_state : nodeStates := FREE;
	signal ne4_lock : objectLock := RELEASED;
	signal P69_aspectIn : signalStates := RED;
	signal P69_lock: objectLock := RELEASED;
	signal T03_aspectIn : signalStates := RED;
	signal T03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	ne106_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne106)(2 to 3))));
	ne106_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne106)(0 to 1))));
	ne4_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne4)(2 to 3))));
	ne4_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne4)(0 to 1))));
	P69_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P69_state)(2 to 3))));
	P69_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P69_state)(0 to 1))));
	T03_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T03_state)(2 to 3))));
	T03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T03_state)(0 to 1))));
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
				if ((ne99_lock = RELEASED and ne106_lock = RELEASED and ne4_lock = RELEASED) and (ne106_state = FREE and ne4_state = FREE)) then
					ne99_command <= RESERVE;
					ne106_command <= RESERVE;
					ne4_command <= RESERVE;
				end if;
				if (ne99_lock = RESERVED and ne106_lock = RESERVED and ne4_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne99_lock = RESERVED and ne106_lock = RESERVED and ne4_lock = RESERVED) and (ne106_state = FREE and ne4_state = FREE)) then
					ne99_command <= LOCK;
					ne106_command <= LOCK;
					ne4_command <= LOCK;
				end if;
				if (ne99_lock = LOCKED and ne106_lock = LOCKED and ne4_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					restart <= '1';
				routeState <= LOCKING_INFRASTRUCTURE;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					ne99_used <= '0';
					ne106_used <= '0';
					ne4_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (P69_lock = RELEASED and T03_lock = RELEASED) then
					P69_command <= RESERVE;
					T03_command <= LOCK;
				end if;
				if (P69_lock = RESERVED and T03_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne99_used = '0' and ne99_state = OCCUPIED) then 
					ne99_used <= '1';
				end if;
				if (ne99_used = '1' and ne99_state = FREE) then
					ne99_used <= '0';
					ne99_command <= RELEASE;
				end if;
					---
				if (ne99_lock = RELEASED and ne106_used = '0' and ne106_state = OCCUPIED) then 
					ne106_used <= '1';
				end if;
				if (ne106_used = '1' and ne106_state = FREE) then
					ne106_used <= '0';
					ne106_command <= RELEASE;
				end if;
					---
				if (ne106_lock = RELEASED and ne4_used = '0' and ne4_state = OCCUPIED) then 
					ne4_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				ne99_command <= RELEASE;
				ne106_command <= RELEASE;
				ne4_command <= RELEASE;
				P69_command <= RELEASE;
				T03_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;