--  route_36.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R37 [] 
--dw  R37 ['Sw07'] 
--sc  R37 [] 
--lc  R37 [] 
	entity route_36 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne21 : in hex_char;
			ne21_command : out routeCommands := RELEASE;
			track_ne94 : in hex_char;
			ne94_command : out routeCommands := RELEASE;
			track_ne97 : in hex_char;
			ne97_command : out routeCommands := RELEASE;
			track_ne99 : in hex_char;
			ne99_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			P73_state : in hex_char;
			P73_command : out routeCommands := RELEASE;
			P69_state : in hex_char;
			P69_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_36;
architecture Behavioral of route_36 is
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
	signal ne21_used , ne94_used , ne97_used , ne99_used : std_logic := '0';
	signal ne21_state : nodeStates := FREE;
	signal ne21_lock : objectLock := RELEASED;
	signal ne94_state : nodeStates := FREE;
	signal ne94_lock : objectLock := RELEASED;
	signal ne97_state : nodeStates := FREE;
	signal ne97_lock : objectLock := RELEASED;
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal Sw07_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw07_lock : objectLock := RELEASED;
	signal P73_aspectIn : signalStates := RED;
	signal P73_lock: objectLock := RELEASED;
	signal P69_aspectIn : signalStates := RED;
	signal P69_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne21_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne21)(2 to 3))));
	ne21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne21)(0 to 1))));
	ne94_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne94)(2 to 3))));
	ne94_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne94)(0 to 1))));
	ne97_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne97)(2 to 3))));
	ne97_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne97)(0 to 1))));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	Sw07_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw07_state)(2 to 3))));
	Sw07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw07_state)(0 to 1))));
	P73_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P73_state)(2 to 3))));
	P73_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P73_state)(0 to 1))));
	P69_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P69_state)(2 to 3))));
	P69_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P69_state)(0 to 1))));
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
				if ((ne21_lock = RELEASED and ne94_lock = RELEASED and ne97_lock = RELEASED and ne99_lock = RELEASED) and (ne94_state = FREE and ne97_state = FREE and ne99_state = FREE)) then
					ne21_command <= RESERVE;
					ne94_command <= RESERVE;
					ne97_command <= RESERVE;
					ne99_command <= RESERVE;
				end if;
				if (ne21_lock = RESERVED and ne94_lock = RESERVED and ne97_lock = RESERVED and ne99_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne21_lock = RESERVED and ne94_lock = RESERVED and ne97_lock = RESERVED and ne99_lock = RESERVED) and (ne94_state = FREE and ne97_state = FREE and ne99_state = FREE)) then
					ne21_command <= LOCK;
					ne94_command <= LOCK;
					ne97_command <= LOCK;
					ne99_command <= LOCK;
				end if;
				if (ne21_lock = LOCKED and ne94_lock = LOCKED and ne97_lock = LOCKED and ne99_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw07_lock = RELEASED) then
					Sw07_command <= RESERVE;
				end if;
				if (Sw07_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw07_lock = RESERVED) then
					Sw07_command <= LOCK;
				end if;
				if (Sw07_lock = LOCKED)then
					ne21_used <= '0';
					ne94_used <= '0';
					ne97_used <= '0';
					ne99_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (P73_lock = RELEASED and P69_lock = RELEASED) then
					P73_command <= RESERVE;
					P69_command <= LOCK;
				end if;
				if (P73_lock = RESERVED and P69_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne21_used = '0' and ne21_state = OCCUPIED) then 
					ne21_used <= '1';
				end if;
				if (ne21_used = '1' and ne21_state = FREE) then
					ne21_used <= '0';
					ne21_command <= RELEASE;
				end if;
					---
				if (ne21_lock = RELEASED and ne94_used = '0' and ne94_state = OCCUPIED) then 
					ne94_used <= '1';
				end if;
				if (ne94_used = '1' and ne94_state = FREE) then
					ne94_used <= '0';
					ne94_command <= RELEASE;
				end if;
					---
				if (ne94_lock = RELEASED and ne97_used = '0' and ne97_state = OCCUPIED) then 
					ne97_used <= '1';
				end if;
				if (ne97_used = '1' and ne97_state = FREE) then
					ne97_used <= '0';
					ne97_command <= RELEASE;
				end if;
					---
				if (ne97_lock = RELEASED and ne99_used = '0' and ne99_state = OCCUPIED) then 
					ne99_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw07_command <= RELEASE;
				ne21_command <= RELEASE;
				ne94_command <= RELEASE;
				ne97_command <= RELEASE;
				ne99_command <= RELEASE;
				P73_command <= RELEASE;
				P69_command <= RELEASE;
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