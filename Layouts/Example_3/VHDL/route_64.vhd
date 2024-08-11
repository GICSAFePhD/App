--  route_64.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R65 ['Sw06'] 
--dw  R65 ['Sw07'] 
--sc  R65 [] 
--lc  R65 [] 
	entity route_64 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne78 : in hex_char;
			ne78_command : out routeCommands := RELEASE;
			track_ne79 : in hex_char;
			ne79_command : out routeCommands := RELEASE;
			track_ne77 : in hex_char;
			ne77_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			S110_state : in hex_char;
			S110_command : out routeCommands := RELEASE;
			B133_state : in hex_char;
			B133_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_64;
architecture Behavioral of route_64 is
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
	signal ne78_used , ne79_used , ne77_used : std_logic := '0';
	signal ne78_state : nodeStates := FREE;
	signal ne78_lock : objectLock := RELEASED;
	signal ne79_state : nodeStates := FREE;
	signal ne79_lock : objectLock := RELEASED;
	signal ne77_state : nodeStates := FREE;
	signal ne77_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal Sw07_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw07_lock : objectLock := RELEASED;
	signal S110_aspectIn : signalStates := RED;
	signal S110_lock: objectLock := RELEASED;
	signal B133_aspectIn : signalStates := RED;
	signal B133_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne78_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne78)(2 to 3))));
	ne78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne78)(0 to 1))));
	ne79_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne79)(2 to 3))));
	ne79_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne79)(0 to 1))));
	ne77_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne77)(2 to 3))));
	ne77_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne77)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	Sw07_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw07_state)(2 to 3))));
	Sw07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw07_state)(0 to 1))));
	S110_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S110_state)(2 to 3))));
	S110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S110_state)(0 to 1))));
	B133_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B133_state)(2 to 3))));
	B133_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B133_state)(0 to 1))));
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
				if ((ne78_lock = RELEASED and ne79_lock = RELEASED and ne77_lock = RELEASED) and (ne79_state = FREE and ne77_state = FREE)) then
					ne78_command <= RESERVE;
					ne79_command <= RESERVE;
					ne77_command <= RESERVE;
				end if;
				if (ne78_lock = RESERVED and ne79_lock = RESERVED and ne77_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne78_lock = RESERVED and ne79_lock = RESERVED and ne77_lock = RESERVED) and (ne79_state = FREE and ne77_state = FREE)) then
					ne78_command <= LOCK;
					ne79_command <= LOCK;
					ne77_command <= LOCK;
				end if;
				if (ne78_lock = LOCKED and ne79_lock = LOCKED and ne77_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw06_lock = RELEASED and Sw07_lock = RELEASED) then
					Sw06_command <= RESERVE;
					Sw07_command <= RESERVE;
				end if;
				if (Sw06_lock = RESERVED and Sw07_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw06_lock = RESERVED and Sw07_lock = RESERVED) then
					Sw06_command <= LOCK;
					Sw07_command <= LOCK;
				end if;
				if (Sw06_lock = LOCKED and Sw07_lock = LOCKED)then
					ne78_used <= '0';
					ne79_used <= '0';
					ne77_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S110_lock = RELEASED and B133_lock = RELEASED) then
					S110_command <= RESERVE;
					B133_command <= LOCK;
				end if;
				if (S110_lock = RESERVED and B133_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne78_used = '0' and ne78_state = OCCUPIED) then 
					ne78_used <= '1';
				end if;
				if (ne78_used = '1' and ne78_state = FREE) then
					ne78_used <= '0';
					ne78_command <= RELEASE;
				end if;
					---
				if (ne78_lock = RELEASED and ne79_used = '0' and ne79_state = OCCUPIED) then 
					ne79_used <= '1';
				end if;
				if (ne79_used = '1' and ne79_state = FREE) then
					ne79_used <= '0';
					ne79_command <= RELEASE;
				end if;
					---
				if (ne79_lock = RELEASED and ne77_used = '0' and ne77_state = OCCUPIED) then 
					ne77_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw06_command <= RELEASE;
				Sw07_command <= RELEASE;
				ne78_command <= RELEASE;
				ne79_command <= RELEASE;
				ne77_command <= RELEASE;
				S110_command <= RELEASE;
				B133_command <= RELEASE;
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