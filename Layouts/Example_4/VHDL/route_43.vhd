--  route_43.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R44 ['D03', 'D04', 'Sw02'] 
--dw  R44 [] 
--sc  R44 [] 
--lc  R44 [] 
	entity route_43 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne288 : in hex_char;
			ne288_command : out routeCommands := RELEASE;
			track_ne110 : in hex_char;
			ne110_command : out routeCommands := RELEASE;
			D03_state : in hex_char;
			D03_command : out routeCommands := RELEASE;
			D04_state : in hex_char;
			D04_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			S69_state : in hex_char;
			S69_command : out routeCommands := RELEASE;
			B68_state : in hex_char;
			B68_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_43;
architecture Behavioral of route_43 is
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
	signal ne288_used , ne110_used : std_logic := '0';
	signal ne288_state : nodeStates := FREE;
	signal ne288_lock : objectLock := RELEASED;
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal D03_position : singleSwitchStates := NORMAL;
	signal D03_lock : objectLock := RELEASED;
	signal D04_position : singleSwitchStates := NORMAL;
	signal D04_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	signal S69_aspectIn : signalStates := RED;
	signal S69_lock: objectLock := RELEASED;
	signal B68_aspectIn : signalStates := RED;
	signal B68_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne288_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne288)(2 to 3))));
	ne288_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne288)(0 to 1))));
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	D03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D03_state)(2 to 3))));
	D03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D03_state)(0 to 1))));
	D04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D04_state)(2 to 3))));
	D04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D04_state)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	S69_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S69_state)(2 to 3))));
	S69_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S69_state)(0 to 1))));
	B68_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B68_state)(2 to 3))));
	B68_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B68_state)(0 to 1))));
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
				if ((ne288_lock = RELEASED and ne110_lock = RELEASED) and (ne110_state = FREE)) then
					ne288_command <= RESERVE;
					ne110_command <= RESERVE;
				end if;
				if (ne288_lock = RESERVED and ne110_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne288_lock = RESERVED and ne110_lock = RESERVED) and (ne110_state = FREE)) then
					ne288_command <= LOCK;
					ne110_command <= LOCK;
				end if;
				if (ne288_lock = LOCKED and ne110_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D03_lock = RELEASED and D04_lock = RELEASED and Sw02_lock = RELEASED) then
					D03_command <= RESERVE;
					D04_command <= RESERVE;
					Sw02_command <= RESERVE;
				end if;
				if (D03_lock = RESERVED and D04_lock = RESERVED and Sw02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D03_lock = RESERVED and D04_lock = RESERVED and Sw02_lock = RESERVED) then
					D03_command <= LOCK;
					D04_command <= LOCK;
					Sw02_command <= LOCK;
				end if;
				if (D03_lock = LOCKED and D04_lock = LOCKED and Sw02_lock = LOCKED)then
					ne288_used <= '0';
					ne110_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S69_lock = RELEASED and B68_lock = RELEASED) then
					S69_command <= RESERVE;
					B68_command <= LOCK;
				end if;
				if (S69_lock = RESERVED and B68_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne288_used = '0' and ne288_state = OCCUPIED) then 
					ne288_used <= '1';
				end if;
				if (ne288_used = '1' and ne288_state = FREE) then
					ne288_used <= '0';
					ne288_command <= RELEASE;
				end if;
					---
				if (ne288_lock = RELEASED and ne110_used = '0' and ne110_state = OCCUPIED) then 
					ne110_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D03_command <= RELEASE;
				D04_command <= RELEASE;
				Sw02_command <= RELEASE;
				ne288_command <= RELEASE;
				ne110_command <= RELEASE;
				S69_command <= RELEASE;
				B68_command <= RELEASE;
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