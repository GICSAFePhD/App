--  route_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R12 ['Sw01', 'Sw03', 'Sw08'] 
--dw  R12 [] 
--sc  R12 [] 
--lc  R12 [] 
	entity route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne2 : in hex_char;
			ne2_command : out routeCommands := RELEASE;
			track_ne7 : in hex_char;
			ne7_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			S22_state : in hex_char;
			S22_command : out routeCommands := RELEASE;
			J19_state : in hex_char;
			J19_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_11;
architecture Behavioral of route_11 is
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
	signal ne1_used , ne2_used , ne7_used : std_logic := '0';
	signal ne1_state : nodeStates := FREE;
	signal ne1_lock : objectLock := RELEASED;
	signal ne2_state : nodeStates := FREE;
	signal ne2_lock : objectLock := RELEASED;
	signal ne7_state : nodeStates := FREE;
	signal ne7_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
	signal S22_aspectIn : signalStates := RED;
	signal S22_lock: objectLock := RELEASED;
	signal J19_aspectIn : signalStates := RED;
	signal J19_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne1_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne1)(2 to 3))));
	ne1_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne1)(0 to 1))));
	ne2_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne2)(2 to 3))));
	ne2_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne2)(0 to 1))));
	ne7_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne7)(2 to 3))));
	ne7_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne7)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	S22_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S22_state)(2 to 3))));
	S22_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S22_state)(0 to 1))));
	J19_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J19_state)(2 to 3))));
	J19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J19_state)(0 to 1))));
	gen : for i in 0 to 31 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "011011111100001000111010101111110") then
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
				if ((ne1_lock = RELEASED and ne2_lock = RELEASED and ne7_lock = RELEASED) and (ne2_state = FREE and ne7_state = FREE)) then
					ne1_command <= RESERVE;
					ne2_command <= RESERVE;
					ne7_command <= RESERVE;
				end if;
				if (ne1_lock = RESERVED and ne2_lock = RESERVED and ne7_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne1_lock = RESERVED and ne2_lock = RESERVED and ne7_lock = RESERVED) and (ne2_state = FREE and ne7_state = FREE)) then
					ne1_command <= LOCK;
					ne2_command <= LOCK;
					ne7_command <= LOCK;
				end if;
				if (ne1_lock = LOCKED and ne2_lock = LOCKED and ne7_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw01_lock = RELEASED and Sw03_lock = RELEASED and Sw08_lock = RELEASED) then
					Sw01_command <= RESERVE;
					Sw03_command <= RESERVE;
					Sw08_command <= RESERVE;
				end if;
				if (Sw01_lock = RESERVED and Sw03_lock = RESERVED and Sw08_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw01_lock = RESERVED and Sw03_lock = RESERVED and Sw08_lock = RESERVED) then
					Sw01_command <= LOCK;
					Sw03_command <= LOCK;
					Sw08_command <= LOCK;
				end if;
				if (Sw01_lock = LOCKED and Sw03_lock = LOCKED and Sw08_lock = LOCKED)then
					ne1_used <= '0';
					ne2_used <= '0';
					ne7_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S22_lock = RELEASED and J19_lock = RELEASED) then
					S22_command <= RESERVE;
					J19_command <= LOCK;
				end if;
				if (S22_lock = RESERVED and J19_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne1_used = '0' and ne1_state = OCCUPIED) then 
					ne1_used <= '1';
				end if;
				if (ne1_used = '1' and ne1_state = FREE) then
					ne1_used <= '0';
					ne1_command <= RELEASE;
				end if;
					---
				if (ne1_lock = RELEASED and ne2_used = '0' and ne2_state = OCCUPIED) then 
					ne2_used <= '1';
				end if;
				if (ne2_used = '1' and ne2_state = FREE) then
					ne2_used <= '0';
					ne2_command <= RELEASE;
				end if;
					---
				if (ne2_lock = RELEASED and ne7_used = '0' and ne7_state = OCCUPIED) then 
					ne7_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw01_command <= RELEASE;
				Sw03_command <= RELEASE;
				Sw08_command <= RELEASE;
				ne1_command <= RELEASE;
				ne2_command <= RELEASE;
				ne7_command <= RELEASE;
				S22_command <= RELEASE;
				J19_command <= RELEASE;
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