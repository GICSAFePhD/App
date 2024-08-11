--  route_15.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R16 ['D23', 'D24'] 
--dw  R16 [] 
--sc  R16 [] 
--lc  R16 [] 
	entity route_15 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne134 : in hex_char;
			ne134_command : out routeCommands := RELEASE;
			track_ne127 : in hex_char;
			ne127_command : out routeCommands := RELEASE;
			D23_state : in hex_char;
			D23_command : out routeCommands := RELEASE;
			D24_state : in hex_char;
			D24_command : out routeCommands := RELEASE;
			T24_state : in hex_char;
			T24_command : out routeCommands := RELEASE;
			S104_state : in hex_char;
			S104_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_15;
architecture Behavioral of route_15 is
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
	signal ne134_used , ne127_used : std_logic := '0';
	signal ne134_state : nodeStates := FREE;
	signal ne134_lock : objectLock := RELEASED;
	signal ne127_state : nodeStates := FREE;
	signal ne127_lock : objectLock := RELEASED;
	signal D23_position : singleSwitchStates := NORMAL;
	signal D23_lock : objectLock := RELEASED;
	signal D24_position : singleSwitchStates := NORMAL;
	signal D24_lock : objectLock := RELEASED;
	signal T24_aspectIn : signalStates := RED;
	signal T24_lock: objectLock := RELEASED;
	signal S104_aspectIn : signalStates := RED;
	signal S104_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne134_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne134)(2 to 3))));
	ne134_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne134)(0 to 1))));
	ne127_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne127)(2 to 3))));
	ne127_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne127)(0 to 1))));
	D23_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D23_state)(2 to 3))));
	D23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D23_state)(0 to 1))));
	D24_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D24_state)(2 to 3))));
	D24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D24_state)(0 to 1))));
	T24_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T24_state)(2 to 3))));
	T24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T24_state)(0 to 1))));
	S104_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S104_state)(2 to 3))));
	S104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S104_state)(0 to 1))));
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
				if ((ne134_lock = RELEASED and ne127_lock = RELEASED) and (ne127_state = FREE)) then
					ne134_command <= RESERVE;
					ne127_command <= RESERVE;
				end if;
				if (ne134_lock = RESERVED and ne127_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne134_lock = RESERVED and ne127_lock = RESERVED) and (ne127_state = FREE)) then
					ne134_command <= LOCK;
					ne127_command <= LOCK;
				end if;
				if (ne134_lock = LOCKED and ne127_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D23_lock = RELEASED and D24_lock = RELEASED) then
					D23_command <= RESERVE;
					D24_command <= RESERVE;
				end if;
				if (D23_lock = RESERVED and D24_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D23_lock = RESERVED and D24_lock = RESERVED) then
					D23_command <= LOCK;
					D24_command <= LOCK;
				end if;
				if (D23_lock = LOCKED and D24_lock = LOCKED)then
					ne134_used <= '0';
					ne127_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T24_lock = RELEASED and S104_lock = RELEASED) then
					T24_command <= RESERVE;
					S104_command <= LOCK;
				end if;
				if (T24_lock = RESERVED and S104_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne134_used = '0' and ne134_state = OCCUPIED) then 
					ne134_used <= '1';
				end if;
				if (ne134_used = '1' and ne134_state = FREE) then
					ne134_used <= '0';
					ne134_command <= RELEASE;
				end if;
					---
				if (ne134_lock = RELEASED and ne127_used = '0' and ne127_state = OCCUPIED) then 
					ne127_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D23_command <= RELEASE;
				D24_command <= RELEASE;
				ne134_command <= RELEASE;
				ne127_command <= RELEASE;
				T24_command <= RELEASE;
				S104_command <= RELEASE;
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