--  route_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R8 ['Sw02', 'Sw03'] 
--dw  R8 [] 
--sc  R8 [] 
--lc  R8 ['Lc01'] 
	entity route_7 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			track_ne17 : in hex_char;
			ne17_command : out routeCommands := RELEASE;
			track_ne20 : in hex_char;
			ne20_command : out routeCommands := RELEASE;
			Lc01_state : in hex_char;
			Lc01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			S18_state : in hex_char;
			S18_command : out routeCommands := RELEASE;
			L06_state : in hex_char;
			L06_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_7;
architecture Behavioral of route_7 is
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
	signal ne16_used , ne17_used , ne20_used : std_logic := '0';
	signal ne16_state : nodeStates := FREE;
	signal ne16_lock : objectLock := RELEASED;
	signal ne17_state : nodeStates := FREE;
	signal ne17_lock : objectLock := RELEASED;
	signal ne20_state : nodeStates := FREE;
	signal ne20_lock : objectLock := RELEASED;
	signal Lc01_position : levelCrossingStates := UP;
	signal Lc01_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal S18_aspectIn : signalStates := RED;
	signal S18_lock: objectLock := RELEASED;
	signal L06_aspectIn : signalStates := RED;
	signal L06_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne16_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne16)(2 to 3))));
	ne16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne16)(0 to 1))));
	ne17_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne17)(2 to 3))));
	ne17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne17)(0 to 1))));
	ne20_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne20)(2 to 3))));
	ne20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne20)(0 to 1))));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	S18_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S18_state)(2 to 3))));
	S18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S18_state)(0 to 1))));
	L06_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L06_state)(2 to 3))));
	L06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L06_state)(0 to 1))));
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
				if ((ne16_lock = RELEASED and ne17_lock = RELEASED and ne20_lock = RELEASED) and (ne17_state = FREE and ne20_state = FREE)) then
					ne16_command <= RESERVE;
					ne17_command <= RESERVE;
					ne20_command <= RESERVE;
				end if;
				if (ne16_lock = RESERVED and ne17_lock = RESERVED and ne20_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne16_lock = RESERVED and ne17_lock = RESERVED and ne20_lock = RESERVED) and (ne17_state = FREE and ne20_state = FREE)) then
					ne16_command <= LOCK;
					ne17_command <= LOCK;
					ne20_command <= LOCK;
				end if;
				if (ne16_lock = LOCKED and ne17_lock = LOCKED and ne20_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RELEASED and Sw02_lock = RELEASED and Sw03_lock = RELEASED) then
					Lc01_command <= RESERVE;
					Sw02_command <= RESERVE;
					Sw03_command <= RESERVE;
				end if;
				if (Lc01_lock = RESERVED and Sw02_lock = RESERVED and Sw03_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RESERVED and Sw02_lock = RESERVED and Sw03_lock = RESERVED) then
					Lc01_command <= LOCK;
					Sw02_command <= LOCK;
					Sw03_command <= LOCK;
				end if;
				if (Lc01_lock = LOCKED and Sw02_lock = LOCKED and Sw03_lock = LOCKED)then
					ne16_used <= '0';
					ne17_used <= '0';
					ne20_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S18_lock = RELEASED and L06_lock = RELEASED) then
					S18_command <= RESERVE;
					L06_command <= LOCK;
				end if;
				if (S18_lock = RESERVED and L06_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne16_used = '0' and ne16_state = OCCUPIED) then 
					ne16_used <= '1';
				end if;
				if (ne16_used = '1' and ne16_state = FREE) then
					ne16_used <= '0';
					ne16_command <= RELEASE;
				end if;
					---
				if (ne16_lock = RELEASED and ne17_used = '0' and ne17_state = OCCUPIED) then 
					ne17_used <= '1';
				end if;
				if (ne17_used = '1' and ne17_state = FREE) then
					ne17_used <= '0';
					ne17_command <= RELEASE;
				end if;
					---
				if (ne17_lock = RELEASED and ne20_used = '0' and ne20_state = OCCUPIED) then 
					ne20_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc01_command <= RELEASE;
				Sw02_command <= RELEASE;
				Sw03_command <= RELEASE;
				ne16_command <= RELEASE;
				ne17_command <= RELEASE;
				ne20_command <= RELEASE;
				S18_command <= RELEASE;
				L06_command <= RELEASE;
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