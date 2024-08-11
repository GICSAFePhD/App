--  route_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R12 ['D15'] 
--dw  R12 [] 
--sc  R12 [] 
--lc  R12 [] 
	entity route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne113 : in hex_char;
			ne113_command : out routeCommands := RELEASE;
			track_ne377 : in hex_char;
			ne377_command : out routeCommands := RELEASE;
			D15_state : in hex_char;
			D15_command : out routeCommands := RELEASE;
			T16_state : in hex_char;
			T16_command : out routeCommands := RELEASE;
			T03_state : in hex_char;
			T03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_11;
architecture Behavioral of route_11 is
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
	signal ne113_used , ne377_used : std_logic := '0';
	signal ne113_state : nodeStates := FREE;
	signal ne113_lock : objectLock := RELEASED;
	signal ne377_state : nodeStates := FREE;
	signal ne377_lock : objectLock := RELEASED;
	signal D15_position : singleSwitchStates := NORMAL;
	signal D15_lock : objectLock := RELEASED;
	signal T16_aspectIn : signalStates := RED;
	signal T16_lock: objectLock := RELEASED;
	signal T03_aspectIn : signalStates := RED;
	signal T03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne113_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne113)(2 to 3))));
	ne113_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne113)(0 to 1))));
	ne377_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne377)(2 to 3))));
	ne377_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne377)(0 to 1))));
	D15_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D15_state)(2 to 3))));
	D15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D15_state)(0 to 1))));
	T16_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T16_state)(2 to 3))));
	T16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T16_state)(0 to 1))));
	T03_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T03_state)(2 to 3))));
	T03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T03_state)(0 to 1))));
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
				if ((ne113_lock = RELEASED and ne377_lock = RELEASED) and (ne377_state = FREE)) then
					ne113_command <= RESERVE;
					ne377_command <= RESERVE;
				end if;
				if (ne113_lock = RESERVED and ne377_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne113_lock = RESERVED and ne377_lock = RESERVED) and (ne377_state = FREE)) then
					ne113_command <= LOCK;
					ne377_command <= LOCK;
				end if;
				if (ne113_lock = LOCKED and ne377_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D15_lock = RELEASED) then
					D15_command <= RESERVE;
				end if;
				if (D15_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D15_lock = RESERVED) then
					D15_command <= LOCK;
				end if;
				if (D15_lock = LOCKED)then
					ne113_used <= '0';
					ne377_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T16_lock = RELEASED and T03_lock = RELEASED) then
					T16_command <= RESERVE;
					T03_command <= LOCK;
				end if;
				if (T16_lock = RESERVED and T03_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne113_used = '0' and ne113_state = OCCUPIED) then 
					ne113_used <= '1';
				end if;
				if (ne113_used = '1' and ne113_state = FREE) then
					ne113_used <= '0';
					ne113_command <= RELEASE;
				end if;
					---
				if (ne113_lock = RELEASED and ne377_used = '0' and ne377_state = OCCUPIED) then 
					ne377_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				D15_command <= RELEASE;
				ne113_command <= RELEASE;
				ne377_command <= RELEASE;
				T16_command <= RELEASE;
				T03_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;