--  route_40.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R41 ['69W03'] 
--dw  R41 [] 
--sc  R41 [] 
--lc  R41 ['Lc01'] 
	entity route_40 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne17 : in hex_char;
			ne17_command : out routeCommands := RELEASE;
			track_ne59 : in hex_char;
			ne59_command : out routeCommands := RELEASE;
			track_ne95 : in hex_char;
			ne95_command : out routeCommands := RELEASE;
			Lc01_state : in hex_char;
			Lc01_command : out routeCommands := RELEASE;
			s69W03_state : in hex_char;
			s69W03_command : out routeCommands := RELEASE;
			C82_state : in hex_char;
			C82_command : out routeCommands := RELEASE;
			X51_state : in hex_char;
			X51_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_40;
architecture Behavioral of route_40 is
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
	signal ne17_used , ne59_used , ne95_used : std_logic := '0';
	signal ne17_state : nodeStates := FREE;
	signal ne17_lock : objectLock := RELEASED;
	signal ne59_state : nodeStates := FREE;
	signal ne59_lock : objectLock := RELEASED;
	signal ne95_state : nodeStates := FREE;
	signal ne95_lock : objectLock := RELEASED;
	signal Lc01_position : levelCrossingStates := UP;
	signal Lc01_lock : objectLock := RELEASED;
	signal s69W03_position : singleSwitchStates := NORMAL;
	signal s69W03_lock : objectLock := RELEASED;
	signal C82_aspectIn : signalStates := RED;
	signal C82_lock: objectLock := RELEASED;
	signal X51_aspectIn : signalStates := RED;
	signal X51_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne17_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne17)(2 to 3))));
	ne17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne17)(0 to 1))));
	ne59_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne59)(2 to 3))));
	ne59_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne59)(0 to 1))));
	ne95_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne95)(2 to 3))));
	ne95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne95)(0 to 1))));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	s69W03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s69W03_state)(2 to 3))));
	s69W03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s69W03_state)(0 to 1))));
	C82_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C82_state)(2 to 3))));
	C82_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C82_state)(0 to 1))));
	X51_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X51_state)(2 to 3))));
	X51_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X51_state)(0 to 1))));
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
				if ((ne17_lock = RELEASED and ne59_lock = RELEASED and ne95_lock = RELEASED) and (ne59_state = FREE and ne95_state = FREE)) then
					ne17_command <= RESERVE;
					ne59_command <= RESERVE;
					ne95_command <= RESERVE;
				end if;
				if (ne17_lock = RESERVED and ne59_lock = RESERVED and ne95_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne17_lock = RESERVED and ne59_lock = RESERVED and ne95_lock = RESERVED) and (ne59_state = FREE and ne95_state = FREE)) then
					ne17_command <= LOCK;
					ne59_command <= LOCK;
					ne95_command <= LOCK;
				end if;
				if (ne17_lock = LOCKED and ne59_lock = LOCKED and ne95_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RELEASED and s69W03_lock = RELEASED) then
					Lc01_command <= RESERVE;
					s69W03_command <= RESERVE;
				end if;
				if (Lc01_lock = RESERVED and s69W03_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RESERVED and s69W03_lock = RESERVED) then
					Lc01_command <= LOCK;
					s69W03_command <= LOCK;
				end if;
				if (Lc01_lock = LOCKED and s69W03_lock = LOCKED)then
					ne17_used <= '0';
					ne59_used <= '0';
					ne95_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (C82_lock = RELEASED and X51_lock = RELEASED) then
					C82_command <= RESERVE;
					X51_command <= LOCK;
				end if;
				if (C82_lock = RESERVED and X51_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne17_used = '0' and ne17_state = OCCUPIED) then 
					ne17_used <= '1';
				end if;
				if (ne17_used = '1' and ne17_state = FREE) then
					ne17_used <= '0';
					ne17_command <= RELEASE;
				end if;
					---
				if (ne17_lock = RELEASED and ne59_used = '0' and ne59_state = OCCUPIED) then 
					ne59_used <= '1';
				end if;
				if (ne59_used = '1' and ne59_state = FREE) then
					ne59_used <= '0';
					ne59_command <= RELEASE;
				end if;
					---
				if (ne59_lock = RELEASED and ne95_used = '0' and ne95_state = OCCUPIED) then 
					ne95_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc01_command <= RELEASE;
				s69W03_command <= RELEASE;
				ne17_command <= RELEASE;
				ne59_command <= RELEASE;
				ne95_command <= RELEASE;
				C82_command <= RELEASE;
				X51_command <= RELEASE;
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