--  route_24.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R25 ['Sw31', 'Sw33'] 
--dw  R25 [] 
--sc  R25 [] 
--lc  R25 ['Lc11'] 
	entity route_24 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne53 : in hex_char;
			ne53_command : out routeCommands := RELEASE;
			track_ne49 : in hex_char;
			ne49_command : out routeCommands := RELEASE;
			Lc11_state : in hex_char;
			Lc11_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			S42_state : in hex_char;
			S42_command : out routeCommands := RELEASE;
			J12_state : in hex_char;
			J12_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_24;
architecture Behavioral of route_24 is
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
	signal ne3_used , ne53_used , ne49_used : std_logic := '0';
	signal ne3_state : nodeStates := FREE;
	signal ne3_lock : objectLock := RELEASED;
	signal ne53_state : nodeStates := FREE;
	signal ne53_lock : objectLock := RELEASED;
	signal ne49_state : nodeStates := FREE;
	signal ne49_lock : objectLock := RELEASED;
	signal Lc11_position : levelCrossingStates := UP;
	signal Lc11_lock : objectLock := RELEASED;
	signal Sw31_position : singleSwitchStates := NORMAL;
	signal Sw31_lock : objectLock := RELEASED;
	signal Sw33_position : singleSwitchStates := NORMAL;
	signal Sw33_lock : objectLock := RELEASED;
	signal S42_aspectIn : signalStates := RED;
	signal S42_lock: objectLock := RELEASED;
	signal J12_aspectIn : signalStates := RED;
	signal J12_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne3_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne3)(2 to 3))));
	ne3_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne3)(0 to 1))));
	ne53_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne53)(2 to 3))));
	ne53_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne53)(0 to 1))));
	ne49_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne49)(2 to 3))));
	ne49_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne49)(0 to 1))));
	Lc11_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc11_state)(2 to 3))));
	Lc11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc11_state)(0 to 1))));
	Sw31_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw31_state)(2 to 3))));
	Sw31_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw31_state)(0 to 1))));
	Sw33_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw33_state)(2 to 3))));
	Sw33_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw33_state)(0 to 1))));
	S42_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S42_state)(2 to 3))));
	S42_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S42_state)(0 to 1))));
	J12_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J12_state)(2 to 3))));
	J12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J12_state)(0 to 1))));
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
				if ((ne3_lock = RELEASED and ne53_lock = RELEASED and ne49_lock = RELEASED) and (ne53_state = FREE and ne49_state = FREE)) then
					ne3_command <= RESERVE;
					ne53_command <= RESERVE;
					ne49_command <= RESERVE;
				end if;
				if (ne3_lock = RESERVED and ne53_lock = RESERVED and ne49_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne3_lock = RESERVED and ne53_lock = RESERVED and ne49_lock = RESERVED) and (ne53_state = FREE and ne49_state = FREE)) then
					ne3_command <= LOCK;
					ne53_command <= LOCK;
					ne49_command <= LOCK;
				end if;
				if (ne3_lock = LOCKED and ne53_lock = LOCKED and ne49_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc11_lock = RELEASED and Sw31_lock = RELEASED and Sw33_lock = RELEASED) then
					Lc11_command <= RESERVE;
					Sw31_command <= RESERVE;
					Sw33_command <= RESERVE;
				end if;
				if (Lc11_lock = RESERVED and Sw31_lock = RESERVED and Sw33_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc11_lock = RESERVED and Sw31_lock = RESERVED and Sw33_lock = RESERVED) then
					Lc11_command <= LOCK;
					Sw31_command <= LOCK;
					Sw33_command <= LOCK;
				end if;
				if (Lc11_lock = LOCKED and Sw31_lock = LOCKED and Sw33_lock = LOCKED)then
					ne3_used <= '0';
					ne53_used <= '0';
					ne49_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S42_lock = RELEASED and J12_lock = RELEASED) then
					S42_command <= RESERVE;
					J12_command <= LOCK;
				end if;
				if (S42_lock = RESERVED and J12_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne3_used = '0' and ne3_state = OCCUPIED) then 
					ne3_used <= '1';
				end if;
				if (ne3_used = '1' and ne3_state = FREE) then
					ne3_used <= '0';
					ne3_command <= RELEASE;
				end if;
					---
				if (ne3_lock = RELEASED and ne53_used = '0' and ne53_state = OCCUPIED) then 
					ne53_used <= '1';
				end if;
				if (ne53_used = '1' and ne53_state = FREE) then
					ne53_used <= '0';
					ne53_command <= RELEASE;
				end if;
					---
				if (ne53_lock = RELEASED and ne49_used = '0' and ne49_state = OCCUPIED) then 
					ne49_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc11_command <= RELEASE;
				Sw31_command <= RELEASE;
				Sw33_command <= RELEASE;
				ne3_command <= RELEASE;
				ne53_command <= RELEASE;
				ne49_command <= RELEASE;
				S42_command <= RELEASE;
				J12_command <= RELEASE;
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