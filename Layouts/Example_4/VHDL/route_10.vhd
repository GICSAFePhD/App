--  route_10.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R11 ['D04', 'Sw03', 'Sw02'] 
--dw  R11 [] 
--sc  R11 [] 
--lc  R11 [] 
	entity route_10 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne104 : in hex_char;
			ne104_command : out routeCommands := RELEASE;
			track_ne384 : in hex_char;
			ne384_command : out routeCommands := RELEASE;
			track_ne297 : in hex_char;
			ne297_command : out routeCommands := RELEASE;
			D04_state : in hex_char;
			D04_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			T14_state : in hex_char;
			T14_command : out routeCommands := RELEASE;
			S126_state : in hex_char;
			S126_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_10;
architecture Behavioral of route_10 is
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
	signal ne104_used , ne384_used , ne297_used : std_logic := '0';
	signal ne104_state : nodeStates := FREE;
	signal ne104_lock : objectLock := RELEASED;
	signal ne384_state : nodeStates := FREE;
	signal ne384_lock : objectLock := RELEASED;
	signal ne297_state : nodeStates := FREE;
	signal ne297_lock : objectLock := RELEASED;
	signal D04_position : singleSwitchStates := NORMAL;
	signal D04_lock : objectLock := RELEASED;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	signal T14_aspectIn : signalStates := RED;
	signal T14_lock: objectLock := RELEASED;
	signal S126_aspectIn : signalStates := RED;
	signal S126_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne104_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne104)(2 to 3))));
	ne104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne104)(0 to 1))));
	ne384_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne384)(2 to 3))));
	ne384_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne384)(0 to 1))));
	ne297_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne297)(2 to 3))));
	ne297_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne297)(0 to 1))));
	D04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D04_state)(2 to 3))));
	D04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D04_state)(0 to 1))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	T14_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(T14_state)(2 to 3))));
	T14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(T14_state)(0 to 1))));
	S126_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S126_state)(2 to 3))));
	S126_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S126_state)(0 to 1))));
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
				if ((ne104_lock = RELEASED and ne384_lock = RELEASED and ne297_lock = RELEASED) and (ne384_state = FREE and ne297_state = FREE)) then
					ne104_command <= RESERVE;
					ne384_command <= RESERVE;
					ne297_command <= RESERVE;
				end if;
				if (ne104_lock = RESERVED and ne384_lock = RESERVED and ne297_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne104_lock = RESERVED and ne384_lock = RESERVED and ne297_lock = RESERVED) and (ne384_state = FREE and ne297_state = FREE)) then
					ne104_command <= LOCK;
					ne384_command <= LOCK;
					ne297_command <= LOCK;
				end if;
				if (ne104_lock = LOCKED and ne384_lock = LOCKED and ne297_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D04_lock = RELEASED and Sw03_lock = RELEASED and Sw02_lock = RELEASED) then
					D04_command <= RESERVE;
					Sw03_command <= RESERVE;
					Sw02_command <= RESERVE;
				end if;
				if (D04_lock = RESERVED and Sw03_lock = RESERVED and Sw02_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D04_lock = RESERVED and Sw03_lock = RESERVED and Sw02_lock = RESERVED) then
					D04_command <= LOCK;
					Sw03_command <= LOCK;
					Sw02_command <= LOCK;
				end if;
				if (D04_lock = LOCKED and Sw03_lock = LOCKED and Sw02_lock = LOCKED)then
					ne104_used <= '0';
					ne384_used <= '0';
					ne297_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (T14_lock = RELEASED and S126_lock = RELEASED) then
					T14_command <= RESERVE;
					S126_command <= LOCK;
				end if;
				if (T14_lock = RESERVED and S126_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne104_used = '0' and ne104_state = OCCUPIED) then 
					ne104_used <= '1';
				end if;
				if (ne104_used = '1' and ne104_state = FREE) then
					ne104_used <= '0';
					ne104_command <= RELEASE;
				end if;
					---
				if (ne104_lock = RELEASED and ne384_used = '0' and ne384_state = OCCUPIED) then 
					ne384_used <= '1';
				end if;
				if (ne384_used = '1' and ne384_state = FREE) then
					ne384_used <= '0';
					ne384_command <= RELEASE;
				end if;
					---
				if (ne384_lock = RELEASED and ne297_used = '0' and ne297_state = OCCUPIED) then 
					ne297_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				D04_command <= RELEASE;
				Sw03_command <= RELEASE;
				Sw02_command <= RELEASE;
				ne104_command <= RELEASE;
				ne384_command <= RELEASE;
				ne297_command <= RELEASE;
				T14_command <= RELEASE;
				S126_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;