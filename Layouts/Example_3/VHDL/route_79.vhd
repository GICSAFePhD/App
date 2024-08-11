--  route_79.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R80 [] 
--dw  R80 ['Sw05'] 
--sc  R80 [] 
--lc  R80 [] 
	entity route_79 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne85 : in hex_char;
			ne85_command : out routeCommands := RELEASE;
			track_ne84 : in hex_char;
			ne84_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			S131_state : in hex_char;
			S131_command : out routeCommands := RELEASE;
			T13_state : in hex_char;
			T13_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_79;
architecture Behavioral of route_79 is
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
	signal ne85_used , ne84_used : std_logic := '0';
	signal ne85_state : nodeStates := FREE;
	signal ne85_lock : objectLock := RELEASED;
	signal ne84_state : nodeStates := FREE;
	signal ne84_lock : objectLock := RELEASED;
	signal Sw05_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw05_lock : objectLock := RELEASED;
	signal S131_aspectIn : signalStates := RED;
	signal S131_lock: objectLock := RELEASED;
	signal T13_aspectIn : signalStates := RED;
	signal T13_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne85_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne85)(2 to 3))));
	ne85_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne85)(0 to 1))));
	ne84_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne84)(2 to 3))));
	ne84_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne84)(0 to 1))));
	Sw05_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	S131_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S131_state)(2 to 3))));
	S131_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S131_state)(0 to 1))));
	T13_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T13_state)(2 to 3))));
	T13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T13_state)(0 to 1))));
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
				if ((ne85_lock = RELEASED and ne84_lock = RELEASED) and (ne84_state = FREE)) then
					ne85_command <= RESERVE;
					ne84_command <= RESERVE;
				end if;
				if (ne85_lock = RESERVED and ne84_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne85_lock = RESERVED and ne84_lock = RESERVED) and (ne84_state = FREE)) then
					ne85_command <= LOCK;
					ne84_command <= LOCK;
				end if;
				if (ne85_lock = LOCKED and ne84_lock = LOCKED)then
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
					ne85_used <= '0';
					ne84_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S131_lock = RELEASED and T13_lock = RELEASED) then
					S131_command <= RESERVE;
					T13_command <= LOCK;
				end if;
				if (S131_lock = RESERVED and T13_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne85_used = '0' and ne85_state = OCCUPIED) then 
					ne85_used <= '1';
				end if;
				if (ne85_used = '1' and ne85_state = FREE) then
					ne85_used <= '0';
					ne85_command <= RELEASE;
				end if;
					---
				if (ne85_lock = RELEASED and ne84_used = '0' and ne84_state = OCCUPIED) then 
					ne84_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw05_command <= RELEASE;
				ne85_command <= RELEASE;
				ne84_command <= RELEASE;
				S131_command <= RELEASE;
				T13_command <= RELEASE;
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