--  route_6.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R7 ['Sw18', 'Sw14'] 
--YYY  R7 [] 
	entity route_6 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			track_ne31 : in hex_char;
			ne31_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw14_state : in hex_char;
			Sw14_command : out routeCommands := RELEASE;
			S14_state : in hex_char;
			S14_command : out routeCommands := RELEASE;
			T03_state : in hex_char;
			T03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_6;
architecture Behavioral of route_6 is
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
	signal ne1_used , ne40_used , ne31_used : std_logic := '0';
	signal ne1_state : nodeStates := FREE;
	signal ne1_lock : objectLock := RELEASED;
	signal ne40_state : nodeStates := FREE;
	signal ne40_lock : objectLock := RELEASED;
	signal ne31_state : nodeStates := FREE;
	signal ne31_lock : objectLock := RELEASED;
	signal Sw18_position : singleSwitchStates := NORMAL;
	signal Sw18_lock : objectLock := RELEASED;
	signal Sw14_position : singleSwitchStates := NORMAL;
	signal Sw14_lock : objectLock := RELEASED;
	signal S14_aspectIn : signalStates := RED;
	signal S14_lock: objectLock := RELEASED;
	signal T03_aspectIn : signalStates := RED;
	signal T03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne1_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne1)(2 to 3))));
	ne1_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne1)(0 to 1))));
	ne40_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne40)(2 to 3))));
	ne40_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne40)(0 to 1))));
	ne31_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne31)(2 to 3))));
	ne31_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne31)(0 to 1))));
	Sw18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw18_state)(2 to 3))));
	Sw18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw18_state)(0 to 1))));
	Sw14_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw14_state)(2 to 3))));
	Sw14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw14_state)(0 to 1))));
	S14_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S14_state)(2 to 3))));
	S14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S14_state)(0 to 1))));
	T03_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T03_state)(2 to 3))));
	T03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T03_state)(0 to 1))));
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
				if ((ne1_lock = RELEASED and ne40_lock = RELEASED and ne31_lock = RELEASED) and (ne40_state = FREE and ne31_state = FREE)) then
					ne1_command <= RESERVE;
					ne40_command <= RESERVE;
					ne31_command <= RESERVE;
				end if;
				if (ne1_lock = RESERVED and ne40_lock = RESERVED and ne31_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne1_lock = RESERVED and ne40_lock = RESERVED and ne31_lock = RESERVED) and (ne40_state = FREE and ne31_state = FREE)) then
					ne1_command <= LOCK;
					ne40_command <= LOCK;
					ne31_command <= LOCK;
				end if;
				if (ne1_lock = LOCKED and ne40_lock = LOCKED and ne31_lock = LOCKED)then
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
					ne40_used <= '0';
					ne31_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S14_lock = RELEASED and T03_lock = RELEASED) then
					S14_command <= RESERVE;
					T03_command <= LOCK;
				end if;
				if (S14_lock = RESERVED and T03_lock = LOCKED) then
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
				end if;
				if (ne1_used = '1' and ne1_state = FREE) then
					ne1_used <= '0';
					ne1_command <= RELEASE;
				end if;
					---
				if (ne1_lock = RELEASED and ne40_used = '0' and ne40_state = OCCUPIED) then 
					ne40_used <= '1';
				end if;
				if (ne40_used = '1' and ne40_state = FREE) then
					ne40_used <= '0';
					ne40_command <= RELEASE;
				end if;
					---
				if (ne40_lock = RELEASED and ne31_used = '0' and ne31_state = OCCUPIED) then 
					ne31_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw18_command <= RELEASE;
				Sw14_command <= RELEASE;
				ne1_command <= RELEASE;
				ne40_command <= RELEASE;
				ne31_command <= RELEASE;
				S14_command <= RELEASE;
				T03_command <= RELEASE;
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