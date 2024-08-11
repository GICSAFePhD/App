--  route_21.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R22 [] 
--dw  R22 [] 
--sc  R22 [] 
--lc  R22 [] 
	entity route_21 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne106 : in hex_char;
			ne106_command : out routeCommands := RELEASE;
			track_ne99 : in hex_char;
			ne99_command : out routeCommands := RELEASE;
			L42_state : in hex_char;
			L42_command : out routeCommands := RELEASE;
			P68_state : in hex_char;
			P68_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_21;
architecture Behavioral of route_21 is
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
	signal ne106_used , ne99_used : std_logic := '0';
	signal ne106_state : nodeStates := FREE;
	signal ne106_lock : objectLock := RELEASED;
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal L42_aspectIn : signalStates := RED;
	signal L42_lock: objectLock := RELEASED;
	signal P68_aspectIn : signalStates := RED;
	signal P68_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne106_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne106)(2 to 3))));
	ne106_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne106)(0 to 1))));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	L42_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L42_state)(2 to 3))));
	L42_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L42_state)(0 to 1))));
	P68_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P68_state)(2 to 3))));
	P68_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P68_state)(0 to 1))));
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
				if ((ne106_lock = RELEASED and ne99_lock = RELEASED) and (ne99_state = FREE)) then
					ne106_command <= RESERVE;
					ne99_command <= RESERVE;
				end if;
				if (ne106_lock = RESERVED and ne99_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne106_lock = RESERVED and ne99_lock = RESERVED) and (ne99_state = FREE)) then
					ne106_command <= LOCK;
					ne99_command <= LOCK;
				end if;
				if (ne106_lock = LOCKED and ne99_lock = LOCKED)then
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
					ne106_used <= '0';
					ne99_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (L42_lock = RELEASED and P68_lock = RELEASED) then
					L42_command <= RESERVE;
					P68_command <= LOCK;
				end if;
				if (L42_lock = RESERVED and P68_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne106_used = '0' and ne106_state = OCCUPIED) then 
					ne106_used <= '1';
				end if;
				if (ne106_used = '1' and ne106_state = FREE) then
					ne106_used <= '0';
					ne106_command <= RELEASE;
				end if;
					---
				if (ne106_lock = RELEASED and ne99_used = '0' and ne99_state = OCCUPIED) then 
					ne99_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne106_command <= RELEASE;
				ne99_command <= RELEASE;
				L42_command <= RELEASE;
				P68_command <= RELEASE;
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