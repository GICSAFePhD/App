--  route_6.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R7 ['Sw02'] 
--YYY  R7 ['Lc01'] 
	entity route_6 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			track_ne18 : in hex_char;
			ne18_command : out routeCommands := RELEASE;
			Lc01_state : in hex_char;
			Lc01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			S18_state : in hex_char;
			S18_command : out routeCommands := RELEASE;
			P12_state : in hex_char;
			P12_command : out routeCommands := RELEASE;
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
	signal ne16_used , ne18_used : std_logic := '0';
	signal ne16_state : nodeStates := FREE;
	signal ne16_lock : objectLock := RELEASED;
	signal ne18_state : nodeStates := FREE;
	signal ne18_lock : objectLock := RELEASED;
	signal Lc01_position : levelCrossingStates := UP;
	signal Lc01_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	signal S18_aspectIn : signalStates := RED;
	signal S18_lock: objectLock := RELEASED;
	signal P12_aspectIn : signalStates := RED;
	signal P12_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne16_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne16)(2 to 3))));
	ne16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne16)(0 to 1))));
	ne18_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne18)(2 to 3))));
	ne18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne18)(0 to 1))));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	S18_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S18_state)(2 to 3))));
	S18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S18_state)(0 to 1))));
	P12_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P12_state)(2 to 3))));
	P12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P12_state)(0 to 1))));
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
				if ((ne16_lock = RELEASED and ne18_lock = RELEASED) and (ne18_state = FREE)) then
					ne16_command <= RESERVE;
					ne18_command <= RESERVE;
				end if;
				if (ne16_lock = RESERVED and ne18_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne16_lock = RESERVED and ne18_lock = RESERVED) and (ne18_state = FREE)) then
					ne16_command <= LOCK;
					ne18_command <= LOCK;
				end if;
				if (ne16_lock = LOCKED and ne18_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RELEASED and Sw02_lock = RELEASED) then
					Lc01_command <= RESERVE;
					Sw02_command <= RESERVE;
				end if;
				if (Lc01_lock = RESERVED and Sw02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RESERVED and Sw02_lock = RESERVED) then
					Lc01_command <= LOCK;
					Sw02_command <= LOCK;
				end if;
				if (Lc01_lock = LOCKED and Sw02_lock = LOCKED)then
					ne16_used <= '0';
					ne18_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S18_lock = RELEASED and P12_lock = RELEASED) then
					S18_command <= RESERVE;
					P12_command <= LOCK;
				end if;
				if (S18_lock = RESERVED and P12_lock = LOCKED) then
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
				if (ne16_lock = RELEASED and ne18_used = '0' and ne18_state = OCCUPIED) then 
					ne18_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc01_command <= RELEASE;
				Sw02_command <= RELEASE;
				ne16_command <= RELEASE;
				ne18_command <= RELEASE;
				S18_command <= RELEASE;
				P12_command <= RELEASE;
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