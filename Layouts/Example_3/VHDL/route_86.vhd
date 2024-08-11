--  route_86.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R87 [] 
--dw  R87 [] 
--sc  R87 [] 
--lc  R87 [] 
	entity route_86 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne104 : in hex_char;
			ne104_command : out routeCommands := RELEASE;
			track_ne70 : in hex_char;
			ne70_command : out routeCommands := RELEASE;
			B143_state : in hex_char;
			B143_command : out routeCommands := RELEASE;
			L32_state : in hex_char;
			L32_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_86;
architecture Behavioral of route_86 is
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
	signal ne104_used , ne70_used : std_logic := '0';
	signal ne104_state : nodeStates := FREE;
	signal ne104_lock : objectLock := RELEASED;
	signal ne70_state : nodeStates := FREE;
	signal ne70_lock : objectLock := RELEASED;
	signal B143_aspectIn : signalStates := RED;
	signal B143_lock: objectLock := RELEASED;
	signal L32_aspectIn : signalStates := RED;
	signal L32_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne104_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne104)(2 to 3))));
	ne104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne104)(0 to 1))));
	ne70_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne70)(2 to 3))));
	ne70_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne70)(0 to 1))));
	B143_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B143_state)(2 to 3))));
	B143_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B143_state)(0 to 1))));
	L32_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L32_state)(2 to 3))));
	L32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L32_state)(0 to 1))));
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
				if ((ne104_lock = RELEASED and ne70_lock = RELEASED) and (ne70_state = FREE)) then
					ne104_command <= RESERVE;
					ne70_command <= RESERVE;
				end if;
				if (ne104_lock = RESERVED and ne70_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne104_lock = RESERVED and ne70_lock = RESERVED) and (ne70_state = FREE)) then
					ne104_command <= LOCK;
					ne70_command <= LOCK;
				end if;
				if (ne104_lock = LOCKED and ne70_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					restart <= '1';
				routeState <= LOCKING_INFRASTRUCTURE;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					ne104_used <= '0';
					ne70_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (B143_lock = RELEASED and L32_lock = RELEASED) then
					B143_command <= RESERVE;
					L32_command <= LOCK;
				end if;
				if (B143_lock = RESERVED and L32_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne104_used = '0' and ne104_state = OCCUPIED) then 
					ne104_used <= '1';
				end if;
				if (ne104_used = '1' and ne104_state = FREE) then
					ne104_used <= '0';
					ne104_command <= RELEASE;
				end if;
					---
				if (ne104_lock = RELEASED and ne70_used = '0' and ne70_state = OCCUPIED) then 
					ne70_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne104_command <= RELEASE;
				ne70_command <= RELEASE;
				B143_command <= RELEASE;
				L32_command <= RELEASE;
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