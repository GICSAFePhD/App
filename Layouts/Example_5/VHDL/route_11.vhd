--  route_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R12 ['Sw02'] 
--dw  R12 [] 
--sc  R12 [] 
--lc  R12 [] 
	entity route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne03 : in hex_char;
			ne03_command : out routeCommands := RELEASE;
			track_ne04 : in hex_char;
			ne04_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			B26_state : in hex_char;
			B26_command : out routeCommands := RELEASE;
			T03_state : in hex_char;
			T03_command : out routeCommands := RELEASE;
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
	signal ne03_used , ne04_used : std_logic := '0';
	signal ne03_state : nodeStates := FREE;
	signal ne03_lock : objectLock := RELEASED;
	signal ne04_state : nodeStates := FREE;
	signal ne04_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	signal B26_aspectIn : signalStates := RED;
	signal B26_lock: objectLock := RELEASED;
	signal T03_aspectIn : signalStates := RED;
	signal T03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne03_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne03)(2 to 3))));
	ne03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne03)(0 to 1))));
	ne04_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne04)(2 to 3))));
	ne04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne04)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	B26_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B26_state)(2 to 3))));
	B26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B26_state)(0 to 1))));
	T03_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T03_state)(2 to 3))));
	T03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T03_state)(0 to 1))));
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
				if ((ne03_lock = RELEASED and ne04_lock = RELEASED) and (ne04_state = FREE)) then
					ne03_command <= RESERVE;
					ne04_command <= RESERVE;
				end if;
				if (ne03_lock = RESERVED and ne04_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne03_lock = RESERVED and ne04_lock = RESERVED) and (ne04_state = FREE)) then
					ne03_command <= LOCK;
					ne04_command <= LOCK;
				end if;
				if (ne03_lock = LOCKED and ne04_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw02_lock = RELEASED) then
					Sw02_command <= RESERVE;
				end if;
				if (Sw02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw02_lock = RESERVED) then
					Sw02_command <= LOCK;
				end if;
				if (Sw02_lock = LOCKED)then
					ne03_used <= '0';
					ne04_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (B26_lock = RELEASED and T03_lock = RELEASED) then
					B26_command <= RESERVE;
					T03_command <= LOCK;
				end if;
				if (B26_lock = RESERVED and T03_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne03_used = '0' and ne03_state = OCCUPIED) then 
					ne03_used <= '1';
				end if;
				if (ne03_used = '1' and ne03_state = FREE) then
					ne03_used <= '0';
					ne03_command <= RELEASE;
				end if;
					---
				if (ne03_lock = RELEASED and ne04_used = '0' and ne04_state = OCCUPIED) then 
					ne04_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw02_command <= RELEASE;
				ne03_command <= RELEASE;
				ne04_command <= RELEASE;
				B26_command <= RELEASE;
				T03_command <= RELEASE;
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