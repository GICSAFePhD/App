--  route_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R10 ['Sw31', 'Sw33'] 
--YYY  R10 [] 
	entity route_9 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne50 : in hex_char;
			ne50_command : out routeCommands := RELEASE;
			track_ne53 : in hex_char;
			ne53_command : out routeCommands := RELEASE;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			J13_state : in hex_char;
			J13_command : out routeCommands := RELEASE;
			J17_state : in hex_char;
			J17_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_9;
architecture Behavioral of route_9 is
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
	signal ne50_used , ne53_used , ne3_used : std_logic := '0';
	signal ne50_state : nodeStates := FREE;
	signal ne50_lock : objectLock := RELEASED;
	signal ne53_state : nodeStates := FREE;
	signal ne53_lock : objectLock := RELEASED;
	signal ne3_state : nodeStates := FREE;
	signal ne3_lock : objectLock := RELEASED;
	signal Sw31_position : singleSwitchStates := NORMAL;
	signal Sw31_lock : objectLock := RELEASED;
	signal Sw33_position : singleSwitchStates := NORMAL;
	signal Sw33_lock : objectLock := RELEASED;
	signal J13_aspectIn : signalStates := RED;
	signal J13_lock: objectLock := RELEASED;
	signal J17_aspectIn : signalStates := RED;
	signal J17_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne50_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne50)(2 to 3))));
	ne50_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne50)(0 to 1))));
	ne53_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne53)(2 to 3))));
	ne53_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne53)(0 to 1))));
	ne3_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne3)(2 to 3))));
	ne3_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne3)(0 to 1))));
	Sw31_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw31_state)(2 to 3))));
	Sw31_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw31_state)(0 to 1))));
	Sw33_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw33_state)(2 to 3))));
	Sw33_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw33_state)(0 to 1))));
	J13_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J13_state)(2 to 3))));
	J13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J13_state)(0 to 1))));
	J17_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J17_state)(2 to 3))));
	J17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J17_state)(0 to 1))));
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
				if ((ne50_lock = RELEASED and ne53_lock = RELEASED and ne3_lock = RELEASED) and (ne53_state = FREE and ne3_state = FREE)) then
					ne50_command <= RESERVE;
					ne53_command <= RESERVE;
					ne3_command <= RESERVE;
				end if;
				if (ne50_lock = RESERVED and ne53_lock = RESERVED and ne3_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne50_lock = RESERVED and ne53_lock = RESERVED and ne3_lock = RESERVED) and (ne53_state = FREE and ne3_state = FREE)) then
					ne50_command <= LOCK;
					ne53_command <= LOCK;
					ne3_command <= LOCK;
				end if;
				if (ne50_lock = LOCKED and ne53_lock = LOCKED and ne3_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw31_lock = RELEASED and Sw33_lock = RELEASED) then
					Sw31_command <= RESERVE;
					Sw33_command <= RESERVE;
				end if;
				if (Sw31_lock = RESERVED and Sw33_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw31_lock = RESERVED and Sw33_lock = RESERVED) then
					Sw31_command <= LOCK;
					Sw33_command <= LOCK;
				end if;
				if (Sw31_lock = LOCKED and Sw33_lock = LOCKED)then
					ne50_used <= '0';
					ne53_used <= '0';
					ne3_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (J13_lock = RELEASED and J17_lock = RELEASED) then
					J13_command <= RESERVE;
					J17_command <= LOCK;
				end if;
				if (J13_lock = RESERVED and J17_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne50_used = '0' and ne50_state = OCCUPIED) then 
					ne50_used <= '1';
				end if;
				if (ne50_used = '1' and ne50_state = FREE) then
					ne50_used <= '0';
					ne50_command <= RELEASE;
				end if;
					---
				if (ne50_lock = RELEASED and ne53_used = '0' and ne53_state = OCCUPIED) then 
					ne53_used <= '1';
				end if;
				if (ne53_used = '1' and ne53_state = FREE) then
					ne53_used <= '0';
					ne53_command <= RELEASE;
				end if;
					---
				if (ne53_lock = RELEASED and ne3_used = '0' and ne3_state = OCCUPIED) then 
					ne3_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw31_command <= RELEASE;
				Sw33_command <= RELEASE;
				ne50_command <= RELEASE;
				ne53_command <= RELEASE;
				ne3_command <= RELEASE;
				J13_command <= RELEASE;
				J17_command <= RELEASE;
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