--  route_35.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R36 ['Sw06'] 
--dw  R36 ['Sw07'] 
--sc  R36 [] 
--lc  R36 [] 
	entity route_35 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne21 : in hex_char;
			ne21_command : out routeCommands := RELEASE;
			track_ne79 : in hex_char;
			ne79_command : out routeCommands := RELEASE;
			track_ne78 : in hex_char;
			ne78_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			P73_state : in hex_char;
			P73_command : out routeCommands := RELEASE;
			L33_state : in hex_char;
			L33_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_35;
architecture Behavioral of route_35 is
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
	signal ne21_used , ne79_used , ne78_used : std_logic := '0';
	signal ne21_state : nodeStates := FREE;
	signal ne21_lock : objectLock := RELEASED;
	signal ne79_state : nodeStates := FREE;
	signal ne79_lock : objectLock := RELEASED;
	signal ne78_state : nodeStates := FREE;
	signal ne78_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal Sw07_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw07_lock : objectLock := RELEASED;
	signal P73_aspectIn : signalStates := RED;
	signal P73_lock: objectLock := RELEASED;
	signal L33_aspectIn : signalStates := RED;
	signal L33_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne21_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne21)(2 to 3))));
	ne21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne21)(0 to 1))));
	ne79_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne79)(2 to 3))));
	ne79_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne79)(0 to 1))));
	ne78_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne78)(2 to 3))));
	ne78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne78)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	Sw07_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw07_state)(2 to 3))));
	Sw07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw07_state)(0 to 1))));
	P73_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P73_state)(2 to 3))));
	P73_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P73_state)(0 to 1))));
	L33_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L33_state)(2 to 3))));
	L33_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L33_state)(0 to 1))));
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
				if ((ne21_lock = RELEASED and ne79_lock = RELEASED and ne78_lock = RELEASED) and (ne79_state = FREE and ne78_state = FREE)) then
					ne21_command <= RESERVE;
					ne79_command <= RESERVE;
					ne78_command <= RESERVE;
				end if;
				if (ne21_lock = RESERVED and ne79_lock = RESERVED and ne78_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne21_lock = RESERVED and ne79_lock = RESERVED and ne78_lock = RESERVED) and (ne79_state = FREE and ne78_state = FREE)) then
					ne21_command <= LOCK;
					ne79_command <= LOCK;
					ne78_command <= LOCK;
				end if;
				if (ne21_lock = LOCKED and ne79_lock = LOCKED and ne78_lock = LOCKED)then
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
					ne21_used <= '0';
					ne79_used <= '0';
					ne78_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (P73_lock = RELEASED and L33_lock = RELEASED) then
					P73_command <= RESERVE;
					L33_command <= LOCK;
				end if;
				if (P73_lock = RESERVED and L33_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne21_used = '0' and ne21_state = OCCUPIED) then 
					ne21_used <= '1';
				end if;
				if (ne21_used = '1' and ne21_state = FREE) then
					ne21_used <= '0';
					ne21_command <= RELEASE;
				end if;
					---
				if (ne21_lock = RELEASED and ne79_used = '0' and ne79_state = OCCUPIED) then 
					ne79_used <= '1';
				end if;
				if (ne79_used = '1' and ne79_state = FREE) then
					ne79_used <= '0';
					ne79_command <= RELEASE;
				end if;
					---
				if (ne79_lock = RELEASED and ne78_used = '0' and ne78_state = OCCUPIED) then 
					ne78_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw06_command <= RELEASE;
				Sw07_command <= RELEASE;
				ne21_command <= RELEASE;
				ne79_command <= RELEASE;
				ne78_command <= RELEASE;
				P73_command <= RELEASE;
				L33_command <= RELEASE;
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