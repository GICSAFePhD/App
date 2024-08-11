--  route_67.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R68 ['Sw08', 'Sw04'] 
--dw  R68 [] 
--sc  R68 [] 
--lc  R68 [] 
	entity route_67 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne32 : in hex_char;
			ne32_command : out routeCommands := RELEASE;
			track_ne83 : in hex_char;
			ne83_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			S115_state : in hex_char;
			S115_command : out routeCommands := RELEASE;
			C95_state : in hex_char;
			C95_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_67;
architecture Behavioral of route_67 is
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
	signal ne32_used , ne83_used : std_logic := '0';
	signal ne32_state : nodeStates := FREE;
	signal ne32_lock : objectLock := RELEASED;
	signal ne83_state : nodeStates := FREE;
	signal ne83_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal S115_aspectIn : signalStates := RED;
	signal S115_lock: objectLock := RELEASED;
	signal C95_aspectIn : signalStates := RED;
	signal C95_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne32_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne32)(2 to 3))));
	ne32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne32)(0 to 1))));
	ne83_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne83)(2 to 3))));
	ne83_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne83)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	S115_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S115_state)(2 to 3))));
	S115_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S115_state)(0 to 1))));
	C95_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C95_state)(2 to 3))));
	C95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C95_state)(0 to 1))));
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
				if ((ne32_lock = RELEASED and ne83_lock = RELEASED) and (ne83_state = FREE)) then
					ne32_command <= RESERVE;
					ne83_command <= RESERVE;
				end if;
				if (ne32_lock = RESERVED and ne83_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne32_lock = RESERVED and ne83_lock = RESERVED) and (ne83_state = FREE)) then
					ne32_command <= LOCK;
					ne83_command <= LOCK;
				end if;
				if (ne32_lock = LOCKED and ne83_lock = LOCKED)then
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
					ne32_used <= '0';
					ne83_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S115_lock = RELEASED and C95_lock = RELEASED) then
					S115_command <= RESERVE;
					C95_command <= LOCK;
				end if;
				if (S115_lock = RESERVED and C95_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne32_used = '0' and ne32_state = OCCUPIED) then 
					ne32_used <= '1';
				end if;
				if (ne32_used = '1' and ne32_state = FREE) then
					ne32_used <= '0';
					ne32_command <= RELEASE;
				end if;
					---
				if (ne32_lock = RELEASED and ne83_used = '0' and ne83_state = OCCUPIED) then 
					ne83_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw08_command <= RELEASE;
				Sw04_command <= RELEASE;
				ne32_command <= RELEASE;
				ne83_command <= RELEASE;
				S115_command <= RELEASE;
				C95_command <= RELEASE;
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