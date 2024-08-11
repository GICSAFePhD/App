--  route_44.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R45 ['D04', 'Sw03'] 
--dw  R45 [] 
--sc  R45 [] 
--lc  R45 [] 
	entity route_44 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne295 : in hex_char;
			ne295_command : out routeCommands := RELEASE;
			track_ne297 : in hex_char;
			ne297_command : out routeCommands := RELEASE;
			D04_state : in hex_char;
			D04_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			C70_state : in hex_char;
			C70_command : out routeCommands := RELEASE;
			S126_state : in hex_char;
			S126_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_44;
architecture Behavioral of route_44 is
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
	signal ne295_used , ne297_used : std_logic := '0';
	signal ne295_state : nodeStates := FREE;
	signal ne295_lock : objectLock := RELEASED;
	signal ne297_state : nodeStates := FREE;
	signal ne297_lock : objectLock := RELEASED;
	signal D04_position : singleSwitchStates := NORMAL;
	signal D04_lock : objectLock := RELEASED;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal C70_aspectIn : signalStates := RED;
	signal C70_lock: objectLock := RELEASED;
	signal S126_aspectIn : signalStates := RED;
	signal S126_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne295_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne295)(2 to 3))));
	ne295_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne295)(0 to 1))));
	ne297_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne297)(2 to 3))));
	ne297_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne297)(0 to 1))));
	D04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D04_state)(2 to 3))));
	D04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D04_state)(0 to 1))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	C70_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C70_state)(2 to 3))));
	C70_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C70_state)(0 to 1))));
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
			when WAITING_COMMAND =>
				if (routingIn = ROUTE_REQUEST) then
					routeState <= RESERVING_TRACKS;
				end if;
			when RESERVING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne295_lock = RELEASED and ne297_lock = RELEASED) and (ne297_state = FREE)) then
					ne295_command <= RESERVE;
					ne297_command <= RESERVE;
				end if;
				if (ne295_lock = RESERVED and ne297_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne295_lock = RESERVED and ne297_lock = RESERVED) and (ne297_state = FREE)) then
					ne295_command <= LOCK;
					ne297_command <= LOCK;
				end if;
				if (ne295_lock = LOCKED and ne297_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D04_lock = RELEASED and Sw03_lock = RELEASED) then
					D04_command <= RESERVE;
					Sw03_command <= RESERVE;
				end if;
				if (D04_lock = RESERVED and Sw03_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D04_lock = RESERVED and Sw03_lock = RESERVED) then
					D04_command <= LOCK;
					Sw03_command <= LOCK;
				end if;
				if (D04_lock = LOCKED and Sw03_lock = LOCKED)then
					ne295_used <= '0';
					ne297_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (C70_lock = RELEASED and S126_lock = RELEASED) then
					C70_command <= RESERVE;
					S126_command <= LOCK;
				end if;
				if (C70_lock = RESERVED and S126_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne295_used = '0' and ne295_state = OCCUPIED) then 
					ne295_used <= '1';
				end if;
				if (ne295_used = '1' and ne295_state = FREE) then
					ne295_used <= '0';
					ne295_command <= RELEASE;
				end if;
					---
				if (ne295_lock = RELEASED and ne297_used = '0' and ne297_state = OCCUPIED) then 
					ne297_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				D04_command <= RELEASE;
				Sw03_command <= RELEASE;
				ne295_command <= RELEASE;
				ne297_command <= RELEASE;
				C70_command <= RELEASE;
				S126_command <= RELEASE;
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