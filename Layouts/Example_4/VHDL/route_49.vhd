--  route_49.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R50 ['D07', 'D16'] 
--dw  R50 [] 
--sc  R50 [] 
--lc  R50 [] 
	entity route_49 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne400 : in hex_char;
			ne400_command : out routeCommands := RELEASE;
			track_ne407 : in hex_char;
			ne407_command : out routeCommands := RELEASE;
			D07_state : in hex_char;
			D07_command : out routeCommands := RELEASE;
			D16_state : in hex_char;
			D16_command : out routeCommands := RELEASE;
			S74_state : in hex_char;
			S74_command : out routeCommands := RELEASE;
			S93_state : in hex_char;
			S93_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_49;
architecture Behavioral of route_49 is
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
	signal ne400_used , ne407_used : std_logic := '0';
	signal ne400_state : nodeStates := FREE;
	signal ne400_lock : objectLock := RELEASED;
	signal ne407_state : nodeStates := FREE;
	signal ne407_lock : objectLock := RELEASED;
	signal D07_position : singleSwitchStates := NORMAL;
	signal D07_lock : objectLock := RELEASED;
	signal D16_position : singleSwitchStates := NORMAL;
	signal D16_lock : objectLock := RELEASED;
	signal S74_aspectIn : signalStates := RED;
	signal S74_lock: objectLock := RELEASED;
	signal S93_aspectIn : signalStates := RED;
	signal S93_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne400_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne400)(2 to 3))));
	ne400_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne400)(0 to 1))));
	ne407_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne407)(2 to 3))));
	ne407_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne407)(0 to 1))));
	D07_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D07_state)(2 to 3))));
	D07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D07_state)(0 to 1))));
	D16_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D16_state)(2 to 3))));
	D16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D16_state)(0 to 1))));
	S74_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S74_state)(2 to 3))));
	S74_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S74_state)(0 to 1))));
	S93_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S93_state)(2 to 3))));
	S93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S93_state)(0 to 1))));
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
				if ((ne400_lock = RELEASED and ne407_lock = RELEASED) and (ne407_state = FREE)) then
					ne400_command <= RESERVE;
					ne407_command <= RESERVE;
				end if;
				if (ne400_lock = RESERVED and ne407_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne400_lock = RESERVED and ne407_lock = RESERVED) and (ne407_state = FREE)) then
					ne400_command <= LOCK;
					ne407_command <= LOCK;
				end if;
				if (ne400_lock = LOCKED and ne407_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D07_lock = RELEASED and D16_lock = RELEASED) then
					D07_command <= RESERVE;
					D16_command <= RESERVE;
				end if;
				if (D07_lock = RESERVED and D16_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D07_lock = RESERVED and D16_lock = RESERVED) then
					D07_command <= LOCK;
					D16_command <= LOCK;
				end if;
				if (D07_lock = LOCKED and D16_lock = LOCKED)then
					ne400_used <= '0';
					ne407_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S74_lock = RELEASED and S93_lock = RELEASED) then
					S74_command <= RESERVE;
					S93_command <= LOCK;
				end if;
				if (S74_lock = RESERVED and S93_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne400_used = '0' and ne400_state = OCCUPIED) then 
					ne400_used <= '1';
				end if;
				if (ne400_used = '1' and ne400_state = FREE) then
					ne400_used <= '0';
					ne400_command <= RELEASE;
				end if;
					---
				if (ne400_lock = RELEASED and ne407_used = '0' and ne407_state = OCCUPIED) then 
					ne407_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D07_command <= RELEASE;
				D16_command <= RELEASE;
				ne400_command <= RELEASE;
				ne407_command <= RELEASE;
				S74_command <= RELEASE;
				S93_command <= RELEASE;
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