--  route_38.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R39 ['D01', 'D03'] 
--dw  R39 [] 
--sc  R39 [] 
--lc  R39 [] 
	entity route_38 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne991 : in hex_char;
			ne991_command : out routeCommands := RELEASE;
			track_ne288 : in hex_char;
			ne288_command : out routeCommands := RELEASE;
			D01_state : in hex_char;
			D01_command : out routeCommands := RELEASE;
			D03_state : in hex_char;
			D03_command : out routeCommands := RELEASE;
			S64_state : in hex_char;
			S64_command : out routeCommands := RELEASE;
			S69_state : in hex_char;
			S69_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_38;
architecture Behavioral of route_38 is
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
	signal ne991_used , ne288_used : std_logic := '0';
	signal ne991_state : nodeStates := FREE;
	signal ne991_lock : objectLock := RELEASED;
	signal ne288_state : nodeStates := FREE;
	signal ne288_lock : objectLock := RELEASED;
	signal D01_position : singleSwitchStates := NORMAL;
	signal D01_lock : objectLock := RELEASED;
	signal D03_position : singleSwitchStates := NORMAL;
	signal D03_lock : objectLock := RELEASED;
	signal S64_aspectIn : signalStates := RED;
	signal S64_lock: objectLock := RELEASED;
	signal S69_aspectIn : signalStates := RED;
	signal S69_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne991_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne991)(2 to 3))));
	ne991_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne991)(0 to 1))));
	ne288_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne288)(2 to 3))));
	ne288_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne288)(0 to 1))));
	D01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D01_state)(2 to 3))));
	D01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D01_state)(0 to 1))));
	D03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D03_state)(2 to 3))));
	D03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D03_state)(0 to 1))));
	S64_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S64_state)(2 to 3))));
	S64_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S64_state)(0 to 1))));
	S69_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S69_state)(2 to 3))));
	S69_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S69_state)(0 to 1))));
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
				if ((ne991_lock = RELEASED and ne288_lock = RELEASED) and (ne288_state = FREE)) then
					ne991_command <= RESERVE;
					ne288_command <= RESERVE;
				end if;
				if (ne991_lock = RESERVED and ne288_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne991_lock = RESERVED and ne288_lock = RESERVED) and (ne288_state = FREE)) then
					ne991_command <= LOCK;
					ne288_command <= LOCK;
				end if;
				if (ne991_lock = LOCKED and ne288_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D01_lock = RELEASED and D03_lock = RELEASED) then
					D01_command <= RESERVE;
					D03_command <= RESERVE;
				end if;
				if (D01_lock = RESERVED and D03_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (D01_lock = RESERVED and D03_lock = RESERVED) then
					D01_command <= LOCK;
					D03_command <= LOCK;
				end if;
				if (D01_lock = LOCKED and D03_lock = LOCKED)then
					ne991_used <= '0';
					ne288_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S64_lock = RELEASED and S69_lock = RELEASED) then
					S64_command <= RESERVE;
					S69_command <= LOCK;
				end if;
				if (S64_lock = RESERVED and S69_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne991_used = '0' and ne991_state = OCCUPIED) then 
					ne991_used <= '1';
				end if;
				if (ne991_used = '1' and ne991_state = FREE) then
					ne991_used <= '0';
					ne991_command <= RELEASE;
				end if;
					---
				if (ne991_lock = RELEASED and ne288_used = '0' and ne288_state = OCCUPIED) then 
					ne288_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				D01_command <= RELEASE;
				D03_command <= RELEASE;
				ne991_command <= RELEASE;
				ne288_command <= RELEASE;
				S64_command <= RELEASE;
				S69_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;