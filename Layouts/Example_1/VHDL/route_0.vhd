--  route_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R1 ['Sw06'] 
--dw  R1 [] 
--sc  R1 [] 
--lc  R1 ['Lc08'] 
	entity route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne13 : in hex_char;
			ne13_command : out routeCommands := RELEASE;
			Lc08_state : in hex_char;
			Lc08_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			P20_state : in hex_char;
			P20_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_0;
architecture Behavioral of route_0 is
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
	signal ne13_used : std_logic := '0';
	signal ne13_state : nodeStates := FREE;
	signal ne13_lock : objectLock := RELEASED;
	signal Lc08_position : levelCrossingStates := UP;
	signal Lc08_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal T02_aspectIn : signalStates := RED;
	signal T02_lock: objectLock := RELEASED;
	signal P20_aspectIn : signalStates := RED;
	signal P20_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne13_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne13)(2 to 3))));
	ne13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne13)(0 to 1))));
	Lc08_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc08_state)(2 to 3))));
	Lc08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc08_state)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	T02_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T02_state)(2 to 3))));
	T02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T02_state)(0 to 1))));
	P20_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P20_state)(2 to 3))));
	P20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P20_state)(0 to 1))));
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
				if (ne13_lock = RELEASED) then
					ne13_command <= RESERVE;
				end if;
				if (ne13_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne13_lock = RESERVED) then
					ne13_command <= LOCK;
				end if;
				if (ne13_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc08_lock = RELEASED and Sw06_lock = RELEASED) then
					Lc08_command <= RESERVE;
					Sw06_command <= RESERVE;
				end if;
				if (Lc08_lock = RESERVED and Sw06_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc08_lock = RESERVED and Sw06_lock = RESERVED) then
					Lc08_command <= LOCK;
					Sw06_command <= LOCK;
				end if;
				if (Lc08_lock = LOCKED and Sw06_lock = LOCKED)then
					ne13_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T02_lock = RELEASED and P20_lock = RELEASED) then
					T02_command <= RESERVE;
					P20_command <= LOCK;
				end if;
				if (T02_lock = RESERVED and P20_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne13_used = '0' and ne13_state = OCCUPIED) then 
					ne13_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc08_command <= RELEASE;
				Sw06_command <= RELEASE;
				ne13_command <= RELEASE;
				T02_command <= RELEASE;
				P20_command <= RELEASE;
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