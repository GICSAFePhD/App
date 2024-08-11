--  route_53.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R54 ['D08', 'D07', 'D16'] 
--dw  R54 [] 
--sc  R54 [] 
--lc  R54 [] 
	entity route_53 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne61 : in hex_char;
			ne61_command : out routeCommands := RELEASE;
			track_ne123 : in hex_char;
			ne123_command : out routeCommands := RELEASE;
			D08_state : in hex_char;
			D08_command : out routeCommands := RELEASE;
			D07_state : in hex_char;
			D07_command : out routeCommands := RELEASE;
			D16_state : in hex_char;
			D16_command : out routeCommands := RELEASE;
			S78_state : in hex_char;
			S78_command : out routeCommands := RELEASE;
			B77_state : in hex_char;
			B77_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_53;
architecture Behavioral of route_53 is
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
	signal ne61_used , ne123_used : std_logic := '0';
	signal ne61_state : nodeStates := FREE;
	signal ne61_lock : objectLock := RELEASED;
	signal ne123_state : nodeStates := FREE;
	signal ne123_lock : objectLock := RELEASED;
	signal D08_position : singleSwitchStates := NORMAL;
	signal D08_lock : objectLock := RELEASED;
	signal D07_position : singleSwitchStates := NORMAL;
	signal D07_lock : objectLock := RELEASED;
	signal D16_position : singleSwitchStates := NORMAL;
	signal D16_lock : objectLock := RELEASED;
	signal S78_aspectIn : signalStates := RED;
	signal S78_lock: objectLock := RELEASED;
	signal B77_aspectIn : signalStates := RED;
	signal B77_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne61_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne61)(2 to 3))));
	ne61_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne61)(0 to 1))));
	ne123_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne123)(2 to 3))));
	ne123_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne123)(0 to 1))));
	D08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D08_state)(2 to 3))));
	D08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D08_state)(0 to 1))));
	D07_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D07_state)(2 to 3))));
	D07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D07_state)(0 to 1))));
	D16_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D16_state)(2 to 3))));
	D16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D16_state)(0 to 1))));
	S78_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S78_state)(2 to 3))));
	S78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S78_state)(0 to 1))));
	B77_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B77_state)(2 to 3))));
	B77_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B77_state)(0 to 1))));
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

				if (routingIn = ROUTE_REQUEST) then
					routeState <= RESERVING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne61_lock = RELEASED and ne123_lock = RELEASED) and (ne123_state = FREE)) then
					ne61_command <= RESERVE;
					ne123_command <= RESERVE;
				end if;
				if (ne61_lock = RESERVED and ne123_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne61_lock = RESERVED and ne123_lock = RESERVED) and (ne123_state = FREE)) then
					ne61_command <= LOCK;
					ne123_command <= LOCK;
				end if;
				if (ne61_lock = LOCKED and ne123_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D08_lock = RELEASED and D07_lock = RELEASED and D16_lock = RELEASED) then
					D08_command <= RESERVE;
					D07_command <= RESERVE;
					D16_command <= RESERVE;
				end if;
				if (D08_lock = RESERVED and D07_lock = RESERVED and D16_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D08_lock = RESERVED and D07_lock = RESERVED and D16_lock = RESERVED) then
					D08_command <= LOCK;
					D07_command <= LOCK;
					D16_command <= LOCK;
				end if;
				if (D08_lock = LOCKED and D07_lock = LOCKED and D16_lock = LOCKED)then
					ne61_used <= '0';
					ne123_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S78_lock = RELEASED and B77_lock = RELEASED) then
					S78_command <= RESERVE;
					B77_command <= LOCK;
				end if;
				if (S78_lock = RESERVED and B77_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne61_used = '0' and ne61_state = OCCUPIED) then 
					ne61_used <= '1';
				end if;
				if (ne61_used = '1' and ne61_state = FREE) then
					ne61_used <= '0';
					ne61_command <= RELEASE;
				end if;
					---
				if (ne61_lock = RELEASED and ne123_used = '0' and ne123_state = OCCUPIED) then 
					ne123_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				D08_command <= RELEASE;
				D07_command <= RELEASE;
				D16_command <= RELEASE;
				ne61_command <= RELEASE;
				ne123_command <= RELEASE;
				S78_command <= RELEASE;
				B77_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;