--  route_17.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R18 ['Sw05'] 
--dw  R18 [] 
--sc  R18 [] 
--lc  R18 [] 
	entity route_17 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne5 : in hex_char;
			ne5_command : out routeCommands := RELEASE;
			track_ne10 : in hex_char;
			ne10_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			S33_state : in hex_char;
			S33_command : out routeCommands := RELEASE;
			T05_state : in hex_char;
			T05_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_17;
architecture Behavioral of route_17 is
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
	signal ne5_used , ne10_used : std_logic := '0';
	signal ne5_state : nodeStates := FREE;
	signal ne5_lock : objectLock := RELEASED;
	signal ne10_state : nodeStates := FREE;
	signal ne10_lock : objectLock := RELEASED;
	signal Sw05_position : singleSwitchStates := NORMAL;
	signal Sw05_lock : objectLock := RELEASED;
	signal S33_aspectIn : signalStates := RED;
	signal S33_lock: objectLock := RELEASED;
	signal T05_aspectIn : signalStates := RED;
	signal T05_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne5_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne5)(2 to 3))));
	ne5_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne5)(0 to 1))));
	ne10_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne10)(2 to 3))));
	ne10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne10)(0 to 1))));
	Sw05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	S33_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S33_state)(2 to 3))));
	S33_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S33_state)(0 to 1))));
	T05_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T05_state)(2 to 3))));
	T05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T05_state)(0 to 1))));
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
				if ((ne5_lock = RELEASED and ne10_lock = RELEASED) and (ne10_state = FREE)) then
					ne5_command <= RESERVE;
					ne10_command <= RESERVE;
				end if;
				if (ne5_lock = RESERVED and ne10_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne5_lock = RESERVED and ne10_lock = RESERVED) and (ne10_state = FREE)) then
					ne5_command <= LOCK;
					ne10_command <= LOCK;
				end if;
				if (ne5_lock = LOCKED and ne10_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw05_lock = RELEASED) then
					Sw05_command <= RESERVE;
				end if;
				if (Sw05_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw05_lock = RESERVED) then
					Sw05_command <= LOCK;
				end if;
				if (Sw05_lock = LOCKED)then
					ne5_used <= '0';
					ne10_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S33_lock = RELEASED and T05_lock = RELEASED) then
					S33_command <= RESERVE;
					T05_command <= LOCK;
				end if;
				if (S33_lock = RESERVED and T05_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne5_used = '0' and ne5_state = OCCUPIED) then 
					ne5_used <= '1';
				end if;
				if (ne5_used = '1' and ne5_state = FREE) then
					ne5_used <= '0';
					ne5_command <= RELEASE;
				end if;
					---
				if (ne5_lock = RELEASED and ne10_used = '0' and ne10_state = OCCUPIED) then 
					ne10_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw05_command <= RELEASE;
				ne5_command <= RELEASE;
				ne10_command <= RELEASE;
				S33_command <= RELEASE;
				T05_command <= RELEASE;
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