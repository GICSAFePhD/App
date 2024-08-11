--  route_57.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R58 ['D10', 'D24'] 
--dw  R58 [] 
--sc  R58 [] 
--lc  R58 [] 
	entity route_57 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne910 : in hex_char;
			ne910_command : out routeCommands := RELEASE;
			track_ne135 : in hex_char;
			ne135_command : out routeCommands := RELEASE;
			D10_state : in hex_char;
			D10_command : out routeCommands := RELEASE;
			D24_state : in hex_char;
			D24_command : out routeCommands := RELEASE;
			S81_state : in hex_char;
			S81_command : out routeCommands := RELEASE;
			B80_state : in hex_char;
			B80_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_57;
architecture Behavioral of route_57 is
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
	signal ne910_used , ne135_used : std_logic := '0';
	signal ne910_state : nodeStates := FREE;
	signal ne910_lock : objectLock := RELEASED;
	signal ne135_state : nodeStates := FREE;
	signal ne135_lock : objectLock := RELEASED;
	signal D10_position : singleSwitchStates := NORMAL;
	signal D10_lock : objectLock := RELEASED;
	signal D24_position : singleSwitchStates := NORMAL;
	signal D24_lock : objectLock := RELEASED;
	signal S81_aspectIn : signalStates := RED;
	signal S81_lock: objectLock := RELEASED;
	signal B80_aspectIn : signalStates := RED;
	signal B80_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne910_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne910)(2 to 3))));
	ne910_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne910)(0 to 1))));
	ne135_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne135)(2 to 3))));
	ne135_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne135)(0 to 1))));
	D10_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D10_state)(2 to 3))));
	D10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D10_state)(0 to 1))));
	D24_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D24_state)(2 to 3))));
	D24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D24_state)(0 to 1))));
	S81_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S81_state)(2 to 3))));
	S81_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S81_state)(0 to 1))));
	B80_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B80_state)(2 to 3))));
	B80_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B80_state)(0 to 1))));
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
				if ((ne910_lock = RELEASED and ne135_lock = RELEASED) and (ne135_state = FREE)) then
					ne910_command <= RESERVE;
					ne135_command <= RESERVE;
				end if;
				if (ne910_lock = RESERVED and ne135_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne910_lock = RESERVED and ne135_lock = RESERVED) and (ne135_state = FREE)) then
					ne910_command <= LOCK;
					ne135_command <= LOCK;
				end if;
				if (ne910_lock = LOCKED and ne135_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D10_lock = RELEASED and D24_lock = RELEASED) then
					D10_command <= RESERVE;
					D24_command <= RESERVE;
				end if;
				if (D10_lock = RESERVED and D24_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D10_lock = RESERVED and D24_lock = RESERVED) then
					D10_command <= LOCK;
					D24_command <= LOCK;
				end if;
				if (D10_lock = LOCKED and D24_lock = LOCKED)then
					ne910_used <= '0';
					ne135_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S81_lock = RELEASED and B80_lock = RELEASED) then
					S81_command <= RESERVE;
					B80_command <= LOCK;
				end if;
				if (S81_lock = RESERVED and B80_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne910_used = '0' and ne910_state = OCCUPIED) then 
					ne910_used <= '1';
				end if;
				if (ne910_used = '1' and ne910_state = FREE) then
					ne910_used <= '0';
					ne910_command <= RELEASE;
				end if;
					---
				if (ne910_lock = RELEASED and ne135_used = '0' and ne135_state = OCCUPIED) then 
					ne135_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D10_command <= RELEASE;
				D24_command <= RELEASE;
				ne910_command <= RELEASE;
				ne135_command <= RELEASE;
				S81_command <= RELEASE;
				B80_command <= RELEASE;
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