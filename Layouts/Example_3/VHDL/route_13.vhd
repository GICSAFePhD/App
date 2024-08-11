--  route_13.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R14 ['Sw06'] 
--dw  R14 [] 
--sc  R14 ['Sw03'] 
--lc  R14 [] 
	entity route_13 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne70 : in hex_char;
			ne70_command : out routeCommands := RELEASE;
			track_ne104 : in hex_char;
			ne104_command : out routeCommands := RELEASE;
			track_ne21 : in hex_char;
			ne21_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			L32_state : in hex_char;
			L32_command : out routeCommands := RELEASE;
			P73_state : in hex_char;
			P73_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_13;
architecture Behavioral of route_13 is
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
	signal ne70_used , ne104_used , ne21_used : std_logic := '0';
	signal ne70_state : nodeStates := FREE;
	signal ne70_lock : objectLock := RELEASED;
	signal ne104_state : nodeStates := FREE;
	signal ne104_lock : objectLock := RELEASED;
	signal ne21_state : nodeStates := FREE;
	signal ne21_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal Sw03_position : scissorCrossingStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal L32_aspectIn : signalStates := RED;
	signal L32_lock: objectLock := RELEASED;
	signal P73_aspectIn : signalStates := RED;
	signal P73_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne70_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne70)(2 to 3))));
	ne70_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne70)(0 to 1))));
	ne104_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne104)(2 to 3))));
	ne104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne104)(0 to 1))));
	ne21_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne21)(2 to 3))));
	ne21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne21)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	Sw03_position <= scissorCrossingStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	L32_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L32_state)(2 to 3))));
	L32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L32_state)(0 to 1))));
	P73_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P73_state)(2 to 3))));
	P73_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P73_state)(0 to 1))));
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
				if ((ne70_lock = RELEASED and ne104_lock = RELEASED and ne21_lock = RELEASED) and (ne104_state = FREE and ne21_state = FREE)) then
					ne70_command <= RESERVE;
					ne104_command <= RESERVE;
					ne21_command <= RESERVE;
				end if;
				if (ne70_lock = RESERVED and ne104_lock = RESERVED and ne21_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne70_lock = RESERVED and ne104_lock = RESERVED and ne21_lock = RESERVED) and (ne104_state = FREE and ne21_state = FREE)) then
					ne70_command <= LOCK;
					ne104_command <= LOCK;
					ne21_command <= LOCK;
				end if;
				if (ne70_lock = LOCKED and ne104_lock = LOCKED and ne21_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw06_lock = RELEASED and Sw03_lock = RELEASED) then
					Sw06_command <= RESERVE;
					Sw03_command <= RESERVE;
				end if;
				if (Sw06_lock = RESERVED and Sw03_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw06_lock = RESERVED and Sw03_lock = RESERVED) then
					Sw06_command <= LOCK;
					Sw03_command <= LOCK;
				end if;
				if (Sw06_lock = LOCKED and Sw03_lock = LOCKED)then
					ne70_used <= '0';
					ne104_used <= '0';
					ne21_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (L32_lock = RELEASED and P73_lock = RELEASED) then
					L32_command <= RESERVE;
					P73_command <= LOCK;
				end if;
				if (L32_lock = RESERVED and P73_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne70_used = '0' and ne70_state = OCCUPIED) then 
					ne70_used <= '1';
				end if;
				if (ne70_used = '1' and ne70_state = FREE) then
					ne70_used <= '0';
					ne70_command <= RELEASE;
				end if;
					---
				if (ne70_lock = RELEASED and ne104_used = '0' and ne104_state = OCCUPIED) then 
					ne104_used <= '1';
				end if;
				if (ne104_used = '1' and ne104_state = FREE) then
					ne104_used <= '0';
					ne104_command <= RELEASE;
				end if;
					---
				if (ne104_lock = RELEASED and ne21_used = '0' and ne21_state = OCCUPIED) then 
					ne21_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw06_command <= RELEASE;
				Sw03_command <= RELEASE;
				ne70_command <= RELEASE;
				ne104_command <= RELEASE;
				ne21_command <= RELEASE;
				L32_command <= RELEASE;
				P73_command <= RELEASE;
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