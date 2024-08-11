--  route_29.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R30 [] 
--dw  R30 [] 
--sc  R30 [] 
--lc  R30 [] 
	entity route_29 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne67 : in hex_char;
			ne67_command : out routeCommands := RELEASE;
			track_ne103 : in hex_char;
			ne103_command : out routeCommands := RELEASE;
			P65_state : in hex_char;
			P65_command : out routeCommands := RELEASE;
			L41_state : in hex_char;
			L41_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_29;
architecture Behavioral of route_29 is
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
	signal ne67_used , ne103_used : std_logic := '0';
	signal ne67_state : nodeStates := FREE;
	signal ne67_lock : objectLock := RELEASED;
	signal ne103_state : nodeStates := FREE;
	signal ne103_lock : objectLock := RELEASED;
	signal P65_aspectIn : signalStates := RED;
	signal P65_lock: objectLock := RELEASED;
	signal L41_aspectIn : signalStates := RED;
	signal L41_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne67_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne67)(2 to 3))));
	ne67_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne67)(0 to 1))));
	ne103_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne103)(2 to 3))));
	ne103_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne103)(0 to 1))));
	P65_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P65_state)(2 to 3))));
	P65_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P65_state)(0 to 1))));
	L41_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L41_state)(2 to 3))));
	L41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L41_state)(0 to 1))));
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
				if ((ne67_lock = RELEASED and ne103_lock = RELEASED) and (ne103_state = FREE)) then
					ne67_command <= RESERVE;
					ne103_command <= RESERVE;
				end if;
				if (ne67_lock = RESERVED and ne103_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne67_lock = RESERVED and ne103_lock = RESERVED) and (ne103_state = FREE)) then
					ne67_command <= LOCK;
					ne103_command <= LOCK;
				end if;
				if (ne67_lock = LOCKED and ne103_lock = LOCKED)then
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
					ne67_used <= '0';
					ne103_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (P65_lock = RELEASED and L41_lock = RELEASED) then
					P65_command <= RESERVE;
					L41_command <= LOCK;
				end if;
				if (P65_lock = RESERVED and L41_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne67_used = '0' and ne67_state = OCCUPIED) then 
					ne67_used <= '1';
				end if;
				if (ne67_used = '1' and ne67_state = FREE) then
					ne67_used <= '0';
					ne67_command <= RELEASE;
				end if;
					---
				if (ne67_lock = RELEASED and ne103_used = '0' and ne103_state = OCCUPIED) then 
					ne103_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne67_command <= RELEASE;
				ne103_command <= RELEASE;
				P65_command <= RELEASE;
				L41_command <= RELEASE;
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