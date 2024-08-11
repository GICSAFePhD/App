--  route_32.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R33 ['Sw06'] 
--dw  R33 [] 
--sc  R33 [] 
--lc  R33 [] 
	entity route_32 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne96 : in hex_char;
			ne96_command : out routeCommands := RELEASE;
			track_ne93 : in hex_char;
			ne93_command : out routeCommands := RELEASE;
			track_ne78 : in hex_char;
			ne78_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			P70_state : in hex_char;
			P70_command : out routeCommands := RELEASE;
			S110_state : in hex_char;
			S110_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_32;
architecture Behavioral of route_32 is
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
	signal ne96_used , ne93_used , ne78_used : std_logic := '0';
	signal ne96_state : nodeStates := FREE;
	signal ne96_lock : objectLock := RELEASED;
	signal ne93_state : nodeStates := FREE;
	signal ne93_lock : objectLock := RELEASED;
	signal ne78_state : nodeStates := FREE;
	signal ne78_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal P70_aspectIn : signalStates := RED;
	signal P70_lock: objectLock := RELEASED;
	signal S110_aspectIn : signalStates := RED;
	signal S110_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne96_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne96)(2 to 3))));
	ne96_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne96)(0 to 1))));
	ne93_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne93)(2 to 3))));
	ne93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne93)(0 to 1))));
	ne78_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne78)(2 to 3))));
	ne78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne78)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	P70_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P70_state)(2 to 3))));
	P70_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P70_state)(0 to 1))));
	S110_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S110_state)(2 to 3))));
	S110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S110_state)(0 to 1))));
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
				if ((ne96_lock = RELEASED and ne93_lock = RELEASED and ne78_lock = RELEASED) and (ne93_state = FREE and ne78_state = FREE)) then
					ne96_command <= RESERVE;
					ne93_command <= RESERVE;
					ne78_command <= RESERVE;
				end if;
				if (ne96_lock = RESERVED and ne93_lock = RESERVED and ne78_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne96_lock = RESERVED and ne93_lock = RESERVED and ne78_lock = RESERVED) and (ne93_state = FREE and ne78_state = FREE)) then
					ne96_command <= LOCK;
					ne93_command <= LOCK;
					ne78_command <= LOCK;
				end if;
				if (ne96_lock = LOCKED and ne93_lock = LOCKED and ne78_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw06_lock = RELEASED) then
					Sw06_command <= RESERVE;
				end if;
				if (Sw06_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw06_lock = RESERVED) then
					Sw06_command <= LOCK;
				end if;
				if (Sw06_lock = LOCKED)then
					ne96_used <= '0';
					ne93_used <= '0';
					ne78_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (P70_lock = RELEASED and S110_lock = RELEASED) then
					P70_command <= RESERVE;
					S110_command <= LOCK;
				end if;
				if (P70_lock = RESERVED and S110_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

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
				if (ne96_lock = RELEASED and ne93_used = '0' and ne93_state = OCCUPIED) then 
					ne93_used <= '1';
				end if;
				if (ne93_used = '1' and ne93_state = FREE) then
					ne93_used <= '0';
					ne93_command <= RELEASE;
				end if;
					---
				if (ne93_lock = RELEASED and ne78_used = '0' and ne78_state = OCCUPIED) then 
					ne78_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				Sw06_command <= RELEASE;
				ne96_command <= RELEASE;
				ne93_command <= RELEASE;
				ne78_command <= RELEASE;
				P70_command <= RELEASE;
				S110_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;