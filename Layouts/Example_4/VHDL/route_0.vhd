--  route_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R1 ['D01'] 
--dw  R1 [] 
--sc  R1 [] 
--lc  R1 [] 
	entity route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne991 : in hex_char;
			ne991_command : out routeCommands := RELEASE;
			D01_state : in hex_char;
			D01_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			S64_state : in hex_char;
			S64_command : out routeCommands := RELEASE;
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
	signal ne991_used : std_logic := '0';
	signal ne991_state : nodeStates := FREE;
	signal ne991_lock : objectLock := RELEASED;
	signal D01_position : singleSwitchStates := NORMAL;
	signal D01_lock : objectLock := RELEASED;
	signal T02_aspectIn : signalStates := RED;
	signal T02_lock: objectLock := RELEASED;
	signal S64_aspectIn : signalStates := RED;
	signal S64_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne991_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne991)(2 to 3))));
	ne991_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne991)(0 to 1))));
	D01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D01_state)(2 to 3))));
	D01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D01_state)(0 to 1))));
	T02_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T02_state)(2 to 3))));
	T02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T02_state)(0 to 1))));
	S64_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S64_state)(2 to 3))));
	S64_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S64_state)(0 to 1))));
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
				if (ne991_lock = RELEASED) then
					ne991_command <= RESERVE;
				end if;
				if (ne991_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne991_lock = RESERVED) then
					ne991_command <= LOCK;
				end if;
				if (ne991_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D01_lock = RELEASED) then
					D01_command <= RESERVE;
				end if;
				if (D01_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D01_lock = RESERVED) then
					D01_command <= LOCK;
				end if;
				if (D01_lock = LOCKED)then
					ne991_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T02_lock = RELEASED and S64_lock = RELEASED) then
					T02_command <= RESERVE;
					S64_command <= LOCK;
				end if;
				if (T02_lock = RESERVED and S64_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne991_used = '0' and ne991_state = OCCUPIED) then 
					ne991_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D01_command <= RELEASE;
				ne991_command <= RELEASE;
				T02_command <= RELEASE;
				S64_command <= RELEASE;
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