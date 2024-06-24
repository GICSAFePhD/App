--  route_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R5 [] 
--YYY  R5 ['Lc05'] 
	entity route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne25 : in hex_char;
			ne25_command : out routeCommands := RELEASE;
			Lc05_state : in hex_char;
			Lc05_command : out routeCommands := RELEASE;
			X13_state : in hex_char;
			X13_command : out routeCommands := RELEASE;
			L03_state : in hex_char;
			L03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_4;
architecture Behavioral of route_4 is
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
	signal ne25_used : std_logic := '0';
	signal ne25_state : nodeStates := FREE;
	signal ne25_lock : objectLock := RELEASED;
	signal Lc05_position : levelCrossingStates := UP;
	signal Lc05_lock : objectLock := RELEASED;
	signal X13_aspectIn : signalStates := RED;
	signal X13_lock: objectLock := RELEASED;
	signal L03_aspectIn : signalStates := RED;
	signal L03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne25_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne25)(2 to 3))));
	ne25_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne25)(0 to 1))));
	Lc05_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc05_state)(2 to 3))));
	Lc05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc05_state)(0 to 1))));
	X13_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X13_state)(2 to 3))));
	X13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X13_state)(0 to 1))));
	L03_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L03_state)(2 to 3))));
	L03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L03_state)(0 to 1))));
	gen : for i in 0 to 31 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "011011111100001000111010101111110") then
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
				if (ne25_lock = RELEASED) then
					ne25_command <= RESERVE;
				end if;
				if (ne25_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne25_lock = RESERVED) then
					ne25_command <= LOCK;
				end if;
				if (ne25_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc05_lock = RELEASED) then
					Lc05_command <= RESERVE;
				end if;
				if (Lc05_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc05_lock = RESERVED) then
					Lc05_command <= LOCK;
				end if;
				if (Lc05_lock = LOCKED)then
					ne25_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (X13_lock = RELEASED and L03_lock = RELEASED) then
					X13_command <= RESERVE;
					L03_command <= LOCK;
				end if;
				if (X13_lock = RESERVED and L03_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne25_used = '0' and ne25_state = OCCUPIED) then 
					ne25_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc05_command <= RELEASE;
				ne25_command <= RELEASE;
				X13_command <= RELEASE;
				L03_command <= RELEASE;
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