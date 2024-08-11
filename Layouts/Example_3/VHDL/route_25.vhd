--  route_25.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R26 ['68W02'] 
--dw  R26 [] 
--sc  R26 [] 
--lc  R26 ['Lc01'] 
	entity route_25 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne95 : in hex_char;
			ne95_command : out routeCommands := RELEASE;
			track_ne9 : in hex_char;
			ne9_command : out routeCommands := RELEASE;
			Lc01_state : in hex_char;
			Lc01_command : out routeCommands := RELEASE;
			s68W02_state : in hex_char;
			s68W02_command : out routeCommands := RELEASE;
			X51_state : in hex_char;
			X51_command : out routeCommands := RELEASE;
			S80_state : in hex_char;
			S80_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_25;
architecture Behavioral of route_25 is
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
	signal ne95_used , ne9_used : std_logic := '0';
	signal ne95_state : nodeStates := FREE;
	signal ne95_lock : objectLock := RELEASED;
	signal ne9_state : nodeStates := FREE;
	signal ne9_lock : objectLock := RELEASED;
	signal Lc01_position : levelCrossingStates := UP;
	signal Lc01_lock : objectLock := RELEASED;
	signal s68W02_position : singleSwitchStates := NORMAL;
	signal s68W02_lock : objectLock := RELEASED;
	signal X51_aspectIn : signalStates := RED;
	signal X51_lock: objectLock := RELEASED;
	signal S80_aspectIn : signalStates := RED;
	signal S80_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne95_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne95)(2 to 3))));
	ne95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne95)(0 to 1))));
	ne9_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne9)(2 to 3))));
	ne9_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne9)(0 to 1))));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	s68W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s68W02_state)(2 to 3))));
	s68W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s68W02_state)(0 to 1))));
	X51_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X51_state)(2 to 3))));
	X51_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X51_state)(0 to 1))));
	S80_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S80_state)(2 to 3))));
	S80_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S80_state)(0 to 1))));
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
				if ((ne95_lock = RELEASED and ne9_lock = RELEASED) and (ne9_state = FREE)) then
					ne95_command <= RESERVE;
					ne9_command <= RESERVE;
				end if;
				if (ne95_lock = RESERVED and ne9_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne95_lock = RESERVED and ne9_lock = RESERVED) and (ne9_state = FREE)) then
					ne95_command <= LOCK;
					ne9_command <= LOCK;
				end if;
				if (ne95_lock = LOCKED and ne9_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RELEASED and s68W02_lock = RELEASED) then
					Lc01_command <= RESERVE;
					s68W02_command <= RESERVE;
				end if;
				if (Lc01_lock = RESERVED and s68W02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RESERVED and s68W02_lock = RESERVED) then
					Lc01_command <= LOCK;
					s68W02_command <= LOCK;
				end if;
				if (Lc01_lock = LOCKED and s68W02_lock = LOCKED)then
					ne95_used <= '0';
					ne9_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (X51_lock = RELEASED and S80_lock = RELEASED) then
					X51_command <= RESERVE;
					S80_command <= LOCK;
				end if;
				if (X51_lock = RESERVED and S80_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne95_used = '0' and ne95_state = OCCUPIED) then 
					ne95_used <= '1';
				end if;
				if (ne95_used = '1' and ne95_state = FREE) then
					ne95_used <= '0';
					ne95_command <= RELEASE;
				end if;
					---
				if (ne95_lock = RELEASED and ne9_used = '0' and ne9_state = OCCUPIED) then 
					ne9_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc01_command <= RELEASE;
				s68W02_command <= RELEASE;
				ne95_command <= RELEASE;
				ne9_command <= RELEASE;
				X51_command <= RELEASE;
				S80_command <= RELEASE;
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