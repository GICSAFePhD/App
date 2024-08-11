--  route_66.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R67 ['Sw09', 'Sw04'] 
--dw  R67 [] 
--sc  R67 [] 
--lc  R67 [] 
	entity route_66 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne83 : in hex_char;
			ne83_command : out routeCommands := RELEASE;
			track_ne32 : in hex_char;
			ne32_command : out routeCommands := RELEASE;
			Sw09_state : in hex_char;
			Sw09_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			C114_state : in hex_char;
			C114_command : out routeCommands := RELEASE;
			C100_state : in hex_char;
			C100_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_66;
architecture Behavioral of route_66 is
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
	signal ne83_used , ne32_used : std_logic := '0';
	signal ne83_state : nodeStates := FREE;
	signal ne83_lock : objectLock := RELEASED;
	signal ne32_state : nodeStates := FREE;
	signal ne32_lock : objectLock := RELEASED;
	signal Sw09_position : singleSwitchStates := NORMAL;
	signal Sw09_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal C114_aspectIn : signalStates := RED;
	signal C114_lock: objectLock := RELEASED;
	signal C100_aspectIn : signalStates := RED;
	signal C100_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne83_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne83)(2 to 3))));
	ne83_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne83)(0 to 1))));
	ne32_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne32)(2 to 3))));
	ne32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne32)(0 to 1))));
	Sw09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw09_state)(2 to 3))));
	Sw09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw09_state)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	C114_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C114_state)(2 to 3))));
	C114_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C114_state)(0 to 1))));
	C100_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C100_state)(2 to 3))));
	C100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C100_state)(0 to 1))));
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
				if ((ne83_lock = RELEASED and ne32_lock = RELEASED) and (ne32_state = FREE)) then
					ne83_command <= RESERVE;
					ne32_command <= RESERVE;
				end if;
				if (ne83_lock = RESERVED and ne32_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne83_lock = RESERVED and ne32_lock = RESERVED) and (ne32_state = FREE)) then
					ne83_command <= LOCK;
					ne32_command <= LOCK;
				end if;
				if (ne83_lock = LOCKED and ne32_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw09_lock = RELEASED and Sw04_lock = RELEASED) then
					Sw09_command <= RESERVE;
					Sw04_command <= RESERVE;
				end if;
				if (Sw09_lock = RESERVED and Sw04_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw09_lock = RESERVED and Sw04_lock = RESERVED) then
					Sw09_command <= LOCK;
					Sw04_command <= LOCK;
				end if;
				if (Sw09_lock = LOCKED and Sw04_lock = LOCKED)then
					ne83_used <= '0';
					ne32_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (C114_lock = RELEASED and C100_lock = RELEASED) then
					C114_command <= RESERVE;
					C100_command <= LOCK;
				end if;
				if (C114_lock = RESERVED and C100_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne83_used = '0' and ne83_state = OCCUPIED) then 
					ne83_used <= '1';
				end if;
				if (ne83_used = '1' and ne83_state = FREE) then
					ne83_used <= '0';
					ne83_command <= RELEASE;
				end if;
					---
				if (ne83_lock = RELEASED and ne32_used = '0' and ne32_state = OCCUPIED) then 
					ne32_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw09_command <= RELEASE;
				Sw04_command <= RELEASE;
				ne83_command <= RELEASE;
				ne32_command <= RELEASE;
				C114_command <= RELEASE;
				C100_command <= RELEASE;
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