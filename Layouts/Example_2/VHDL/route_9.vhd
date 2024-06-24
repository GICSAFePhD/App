--  route_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R10 ['Sw03'] 
--YYY  R10 [] 
	entity route_9 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne20 : in hex_char;
			ne20_command : out routeCommands := RELEASE;
			track_ne19 : in hex_char;
			ne19_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			S21_state : in hex_char;
			S21_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
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
	signal ne20_used , ne19_used : std_logic := '0';
	signal ne20_state : nodeStates := FREE;
	signal ne20_lock : objectLock := RELEASED;
	signal ne19_state : nodeStates := FREE;
	signal ne19_lock : objectLock := RELEASED;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal S21_aspectIn : signalStates := RED;
	signal S21_lock: objectLock := RELEASED;
	signal T01_aspectIn : signalStates := RED;
	signal T01_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne20_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne20)(2 to 3))));
	ne20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne20)(0 to 1))));
	ne19_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne19)(2 to 3))));
	ne19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne19)(0 to 1))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	S21_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S21_state)(2 to 3))));
	S21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S21_state)(0 to 1))));
	T01_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T01_state)(2 to 3))));
	T01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T01_state)(0 to 1))));
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
				if ((ne20_lock = RELEASED and ne19_lock = RELEASED) and (ne19_state = FREE)) then
					ne20_command <= RESERVE;
					ne19_command <= RESERVE;
				end if;
				if (ne20_lock = RESERVED and ne19_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne20_lock = RESERVED and ne19_lock = RESERVED) and (ne19_state = FREE)) then
					ne20_command <= LOCK;
					ne19_command <= LOCK;
				end if;
				if (ne20_lock = LOCKED and ne19_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw03_lock = RELEASED) then
					Sw03_command <= RESERVE;
				end if;
				if (Sw03_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw03_lock = RESERVED) then
					Sw03_command <= LOCK;
				end if;
				if (Sw03_lock = LOCKED)then
					ne20_used <= '0';
					ne19_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S21_lock = RELEASED and T01_lock = RELEASED) then
					S21_command <= RESERVE;
					T01_command <= LOCK;
				end if;
				if (S21_lock = RESERVED and T01_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne20_used = '0' and ne20_state = OCCUPIED) then 
					ne20_used <= '1';
				end if;
				if (ne20_used = '1' and ne20_state = FREE) then
					ne20_used <= '0';
					ne20_command <= RELEASE;
				end if;
					---
				if (ne20_lock = RELEASED and ne19_used = '0' and ne19_state = OCCUPIED) then 
					ne19_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw03_command <= RELEASE;
				ne20_command <= RELEASE;
				ne19_command <= RELEASE;
				S21_command <= RELEASE;
				T01_command <= RELEASE;
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