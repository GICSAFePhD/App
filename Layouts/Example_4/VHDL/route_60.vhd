--  route_60.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R61 ['D14', 'Sw04'] 
--dw  R61 [] 
--sc  R61 [] 
--lc  R61 [] 
	entity route_60 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne290 : in hex_char;
			ne290_command : out routeCommands := RELEASE;
			track_ne292 : in hex_char;
			ne292_command : out routeCommands := RELEASE;
			D14_state : in hex_char;
			D14_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			S86_state : in hex_char;
			S86_command : out routeCommands := RELEASE;
			J36_state : in hex_char;
			J36_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_60;
architecture Behavioral of route_60 is
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
	signal ne290_used , ne292_used : std_logic := '0';
	signal ne290_state : nodeStates := FREE;
	signal ne290_lock : objectLock := RELEASED;
	signal ne292_state : nodeStates := FREE;
	signal ne292_lock : objectLock := RELEASED;
	signal D14_position : singleSwitchStates := NORMAL;
	signal D14_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal S86_aspectIn : signalStates := RED;
	signal S86_lock: objectLock := RELEASED;
	signal J36_aspectIn : signalStates := RED;
	signal J36_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne290_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne290)(2 to 3))));
	ne290_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne290)(0 to 1))));
	ne292_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne292)(2 to 3))));
	ne292_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne292)(0 to 1))));
	D14_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D14_state)(2 to 3))));
	D14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D14_state)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	S86_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S86_state)(2 to 3))));
	S86_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S86_state)(0 to 1))));
	J36_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J36_state)(2 to 3))));
	J36_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J36_state)(0 to 1))));
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
				if ((ne290_lock = RELEASED and ne292_lock = RELEASED) and (ne292_state = FREE)) then
					ne290_command <= RESERVE;
					ne292_command <= RESERVE;
				end if;
				if (ne290_lock = RESERVED and ne292_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne290_lock = RESERVED and ne292_lock = RESERVED) and (ne292_state = FREE)) then
					ne290_command <= LOCK;
					ne292_command <= LOCK;
				end if;
				if (ne290_lock = LOCKED and ne292_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D14_lock = RELEASED and Sw04_lock = RELEASED) then
					D14_command <= RESERVE;
					Sw04_command <= RESERVE;
				end if;
				if (D14_lock = RESERVED and Sw04_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D14_lock = RESERVED and Sw04_lock = RESERVED) then
					D14_command <= LOCK;
					Sw04_command <= LOCK;
				end if;
				if (D14_lock = LOCKED and Sw04_lock = LOCKED)then
					ne290_used <= '0';
					ne292_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S86_lock = RELEASED and J36_lock = RELEASED) then
					S86_command <= RESERVE;
					J36_command <= LOCK;
				end if;
				if (S86_lock = RESERVED and J36_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne290_used = '0' and ne290_state = OCCUPIED) then 
					ne290_used <= '1';
				end if;
				if (ne290_used = '1' and ne290_state = FREE) then
					ne290_used <= '0';
					ne290_command <= RELEASE;
				end if;
					---
				if (ne290_lock = RELEASED and ne292_used = '0' and ne292_state = OCCUPIED) then 
					ne292_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D14_command <= RELEASE;
				Sw04_command <= RELEASE;
				ne290_command <= RELEASE;
				ne292_command <= RELEASE;
				S86_command <= RELEASE;
				J36_command <= RELEASE;
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