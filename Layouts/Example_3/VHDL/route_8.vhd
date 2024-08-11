--  route_8.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R9 [] 
--dw  R9 [] 
--sc  R9 [] 
--lc  R9 [] 
	entity route_8 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne105 : in hex_char;
			ne105_command : out routeCommands := RELEASE;
			track_ne98 : in hex_char;
			ne98_command : out routeCommands := RELEASE;
			track_ne96 : in hex_char;
			ne96_command : out routeCommands := RELEASE;
			T24_state : in hex_char;
			T24_command : out routeCommands := RELEASE;
			P70_state : in hex_char;
			P70_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_8;
architecture Behavioral of route_8 is
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
	signal ne105_used , ne98_used , ne96_used : std_logic := '0';
	signal ne105_state : nodeStates := FREE;
	signal ne105_lock : objectLock := RELEASED;
	signal ne98_state : nodeStates := FREE;
	signal ne98_lock : objectLock := RELEASED;
	signal ne96_state : nodeStates := FREE;
	signal ne96_lock : objectLock := RELEASED;
	signal T24_aspectIn : signalStates := RED;
	signal T24_lock: objectLock := RELEASED;
	signal P70_aspectIn : signalStates := RED;
	signal P70_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne105_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne105)(2 to 3))));
	ne105_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne105)(0 to 1))));
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne98_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne98)(0 to 1))));
	ne96_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne96)(2 to 3))));
	ne96_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne96)(0 to 1))));
	T24_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T24_state)(2 to 3))));
	T24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T24_state)(0 to 1))));
	P70_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P70_state)(2 to 3))));
	P70_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P70_state)(0 to 1))));
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
				if ((ne105_lock = RELEASED and ne98_lock = RELEASED and ne96_lock = RELEASED) and (ne98_state = FREE and ne96_state = FREE)) then
					ne105_command <= RESERVE;
					ne98_command <= RESERVE;
					ne96_command <= RESERVE;
				end if;
				if (ne105_lock = RESERVED and ne98_lock = RESERVED and ne96_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne105_lock = RESERVED and ne98_lock = RESERVED and ne96_lock = RESERVED) and (ne98_state = FREE and ne96_state = FREE)) then
					ne105_command <= LOCK;
					ne98_command <= LOCK;
					ne96_command <= LOCK;
				end if;
				if (ne105_lock = LOCKED and ne98_lock = LOCKED and ne96_lock = LOCKED)then
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
					ne105_used <= '0';
					ne98_used <= '0';
					ne96_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T24_lock = RELEASED and P70_lock = RELEASED) then
					T24_command <= RESERVE;
					P70_command <= LOCK;
				end if;
				if (T24_lock = RESERVED and P70_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne105_used = '0' and ne105_state = OCCUPIED) then 
					ne105_used <= '1';
				end if;
				if (ne105_used = '1' and ne105_state = FREE) then
					ne105_used <= '0';
					ne105_command <= RELEASE;
				end if;
					---
				if (ne105_lock = RELEASED and ne98_used = '0' and ne98_state = OCCUPIED) then 
					ne98_used <= '1';
				end if;
				if (ne98_used = '1' and ne98_state = FREE) then
					ne98_used <= '0';
					ne98_command <= RELEASE;
				end if;
					---
				if (ne98_lock = RELEASED and ne96_used = '0' and ne96_state = OCCUPIED) then 
					ne96_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne105_command <= RELEASE;
				ne98_command <= RELEASE;
				ne96_command <= RELEASE;
				T24_command <= RELEASE;
				P70_command <= RELEASE;
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