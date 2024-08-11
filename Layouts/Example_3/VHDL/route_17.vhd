--  route_17.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R18 [] 
--dw  R18 [] 
--sc  R18 [] 
--lc  R18 [] 
	entity route_17 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne97 : in hex_char;
			ne97_command : out routeCommands := RELEASE;
			track_ne94 : in hex_char;
			ne94_command : out routeCommands := RELEASE;
			L37_state : in hex_char;
			L37_command : out routeCommands := RELEASE;
			S135_state : in hex_char;
			S135_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_17;
architecture Behavioral of route_17 is
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
	signal ne97_used , ne94_used : std_logic := '0';
	signal ne97_state : nodeStates := FREE;
	signal ne97_lock : objectLock := RELEASED;
	signal ne94_state : nodeStates := FREE;
	signal ne94_lock : objectLock := RELEASED;
	signal L37_aspectIn : signalStates := RED;
	signal L37_lock: objectLock := RELEASED;
	signal S135_aspectIn : signalStates := RED;
	signal S135_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne97_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne97)(2 to 3))));
	ne97_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne97)(0 to 1))));
	ne94_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne94)(2 to 3))));
	ne94_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne94)(0 to 1))));
	L37_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L37_state)(2 to 3))));
	L37_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L37_state)(0 to 1))));
	S135_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S135_state)(2 to 3))));
	S135_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S135_state)(0 to 1))));
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
				if ((ne97_lock = RELEASED and ne94_lock = RELEASED) and (ne94_state = FREE)) then
					ne97_command <= RESERVE;
					ne94_command <= RESERVE;
				end if;
				if (ne97_lock = RESERVED and ne94_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne97_lock = RESERVED and ne94_lock = RESERVED) and (ne94_state = FREE)) then
					ne97_command <= LOCK;
					ne94_command <= LOCK;
				end if;
				if (ne97_lock = LOCKED and ne94_lock = LOCKED)then
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
					ne97_used <= '0';
					ne94_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (L37_lock = RELEASED and S135_lock = RELEASED) then
					L37_command <= RESERVE;
					S135_command <= LOCK;
				end if;
				if (L37_lock = RESERVED and S135_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne97_used = '0' and ne97_state = OCCUPIED) then 
					ne97_used <= '1';
				end if;
				if (ne97_used = '1' and ne97_state = FREE) then
					ne97_used <= '0';
					ne97_command <= RELEASE;
				end if;
					---
				if (ne97_lock = RELEASED and ne94_used = '0' and ne94_state = OCCUPIED) then 
					ne94_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne97_command <= RELEASE;
				ne94_command <= RELEASE;
				L37_command <= RELEASE;
				S135_command <= RELEASE;
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