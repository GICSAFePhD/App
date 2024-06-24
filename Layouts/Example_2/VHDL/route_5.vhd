--  route_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R6 ['Sw01', 'Sw02'] 
--YYY  R6 [] 
	entity route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne18 : in hex_char;
			ne18_command : out routeCommands := RELEASE;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			C17_state : in hex_char;
			C17_command : out routeCommands := RELEASE;
			S15_state : in hex_char;
			S15_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_5;
architecture Behavioral of route_5 is
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
	signal ne18_used , ne16_used : std_logic := '0';
	signal ne18_state : nodeStates := FREE;
	signal ne18_lock : objectLock := RELEASED;
	signal ne16_state : nodeStates := FREE;
	signal ne16_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	signal C17_aspectIn : signalStates := RED;
	signal C17_lock: objectLock := RELEASED;
	signal S15_aspectIn : signalStates := RED;
	signal S15_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne18_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne18)(2 to 3))));
	ne18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne18)(0 to 1))));
	ne16_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne16)(2 to 3))));
	ne16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne16)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	C17_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C17_state)(2 to 3))));
	C17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C17_state)(0 to 1))));
	S15_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S15_state)(2 to 3))));
	S15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S15_state)(0 to 1))));
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
				if ((ne18_lock = RELEASED and ne16_lock = RELEASED) and (ne16_state = FREE)) then
					ne18_command <= RESERVE;
					ne16_command <= RESERVE;
				end if;
				if (ne18_lock = RESERVED and ne16_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne18_lock = RESERVED and ne16_lock = RESERVED) and (ne16_state = FREE)) then
					ne18_command <= LOCK;
					ne16_command <= LOCK;
				end if;
				if (ne18_lock = LOCKED and ne16_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw01_lock = RELEASED and Sw02_lock = RELEASED) then
					Sw01_command <= RESERVE;
					Sw02_command <= RESERVE;
				end if;
				if (Sw01_lock = RESERVED and Sw02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw01_lock = RESERVED and Sw02_lock = RESERVED) then
					Sw01_command <= LOCK;
					Sw02_command <= LOCK;
				end if;
				if (Sw01_lock = LOCKED and Sw02_lock = LOCKED)then
					ne18_used <= '0';
					ne16_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (C17_lock = RELEASED and S15_lock = RELEASED) then
					C17_command <= RESERVE;
					S15_command <= LOCK;
				end if;
				if (C17_lock = RESERVED and S15_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne18_used = '0' and ne18_state = OCCUPIED) then 
					ne18_used <= '1';
				end if;
				if (ne18_used = '1' and ne18_state = FREE) then
					ne18_used <= '0';
					ne18_command <= RELEASE;
				end if;
					---
				if (ne18_lock = RELEASED and ne16_used = '0' and ne16_state = OCCUPIED) then 
					ne16_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw01_command <= RELEASE;
				Sw02_command <= RELEASE;
				ne18_command <= RELEASE;
				ne16_command <= RELEASE;
				C17_command <= RELEASE;
				S15_command <= RELEASE;
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