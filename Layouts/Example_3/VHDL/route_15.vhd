--  route_15.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R16 [] 
--dw  R16 [] 
--sc  R16 [] 
--lc  R16 [] 
	entity route_15 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne93 : in hex_char;
			ne93_command : out routeCommands := RELEASE;
			track_ne96 : in hex_char;
			ne96_command : out routeCommands := RELEASE;
			L34_state : in hex_char;
			L34_command : out routeCommands := RELEASE;
			P71_state : in hex_char;
			P71_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_15;
architecture Behavioral of route_15 is
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
	signal ne93_used , ne96_used : std_logic := '0';
	signal ne93_state : nodeStates := FREE;
	signal ne93_lock : objectLock := RELEASED;
	signal ne96_state : nodeStates := FREE;
	signal ne96_lock : objectLock := RELEASED;
	signal L34_aspectIn : signalStates := RED;
	signal L34_lock: objectLock := RELEASED;
	signal P71_aspectIn : signalStates := RED;
	signal P71_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne93_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne93)(2 to 3))));
	ne93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne93)(0 to 1))));
	ne96_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne96)(2 to 3))));
	ne96_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne96)(0 to 1))));
	L34_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L34_state)(2 to 3))));
	L34_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L34_state)(0 to 1))));
	P71_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P71_state)(2 to 3))));
	P71_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P71_state)(0 to 1))));
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
				if ((ne93_lock = RELEASED and ne96_lock = RELEASED) and (ne96_state = FREE)) then
					ne93_command <= RESERVE;
					ne96_command <= RESERVE;
				end if;
				if (ne93_lock = RESERVED and ne96_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne93_lock = RESERVED and ne96_lock = RESERVED) and (ne96_state = FREE)) then
					ne93_command <= LOCK;
					ne96_command <= LOCK;
				end if;
				if (ne93_lock = LOCKED and ne96_lock = LOCKED)then
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
					ne93_used <= '0';
					ne96_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (L34_lock = RELEASED and P71_lock = RELEASED) then
					L34_command <= RESERVE;
					P71_command <= LOCK;
				end if;
				if (L34_lock = RESERVED and P71_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne93_used = '0' and ne93_state = OCCUPIED) then 
					ne93_used <= '1';
				end if;
				if (ne93_used = '1' and ne93_state = FREE) then
					ne93_used <= '0';
					ne93_command <= RELEASE;
				end if;
					---
				if (ne93_lock = RELEASED and ne96_used = '0' and ne96_state = OCCUPIED) then 
					ne96_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne93_command <= RELEASE;
				ne96_command <= RELEASE;
				L34_command <= RELEASE;
				P71_command <= RELEASE;
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