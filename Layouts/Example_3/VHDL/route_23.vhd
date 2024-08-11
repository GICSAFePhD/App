--  route_23.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R24 [] 
--dw  R24 [] 
--sc  R24 [] 
--lc  R24 [] 
	entity route_23 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne9 : in hex_char;
			ne9_command : out routeCommands := RELEASE;
			track_ne95 : in hex_char;
			ne95_command : out routeCommands := RELEASE;
			J46_state : in hex_char;
			J46_command : out routeCommands := RELEASE;
			L35_state : in hex_char;
			L35_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_23;
architecture Behavioral of route_23 is
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
	signal ne9_used , ne95_used : std_logic := '0';
	signal ne9_state : nodeStates := FREE;
	signal ne9_lock : objectLock := RELEASED;
	signal ne95_state : nodeStates := FREE;
	signal ne95_lock : objectLock := RELEASED;
	signal J46_aspectIn : signalStates := RED;
	signal J46_lock: objectLock := RELEASED;
	signal L35_aspectIn : signalStates := RED;
	signal L35_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne9_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne9)(2 to 3))));
	ne9_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne9)(0 to 1))));
	ne95_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne95)(2 to 3))));
	ne95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne95)(0 to 1))));
	J46_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J46_state)(2 to 3))));
	J46_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J46_state)(0 to 1))));
	L35_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L35_state)(2 to 3))));
	L35_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L35_state)(0 to 1))));
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
				if ((ne9_lock = RELEASED and ne95_lock = RELEASED) and (ne95_state = FREE)) then
					ne9_command <= RESERVE;
					ne95_command <= RESERVE;
				end if;
				if (ne9_lock = RESERVED and ne95_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne9_lock = RESERVED and ne95_lock = RESERVED) and (ne95_state = FREE)) then
					ne9_command <= LOCK;
					ne95_command <= LOCK;
				end if;
				if (ne9_lock = LOCKED and ne95_lock = LOCKED)then
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
					ne9_used <= '0';
					ne95_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (J46_lock = RELEASED and L35_lock = RELEASED) then
					J46_command <= RESERVE;
					L35_command <= LOCK;
				end if;
				if (J46_lock = RESERVED and L35_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne9_used = '0' and ne9_state = OCCUPIED) then 
					ne9_used <= '1';
				end if;
				if (ne9_used = '1' and ne9_state = FREE) then
					ne9_used <= '0';
					ne9_command <= RELEASE;
				end if;
					---
				if (ne9_lock = RELEASED and ne95_used = '0' and ne95_state = OCCUPIED) then 
					ne95_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne9_command <= RELEASE;
				ne95_command <= RELEASE;
				J46_command <= RELEASE;
				L35_command <= RELEASE;
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