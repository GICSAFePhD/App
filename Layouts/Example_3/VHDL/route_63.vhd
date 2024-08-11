--  route_63.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R64 ['69W03', 'Sw06'] 
--dw  R64 [] 
--sc  R64 [] 
--lc  R64 [] 
	entity route_63 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne78 : in hex_char;
			ne78_command : out routeCommands := RELEASE;
			track_ne17 : in hex_char;
			ne17_command : out routeCommands := RELEASE;
			s69W03_state : in hex_char;
			s69W03_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			S110_state : in hex_char;
			S110_command : out routeCommands := RELEASE;
			C82_state : in hex_char;
			C82_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_63;
architecture Behavioral of route_63 is
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
	signal ne78_used , ne17_used : std_logic := '0';
	signal ne78_state : nodeStates := FREE;
	signal ne78_lock : objectLock := RELEASED;
	signal ne17_state : nodeStates := FREE;
	signal ne17_lock : objectLock := RELEASED;
	signal s69W03_position : singleSwitchStates := NORMAL;
	signal s69W03_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal S110_aspectIn : signalStates := RED;
	signal S110_lock: objectLock := RELEASED;
	signal C82_aspectIn : signalStates := RED;
	signal C82_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne78_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne78)(2 to 3))));
	ne78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne78)(0 to 1))));
	ne17_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne17)(2 to 3))));
	ne17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne17)(0 to 1))));
	s69W03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s69W03_state)(2 to 3))));
	s69W03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s69W03_state)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	S110_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S110_state)(2 to 3))));
	S110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S110_state)(0 to 1))));
	C82_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C82_state)(2 to 3))));
	C82_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C82_state)(0 to 1))));
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
				if ((ne78_lock = RELEASED and ne17_lock = RELEASED) and (ne17_state = FREE)) then
					ne78_command <= RESERVE;
					ne17_command <= RESERVE;
				end if;
				if (ne78_lock = RESERVED and ne17_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne78_lock = RESERVED and ne17_lock = RESERVED) and (ne17_state = FREE)) then
					ne78_command <= LOCK;
					ne17_command <= LOCK;
				end if;
				if (ne78_lock = LOCKED and ne17_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s69W03_lock = RELEASED and Sw06_lock = RELEASED) then
					s69W03_command <= RESERVE;
					Sw06_command <= RESERVE;
				end if;
				if (s69W03_lock = RESERVED and Sw06_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (s69W03_lock = RESERVED and Sw06_lock = RESERVED) then
					s69W03_command <= LOCK;
					Sw06_command <= LOCK;
				end if;
				if (s69W03_lock = LOCKED and Sw06_lock = LOCKED)then
					ne78_used <= '0';
					ne17_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S110_lock = RELEASED and C82_lock = RELEASED) then
					S110_command <= RESERVE;
					C82_command <= LOCK;
				end if;
				if (S110_lock = RESERVED and C82_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne78_used = '0' and ne78_state = OCCUPIED) then 
					ne78_used <= '1';
				end if;
				if (ne78_used = '1' and ne78_state = FREE) then
					ne78_used <= '0';
					ne78_command <= RELEASE;
				end if;
					---
				if (ne78_lock = RELEASED and ne17_used = '0' and ne17_state = OCCUPIED) then 
					ne17_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				s69W03_command <= RELEASE;
				Sw06_command <= RELEASE;
				ne78_command <= RELEASE;
				ne17_command <= RELEASE;
				S110_command <= RELEASE;
				C82_command <= RELEASE;
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