--  route_54.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R55 ['Sw08', 'Sw04'] 
--dw  R55 [] 
--sc  R55 [] 
--lc  R55 [] 
	entity route_54 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne30 : in hex_char;
			ne30_command : out routeCommands := RELEASE;
			track_ne83 : in hex_char;
			ne83_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			S97_state : in hex_char;
			S97_command : out routeCommands := RELEASE;
			C114_state : in hex_char;
			C114_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_54;
architecture Behavioral of route_54 is
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
	signal ne30_used , ne83_used : std_logic := '0';
	signal ne30_state : nodeStates := FREE;
	signal ne30_lock : objectLock := RELEASED;
	signal ne83_state : nodeStates := FREE;
	signal ne83_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal S97_aspectIn : signalStates := RED;
	signal S97_lock: objectLock := RELEASED;
	signal C114_aspectIn : signalStates := RED;
	signal C114_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne30_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne30)(2 to 3))));
	ne30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne30)(0 to 1))));
	ne83_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne83)(2 to 3))));
	ne83_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne83)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	S97_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S97_state)(2 to 3))));
	S97_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S97_state)(0 to 1))));
	C114_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C114_state)(2 to 3))));
	C114_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C114_state)(0 to 1))));
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
				if ((ne30_lock = RELEASED and ne83_lock = RELEASED) and (ne83_state = FREE)) then
					ne30_command <= RESERVE;
					ne83_command <= RESERVE;
				end if;
				if (ne30_lock = RESERVED and ne83_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne30_lock = RESERVED and ne83_lock = RESERVED) and (ne83_state = FREE)) then
					ne30_command <= LOCK;
					ne83_command <= LOCK;
				end if;
				if (ne30_lock = LOCKED and ne83_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw08_lock = RELEASED and Sw04_lock = RELEASED) then
					Sw08_command <= RESERVE;
					Sw04_command <= RESERVE;
				end if;
				if (Sw08_lock = RESERVED and Sw04_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw08_lock = RESERVED and Sw04_lock = RESERVED) then
					Sw08_command <= LOCK;
					Sw04_command <= LOCK;
				end if;
				if (Sw08_lock = LOCKED and Sw04_lock = LOCKED)then
					ne30_used <= '0';
					ne83_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S97_lock = RELEASED and C114_lock = RELEASED) then
					S97_command <= RESERVE;
					C114_command <= LOCK;
				end if;
				if (S97_lock = RESERVED and C114_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne30_used = '0' and ne30_state = OCCUPIED) then 
					ne30_used <= '1';
				end if;
				if (ne30_used = '1' and ne30_state = FREE) then
					ne30_used <= '0';
					ne30_command <= RELEASE;
				end if;
					---
				if (ne30_lock = RELEASED and ne83_used = '0' and ne83_state = OCCUPIED) then 
					ne83_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw08_command <= RELEASE;
				Sw04_command <= RELEASE;
				ne30_command <= RELEASE;
				ne83_command <= RELEASE;
				S97_command <= RELEASE;
				C114_command <= RELEASE;
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