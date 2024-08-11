--  route_82.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R83 [] 
--dw  R83 ['Sw07'] 
--sc  R83 [] 
--lc  R83 [] 
	entity route_82 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne94 : in hex_char;
			ne94_command : out routeCommands := RELEASE;
			track_ne21 : in hex_char;
			ne21_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			S135_state : in hex_char;
			S135_command : out routeCommands := RELEASE;
			P72_state : in hex_char;
			P72_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_82;
architecture Behavioral of route_82 is
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
	signal ne94_used , ne21_used : std_logic := '0';
	signal ne94_state : nodeStates := FREE;
	signal ne94_lock : objectLock := RELEASED;
	signal ne21_state : nodeStates := FREE;
	signal ne21_lock : objectLock := RELEASED;
	signal Sw07_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw07_lock : objectLock := RELEASED;
	signal S135_aspectIn : signalStates := RED;
	signal S135_lock: objectLock := RELEASED;
	signal P72_aspectIn : signalStates := RED;
	signal P72_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne94_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne94)(2 to 3))));
	ne94_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne94)(0 to 1))));
	ne21_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne21)(2 to 3))));
	ne21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne21)(0 to 1))));
	Sw07_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw07_state)(2 to 3))));
	Sw07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw07_state)(0 to 1))));
	S135_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S135_state)(2 to 3))));
	S135_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S135_state)(0 to 1))));
	P72_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P72_state)(2 to 3))));
	P72_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P72_state)(0 to 1))));
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
				if ((ne94_lock = RELEASED and ne21_lock = RELEASED) and (ne21_state = FREE)) then
					ne94_command <= RESERVE;
					ne21_command <= RESERVE;
				end if;
				if (ne94_lock = RESERVED and ne21_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne94_lock = RESERVED and ne21_lock = RESERVED) and (ne21_state = FREE)) then
					ne94_command <= LOCK;
					ne21_command <= LOCK;
				end if;
				if (ne94_lock = LOCKED and ne21_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw07_lock = RELEASED) then
					Sw07_command <= RESERVE;
				end if;
				if (Sw07_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw07_lock = RESERVED) then
					Sw07_command <= LOCK;
				end if;
				if (Sw07_lock = LOCKED)then
					ne94_used <= '0';
					ne21_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S135_lock = RELEASED and P72_lock = RELEASED) then
					S135_command <= RESERVE;
					P72_command <= LOCK;
				end if;
				if (S135_lock = RESERVED and P72_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne94_used = '0' and ne94_state = OCCUPIED) then 
					ne94_used <= '1';
				end if;
				if (ne94_used = '1' and ne94_state = FREE) then
					ne94_used <= '0';
					ne94_command <= RELEASE;
				end if;
					---
				if (ne94_lock = RELEASED and ne21_used = '0' and ne21_state = OCCUPIED) then 
					ne21_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw07_command <= RELEASE;
				ne94_command <= RELEASE;
				ne21_command <= RELEASE;
				S135_command <= RELEASE;
				P72_command <= RELEASE;
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