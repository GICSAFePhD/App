--  route_33.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R34 [] 
--dw  R34 [] 
--sc  R34 [] 
--lc  R34 [] 
	entity route_33 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne96 : in hex_char;
			ne96_command : out routeCommands := RELEASE;
			track_ne98 : in hex_char;
			ne98_command : out routeCommands := RELEASE;
			P71_state : in hex_char;
			P71_command : out routeCommands := RELEASE;
			L38_state : in hex_char;
			L38_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_33;
architecture Behavioral of route_33 is
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
	signal ne96_used , ne98_used : std_logic := '0';
	signal ne96_state : nodeStates := FREE;
	signal ne96_lock : objectLock := RELEASED;
	signal ne98_state : nodeStates := FREE;
	signal ne98_lock : objectLock := RELEASED;
	signal P71_aspectIn : signalStates := RED;
	signal P71_lock: objectLock := RELEASED;
	signal L38_aspectIn : signalStates := RED;
	signal L38_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne96_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne96)(2 to 3))));
	ne96_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne96)(0 to 1))));
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne98_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne98)(0 to 1))));
	P71_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P71_state)(2 to 3))));
	P71_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P71_state)(0 to 1))));
	L38_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L38_state)(2 to 3))));
	L38_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L38_state)(0 to 1))));
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
				if ((ne96_lock = RELEASED and ne98_lock = RELEASED) and (ne98_state = FREE)) then
					ne96_command <= RESERVE;
					ne98_command <= RESERVE;
				end if;
				if (ne96_lock = RESERVED and ne98_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne96_lock = RESERVED and ne98_lock = RESERVED) and (ne98_state = FREE)) then
					ne96_command <= LOCK;
					ne98_command <= LOCK;
				end if;
				if (ne96_lock = LOCKED and ne98_lock = LOCKED)then
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
					ne96_used <= '0';
					ne98_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (P71_lock = RELEASED and L38_lock = RELEASED) then
					P71_command <= RESERVE;
					L38_command <= LOCK;
				end if;
				if (P71_lock = RESERVED and L38_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne96_used = '0' and ne96_state = OCCUPIED) then 
					ne96_used <= '1';
				end if;
				if (ne96_used = '1' and ne96_state = FREE) then
					ne96_used <= '0';
					ne96_command <= RELEASE;
				end if;
					---
				if (ne96_lock = RELEASED and ne98_used = '0' and ne98_state = OCCUPIED) then 
					ne98_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne96_command <= RELEASE;
				ne98_command <= RELEASE;
				P71_command <= RELEASE;
				L38_command <= RELEASE;
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