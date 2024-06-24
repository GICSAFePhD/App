--  route_23.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R24 ['Sw31'] 
--YYY  R24 ['Lc10'] 
	entity route_23 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne46 : in hex_char;
			ne46_command : out routeCommands := RELEASE;
			Lc10_state : in hex_char;
			Lc10_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			S42_state : in hex_char;
			S42_command : out routeCommands := RELEASE;
			J16_state : in hex_char;
			J16_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_23;
architecture Behavioral of route_23 is
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
	signal ne3_used , ne46_used : std_logic := '0';
	signal ne3_state : nodeStates := FREE;
	signal ne3_lock : objectLock := RELEASED;
	signal ne46_state : nodeStates := FREE;
	signal ne46_lock : objectLock := RELEASED;
	signal Lc10_position : levelCrossingStates := UP;
	signal Lc10_lock : objectLock := RELEASED;
	signal Sw31_position : singleSwitchStates := NORMAL;
	signal Sw31_lock : objectLock := RELEASED;
	signal S42_aspectIn : signalStates := RED;
	signal S42_lock: objectLock := RELEASED;
	signal J16_aspectIn : signalStates := RED;
	signal J16_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne3_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne3)(2 to 3))));
	ne3_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne3)(0 to 1))));
	ne46_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne46)(2 to 3))));
	ne46_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne46)(0 to 1))));
	Lc10_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc10_state)(2 to 3))));
	Lc10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc10_state)(0 to 1))));
	Sw31_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw31_state)(2 to 3))));
	Sw31_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw31_state)(0 to 1))));
	S42_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S42_state)(2 to 3))));
	S42_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S42_state)(0 to 1))));
	J16_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J16_state)(2 to 3))));
	J16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J16_state)(0 to 1))));
	gen : for i in 0 to 31 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "011011111100001000111010101111110") then
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
				if ((ne3_lock = RELEASED and ne46_lock = RELEASED) and (ne46_state = FREE)) then
					ne3_command <= RESERVE;
					ne46_command <= RESERVE;
				end if;
				if (ne3_lock = RESERVED and ne46_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne3_lock = RESERVED and ne46_lock = RESERVED) and (ne46_state = FREE)) then
					ne3_command <= LOCK;
					ne46_command <= LOCK;
				end if;
				if (ne3_lock = LOCKED and ne46_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc10_lock = RELEASED and Sw31_lock = RELEASED) then
					Lc10_command <= RESERVE;
					Sw31_command <= RESERVE;
				end if;
				if (Lc10_lock = RESERVED and Sw31_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc10_lock = RESERVED and Sw31_lock = RESERVED) then
					Lc10_command <= LOCK;
					Sw31_command <= LOCK;
				end if;
				if (Lc10_lock = LOCKED and Sw31_lock = LOCKED)then
					ne3_used <= '0';
					ne46_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S42_lock = RELEASED and J16_lock = RELEASED) then
					S42_command <= RESERVE;
					J16_command <= LOCK;
				end if;
				if (S42_lock = RESERVED and J16_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne3_used = '0' and ne3_state = OCCUPIED) then 
					ne3_used <= '1';
				end if;
				if (ne3_used = '1' and ne3_state = FREE) then
					ne3_used <= '0';
					ne3_command <= RELEASE;
				end if;
					---
				if (ne3_lock = RELEASED and ne46_used = '0' and ne46_state = OCCUPIED) then 
					ne46_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc10_command <= RELEASE;
				Sw31_command <= RELEASE;
				ne3_command <= RELEASE;
				ne46_command <= RELEASE;
				S42_command <= RELEASE;
				J16_command <= RELEASE;
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