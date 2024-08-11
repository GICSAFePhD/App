--  route_58.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R59 ['Sw09'] 
--dw  R59 [] 
--sc  R59 [] 
--lc  R59 [] 
	entity route_58 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne110 : in hex_char;
			ne110_command : out routeCommands := RELEASE;
			track_ne29 : in hex_char;
			ne29_command : out routeCommands := RELEASE;
			Sw09_state : in hex_char;
			Sw09_command : out routeCommands := RELEASE;
			S102_state : in hex_char;
			S102_command : out routeCommands := RELEASE;
			B101_state : in hex_char;
			B101_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_58;
architecture Behavioral of route_58 is
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
	signal ne110_used , ne29_used : std_logic := '0';
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal ne29_state : nodeStates := FREE;
	signal ne29_lock : objectLock := RELEASED;
	signal Sw09_position : singleSwitchStates := NORMAL;
	signal Sw09_lock : objectLock := RELEASED;
	signal S102_aspectIn : signalStates := RED;
	signal S102_lock: objectLock := RELEASED;
	signal B101_aspectIn : signalStates := RED;
	signal B101_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	ne29_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne29)(2 to 3))));
	ne29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne29)(0 to 1))));
	Sw09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw09_state)(2 to 3))));
	Sw09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw09_state)(0 to 1))));
	S102_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S102_state)(2 to 3))));
	S102_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S102_state)(0 to 1))));
	B101_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B101_state)(2 to 3))));
	B101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B101_state)(0 to 1))));
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
				if ((ne110_lock = RELEASED and ne29_lock = RELEASED) and (ne29_state = FREE)) then
					ne110_command <= RESERVE;
					ne29_command <= RESERVE;
				end if;
				if (ne110_lock = RESERVED and ne29_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne110_lock = RESERVED and ne29_lock = RESERVED) and (ne29_state = FREE)) then
					ne110_command <= LOCK;
					ne29_command <= LOCK;
				end if;
				if (ne110_lock = LOCKED and ne29_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw09_lock = RELEASED) then
					Sw09_command <= RESERVE;
				end if;
				if (Sw09_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw09_lock = RESERVED) then
					Sw09_command <= LOCK;
				end if;
				if (Sw09_lock = LOCKED)then
					ne110_used <= '0';
					ne29_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S102_lock = RELEASED and B101_lock = RELEASED) then
					S102_command <= RESERVE;
					B101_command <= LOCK;
				end if;
				if (S102_lock = RESERVED and B101_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne110_used = '0' and ne110_state = OCCUPIED) then 
					ne110_used <= '1';
				end if;
				if (ne110_used = '1' and ne110_state = FREE) then
					ne110_used <= '0';
					ne110_command <= RELEASE;
				end if;
					---
				if (ne110_lock = RELEASED and ne29_used = '0' and ne29_state = OCCUPIED) then 
					ne29_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw09_command <= RELEASE;
				ne110_command <= RELEASE;
				ne29_command <= RELEASE;
				S102_command <= RELEASE;
				B101_command <= RELEASE;
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