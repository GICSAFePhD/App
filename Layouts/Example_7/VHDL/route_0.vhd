--  route_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R1 ['Sw18', 'Sw14'] 
--dw  R1 [] 
--sc  R1 [] 
--lc  R1 [] 
	entity route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw14_state : in hex_char;
			Sw14_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			S14_state : in hex_char;
			S14_command : out routeCommands := RELEASE;
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
	signal ne1_used : std_logic := '0';
	signal ne1_state : nodeStates := FREE;
	signal ne1_lock : objectLock := RELEASED;
	signal Sw18_position : singleSwitchStates := NORMAL;
	signal Sw18_lock : objectLock := RELEASED;
	signal Sw14_position : singleSwitchStates := NORMAL;
	signal Sw14_lock : objectLock := RELEASED;
	signal T02_aspectIn : signalStates := RED;
	signal T02_lock: objectLock := RELEASED;
	signal S14_aspectIn : signalStates := RED;
	signal S14_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne1_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne1)(2 to 3))));
	ne1_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne1)(0 to 1))));
	Sw18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw18_state)(2 to 3))));
	Sw18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw18_state)(0 to 1))));
	Sw14_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw14_state)(2 to 3))));
	Sw14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw14_state)(0 to 1))));
	T02_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T02_state)(2 to 3))));
	T02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T02_state)(0 to 1))));
	S14_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S14_state)(2 to 3))));
	S14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S14_state)(0 to 1))));
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
				if (ne1_lock = RELEASED) then
					ne1_command <= RESERVE;
				end if;
				if (ne1_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne1_lock = RESERVED) then
					ne1_command <= LOCK;
				end if;
				if (ne1_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw18_lock = RELEASED and Sw14_lock = RELEASED) then
					Sw18_command <= RESERVE;
					Sw14_command <= RESERVE;
				end if;
				if (Sw18_lock = RESERVED and Sw14_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw18_lock = RESERVED and Sw14_lock = RESERVED) then
					Sw18_command <= LOCK;
					Sw14_command <= LOCK;
				end if;
				if (Sw18_lock = LOCKED and Sw14_lock = LOCKED)then
					ne1_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T02_lock = RELEASED and S14_lock = RELEASED) then
					T02_command <= RESERVE;
					S14_command <= LOCK;
				end if;
				if (T02_lock = RESERVED and S14_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne1_used = '0' and ne1_state = OCCUPIED) then 
					ne1_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw18_command <= RELEASE;
				Sw14_command <= RELEASE;
				ne1_command <= RELEASE;
				T02_command <= RELEASE;
				S14_command <= RELEASE;
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