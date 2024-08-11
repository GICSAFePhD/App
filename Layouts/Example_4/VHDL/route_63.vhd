--  route_63.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R64 ['D08', 'D05', 'D16'] 
--dw  R64 [] 
--sc  R64 [] 
--lc  R64 ['Lc01'] 
	entity route_63 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne407 : in hex_char;
			ne407_command : out routeCommands := RELEASE;
			track_ne123 : in hex_char;
			ne123_command : out routeCommands := RELEASE;
			track_ne61 : in hex_char;
			ne61_command : out routeCommands := RELEASE;
			track_ne99 : in hex_char;
			ne99_command : out routeCommands := RELEASE;
			track_ne98 : in hex_char;
			ne98_command : out routeCommands := RELEASE;
			Lc01_state : in hex_char;
			Lc01_command : out routeCommands := RELEASE;
			D08_state : in hex_char;
			D08_command : out routeCommands := RELEASE;
			D05_state : in hex_char;
			D05_command : out routeCommands := RELEASE;
			D16_state : in hex_char;
			D16_command : out routeCommands := RELEASE;
			S93_state : in hex_char;
			S93_command : out routeCommands := RELEASE;
			X51_state : in hex_char;
			X51_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_63;
architecture Behavioral of route_63 is
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
	signal ne407_used , ne123_used , ne61_used , ne99_used , ne98_used : std_logic := '0';
	signal ne407_state : nodeStates := FREE;
	signal ne407_lock : objectLock := RELEASED;
	signal ne123_state : nodeStates := FREE;
	signal ne123_lock : objectLock := RELEASED;
	signal ne61_state : nodeStates := FREE;
	signal ne61_lock : objectLock := RELEASED;
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal ne98_state : nodeStates := FREE;
	signal ne98_lock : objectLock := RELEASED;
	signal Lc01_position : levelCrossingStates := UP;
	signal Lc01_lock : objectLock := RELEASED;
	signal D08_position : singleSwitchStates := NORMAL;
	signal D08_lock : objectLock := RELEASED;
	signal D05_position : singleSwitchStates := NORMAL;
	signal D05_lock : objectLock := RELEASED;
	signal D16_position : singleSwitchStates := NORMAL;
	signal D16_lock : objectLock := RELEASED;
	signal S93_aspectIn : signalStates := RED;
	signal S93_lock: objectLock := RELEASED;
	signal X51_aspectIn : signalStates := RED;
	signal X51_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne407_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne407)(2 to 3))));
	ne407_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne407)(0 to 1))));
	ne123_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne123)(2 to 3))));
	ne123_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne123)(0 to 1))));
	ne61_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne61)(2 to 3))));
	ne61_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne61)(0 to 1))));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne98_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne98)(0 to 1))));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	D08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D08_state)(2 to 3))));
	D08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D08_state)(0 to 1))));
	D05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D05_state)(2 to 3))));
	D05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D05_state)(0 to 1))));
	D16_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D16_state)(2 to 3))));
	D16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D16_state)(0 to 1))));
	S93_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S93_state)(2 to 3))));
	S93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S93_state)(0 to 1))));
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
				if ((ne407_lock = RELEASED and ne123_lock = RELEASED and ne61_lock = RELEASED and ne99_lock = RELEASED and ne98_lock = RELEASED) and (ne123_state = FREE and ne61_state = FREE and ne99_state = FREE and ne98_state = FREE)) then
					ne407_command <= RESERVE;
					ne123_command <= RESERVE;
					ne61_command <= RESERVE;
					ne99_command <= RESERVE;
					ne98_command <= RESERVE;
				end if;
				if (ne407_lock = RESERVED and ne123_lock = RESERVED and ne61_lock = RESERVED and ne99_lock = RESERVED and ne98_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne407_lock = RESERVED and ne123_lock = RESERVED and ne61_lock = RESERVED and ne99_lock = RESERVED and ne98_lock = RESERVED) and (ne123_state = FREE and ne61_state = FREE and ne99_state = FREE and ne98_state = FREE)) then
					ne407_command <= LOCK;
					ne123_command <= LOCK;
					ne61_command <= LOCK;
					ne99_command <= LOCK;
					ne98_command <= LOCK;
				end if;
				if (ne407_lock = LOCKED and ne123_lock = LOCKED and ne61_lock = LOCKED and ne99_lock = LOCKED and ne98_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RELEASED and D08_lock = RELEASED and D05_lock = RELEASED and D16_lock = RELEASED) then
					Lc01_command <= RESERVE;
					D08_command <= RESERVE;
					D05_command <= RESERVE;
					D16_command <= RESERVE;
				end if;
				if (Lc01_lock = RESERVED and D08_lock = RESERVED and D05_lock = RESERVED and D16_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc01_lock = RESERVED and D08_lock = RESERVED and D05_lock = RESERVED and D16_lock = RESERVED) then
					Lc01_command <= LOCK;
					D08_command <= LOCK;
					D05_command <= LOCK;
					D16_command <= LOCK;
				end if;
				if (Lc01_lock = LOCKED and D08_lock = LOCKED and D05_lock = LOCKED and D16_lock = LOCKED)then
					ne407_used <= '0';
					ne123_used <= '0';
					ne61_used <= '0';
					ne99_used <= '0';
					ne98_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S93_lock = RELEASED and X51_lock = RELEASED) then
					S93_command <= RESERVE;
					X51_command <= LOCK;
				end if;
				if (S93_lock = RESERVED and X51_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne407_used = '0' and ne407_state = OCCUPIED) then 
					ne407_used <= '1';
				end if;
				if (ne407_used = '1' and ne407_state = FREE) then
					ne407_used <= '0';
					ne407_command <= RELEASE;
				end if;
					---
				if (ne407_lock = RELEASED and ne123_used = '0' and ne123_state = OCCUPIED) then 
					ne123_used <= '1';
				end if;
				if (ne123_used = '1' and ne123_state = FREE) then
					ne123_used <= '0';
					ne123_command <= RELEASE;
				end if;
					---
				if (ne123_lock = RELEASED and ne61_used = '0' and ne61_state = OCCUPIED) then 
					ne61_used <= '1';
				end if;
				if (ne61_used = '1' and ne61_state = FREE) then
					ne61_used <= '0';
					ne61_command <= RELEASE;
				end if;
					---
				if (ne61_lock = RELEASED and ne99_used = '0' and ne99_state = OCCUPIED) then 
					ne99_used <= '1';
				end if;
				if (ne99_used = '1' and ne99_state = FREE) then
					ne99_used <= '0';
					ne99_command <= RELEASE;
				end if;
					---
				if (ne99_lock = RELEASED and ne98_used = '0' and ne98_state = OCCUPIED) then 
					ne98_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc01_command <= RELEASE;
				D08_command <= RELEASE;
				D05_command <= RELEASE;
				D16_command <= RELEASE;
				ne407_command <= RELEASE;
				ne123_command <= RELEASE;
				ne61_command <= RELEASE;
				ne99_command <= RELEASE;
				ne98_command <= RELEASE;
				S93_command <= RELEASE;
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