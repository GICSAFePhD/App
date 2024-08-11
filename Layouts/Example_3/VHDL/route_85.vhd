--  route_85.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R86 ['Sw41'] 
--dw  R86 [] 
--sc  R86 [] 
--lc  R86 [] 
	entity route_85 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne100 : in hex_char;
			ne100_command : out routeCommands := RELEASE;
			track_ne85 : in hex_char;
			ne85_command : out routeCommands := RELEASE;
			Sw41_state : in hex_char;
			Sw41_command : out routeCommands := RELEASE;
			S139_state : in hex_char;
			S139_command : out routeCommands := RELEASE;
			S131_state : in hex_char;
			S131_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_85;
architecture Behavioral of route_85 is
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
	signal ne100_used , ne85_used : std_logic := '0';
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal ne85_state : nodeStates := FREE;
	signal ne85_lock : objectLock := RELEASED;
	signal Sw41_position : singleSwitchStates := NORMAL;
	signal Sw41_lock : objectLock := RELEASED;
	signal S139_aspectIn : signalStates := RED;
	signal S139_lock: objectLock := RELEASED;
	signal S131_aspectIn : signalStates := RED;
	signal S131_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	ne85_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne85)(2 to 3))));
	ne85_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne85)(0 to 1))));
	Sw41_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw41_state)(2 to 3))));
	Sw41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw41_state)(0 to 1))));
	S139_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S139_state)(2 to 3))));
	S139_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S139_state)(0 to 1))));
	S131_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S131_state)(2 to 3))));
	S131_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S131_state)(0 to 1))));
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
				if ((ne100_lock = RELEASED and ne85_lock = RELEASED) and (ne85_state = FREE)) then
					ne100_command <= RESERVE;
					ne85_command <= RESERVE;
				end if;
				if (ne100_lock = RESERVED and ne85_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne100_lock = RESERVED and ne85_lock = RESERVED) and (ne85_state = FREE)) then
					ne100_command <= LOCK;
					ne85_command <= LOCK;
				end if;
				if (ne100_lock = LOCKED and ne85_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw41_lock = RELEASED) then
					Sw41_command <= RESERVE;
				end if;
				if (Sw41_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw41_lock = RESERVED) then
					Sw41_command <= LOCK;
				end if;
				if (Sw41_lock = LOCKED)then
					ne100_used <= '0';
					ne85_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S139_lock = RELEASED and S131_lock = RELEASED) then
					S139_command <= RESERVE;
					S131_command <= LOCK;
				end if;
				if (S139_lock = RESERVED and S131_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne100_used = '0' and ne100_state = OCCUPIED) then 
					ne100_used <= '1';
				end if;
				if (ne100_used = '1' and ne100_state = FREE) then
					ne100_used <= '0';
					ne100_command <= RELEASE;
				end if;
					---
				if (ne100_lock = RELEASED and ne85_used = '0' and ne85_state = OCCUPIED) then 
					ne85_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw41_command <= RELEASE;
				ne100_command <= RELEASE;
				ne85_command <= RELEASE;
				S139_command <= RELEASE;
				S131_command <= RELEASE;
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