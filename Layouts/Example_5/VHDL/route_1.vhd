--  route_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R2 ['Sw01', 'Sw02'] 
--YYY  R2 [] 
	entity route_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne01 : in hex_char;
			ne01_command : out routeCommands := RELEASE;
			track_ne03 : in hex_char;
			ne03_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			B26_state : in hex_char;
			B26_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_1;
architecture Behavioral of route_1 is
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
	signal ne01_used , ne03_used : std_logic := '0';
	signal ne01_state : nodeStates := FREE;
	signal ne01_lock : objectLock := RELEASED;
	signal ne03_state : nodeStates := FREE;
	signal ne03_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	signal T02_aspectIn : signalStates := RED;
	signal T02_lock: objectLock := RELEASED;
	signal B26_aspectIn : signalStates := RED;
	signal B26_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne01_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne01)(2 to 3))));
	ne01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne01)(0 to 1))));
	ne03_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne03)(2 to 3))));
	ne03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne03)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	T02_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T02_state)(2 to 3))));
	T02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T02_state)(0 to 1))));
	B26_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B26_state)(2 to 3))));
	B26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B26_state)(0 to 1))));
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
				if ((ne01_lock = RELEASED and ne03_lock = RELEASED) and (ne03_state = FREE)) then
					ne01_command <= RESERVE;
					ne03_command <= RESERVE;
				end if;
				if (ne01_lock = RESERVED and ne03_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne01_lock = RESERVED and ne03_lock = RESERVED) and (ne03_state = FREE)) then
					ne01_command <= LOCK;
					ne03_command <= LOCK;
				end if;
				if (ne01_lock = LOCKED and ne03_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw01_lock = RELEASED and Sw02_lock = RELEASED) then
					Sw01_command <= RESERVE;
					Sw02_command <= RESERVE;
				end if;
				if (Sw01_lock = RESERVED and Sw02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw01_lock = RESERVED and Sw02_lock = RESERVED) then
					Sw01_command <= LOCK;
					Sw02_command <= LOCK;
				end if;
				if (Sw01_lock = LOCKED and Sw02_lock = LOCKED)then
					ne01_used <= '0';
					ne03_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T02_lock = RELEASED and B26_lock = RELEASED) then
					T02_command <= RESERVE;
					B26_command <= LOCK;
				end if;
				if (T02_lock = RESERVED and B26_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne01_used = '0' and ne01_state = OCCUPIED) then 
					ne01_used <= '1';
				end if;
				if (ne01_used = '1' and ne01_state = FREE) then
					ne01_used <= '0';
					ne01_command <= RELEASE;
				end if;
					---
				if (ne01_lock = RELEASED and ne03_used = '0' and ne03_state = OCCUPIED) then 
					ne03_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw01_command <= RELEASE;
				Sw02_command <= RELEASE;
				ne01_command <= RELEASE;
				ne03_command <= RELEASE;
				T02_command <= RELEASE;
				B26_command <= RELEASE;
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