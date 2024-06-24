--  route_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R12 ['Sw27'] 
--YYY  R12 ['Lc10'] 
	entity route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne46 : in hex_char;
			ne46_command : out routeCommands := RELEASE;
			Lc10_state : in hex_char;
			Lc10_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			J16_state : in hex_char;
			J16_command : out routeCommands := RELEASE;
			J10_state : in hex_char;
			J10_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_11;
architecture Behavioral of route_11 is
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
	signal ne46_used : std_logic := '0';
	signal ne46_state : nodeStates := FREE;
	signal ne46_lock : objectLock := RELEASED;
	signal Lc10_position : levelCrossingStates := UP;
	signal Lc10_lock : objectLock := RELEASED;
	signal Sw27_position : singleSwitchStates := NORMAL;
	signal Sw27_lock : objectLock := RELEASED;
	signal J16_aspectIn : signalStates := RED;
	signal J16_lock: objectLock := RELEASED;
	signal J10_aspectIn : signalStates := RED;
	signal J10_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne46_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne46)(2 to 3))));
	ne46_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne46)(0 to 1))));
	Lc10_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc10_state)(2 to 3))));
	Lc10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc10_state)(0 to 1))));
	Sw27_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw27_state)(2 to 3))));
	Sw27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw27_state)(0 to 1))));
	J16_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J16_state)(2 to 3))));
	J16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J16_state)(0 to 1))));
	J10_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J10_state)(2 to 3))));
	J10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J10_state)(0 to 1))));
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
				if (ne46_lock = RELEASED) then
					ne46_command <= RESERVE;
				end if;
				if (ne46_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne46_lock = RESERVED) then
					ne46_command <= LOCK;
				end if;
				if (ne46_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc10_lock = RELEASED and Sw27_lock = RELEASED) then
					Lc10_command <= RESERVE;
					Sw27_command <= RESERVE;
				end if;
				if (Lc10_lock = RESERVED and Sw27_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc10_lock = RESERVED and Sw27_lock = RESERVED) then
					Lc10_command <= LOCK;
					Sw27_command <= LOCK;
				end if;
				if (Lc10_lock = LOCKED and Sw27_lock = LOCKED)then
					ne46_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (J16_lock = RELEASED and J10_lock = RELEASED) then
					J16_command <= RESERVE;
					J10_command <= LOCK;
				end if;
				if (J16_lock = RESERVED and J10_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne46_used = '0' and ne46_state = OCCUPIED) then 
					ne46_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc10_command <= RELEASE;
				Sw27_command <= RELEASE;
				ne46_command <= RELEASE;
				J16_command <= RELEASE;
				J10_command <= RELEASE;
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