--  route_18.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R19 ['Sw06', 'Sw12', 'Sw13'] 
--YYY  R19 [] 
	entity route_18 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne8 : in hex_char;
			ne8_command : out routeCommands := RELEASE;
			track_ne24 : in hex_char;
			ne24_command : out routeCommands := RELEASE;
			track_ne12 : in hex_char;
			ne12_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			Sw13_state : in hex_char;
			Sw13_command : out routeCommands := RELEASE;
			S32_state : in hex_char;
			S32_command : out routeCommands := RELEASE;
			C25_state : in hex_char;
			C25_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_18;
architecture Behavioral of route_18 is
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
	signal ne8_used , ne24_used , ne12_used : std_logic := '0';
	signal ne8_state : nodeStates := FREE;
	signal ne8_lock : objectLock := RELEASED;
	signal ne24_state : nodeStates := FREE;
	signal ne24_lock : objectLock := RELEASED;
	signal ne12_state : nodeStates := FREE;
	signal ne12_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal Sw13_position : singleSwitchStates := NORMAL;
	signal Sw13_lock : objectLock := RELEASED;
	signal S32_aspectIn : signalStates := RED;
	signal S32_lock: objectLock := RELEASED;
	signal C25_aspectIn : signalStates := RED;
	signal C25_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne8_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne8)(2 to 3))));
	ne8_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne8)(0 to 1))));
	ne24_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne24)(2 to 3))));
	ne24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne24)(0 to 1))));
	ne12_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne12)(2 to 3))));
	ne12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne12)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	Sw13_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw13_state)(2 to 3))));
	Sw13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw13_state)(0 to 1))));
	S32_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S32_state)(2 to 3))));
	S32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S32_state)(0 to 1))));
	C25_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(C25_state)(2 to 3))));
	C25_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(C25_state)(0 to 1))));
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
				if ((ne8_lock = RELEASED and ne24_lock = RELEASED and ne12_lock = RELEASED) and (ne24_state = FREE and ne12_state = FREE)) then
					ne8_command <= RESERVE;
					ne24_command <= RESERVE;
					ne12_command <= RESERVE;
				end if;
				if (ne8_lock = RESERVED and ne24_lock = RESERVED and ne12_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne8_lock = RESERVED and ne24_lock = RESERVED and ne12_lock = RESERVED) and (ne24_state = FREE and ne12_state = FREE)) then
					ne8_command <= LOCK;
					ne24_command <= LOCK;
					ne12_command <= LOCK;
				end if;
				if (ne8_lock = LOCKED and ne24_lock = LOCKED and ne12_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw06_lock = RELEASED and Sw12_lock = RELEASED and Sw13_lock = RELEASED) then
					Sw06_command <= RESERVE;
					Sw12_command <= RESERVE;
					Sw13_command <= RESERVE;
				end if;
				if (Sw06_lock = RESERVED and Sw12_lock = RESERVED and Sw13_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw06_lock = RESERVED and Sw12_lock = RESERVED and Sw13_lock = RESERVED) then
					Sw06_command <= LOCK;
					Sw12_command <= LOCK;
					Sw13_command <= LOCK;
				end if;
				if (Sw06_lock = LOCKED and Sw12_lock = LOCKED and Sw13_lock = LOCKED)then
					ne8_used <= '0';
					ne24_used <= '0';
					ne12_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S32_lock = RELEASED and C25_lock = RELEASED) then
					S32_command <= RESERVE;
					C25_command <= LOCK;
				end if;
				if (S32_lock = RESERVED and C25_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne8_used = '0' and ne8_state = OCCUPIED) then 
					ne8_used <= '1';
				end if;
				if (ne8_used = '1' and ne8_state = FREE) then
					ne8_used <= '0';
					ne8_command <= RELEASE;
				end if;
					---
				if (ne8_lock = RELEASED and ne24_used = '0' and ne24_state = OCCUPIED) then 
					ne24_used <= '1';
				end if;
				if (ne24_used = '1' and ne24_state = FREE) then
					ne24_used <= '0';
					ne24_command <= RELEASE;
				end if;
					---
				if (ne24_lock = RELEASED and ne12_used = '0' and ne12_state = OCCUPIED) then 
					ne12_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw06_command <= RELEASE;
				Sw12_command <= RELEASE;
				Sw13_command <= RELEASE;
				ne8_command <= RELEASE;
				ne24_command <= RELEASE;
				ne12_command <= RELEASE;
				S32_command <= RELEASE;
				C25_command <= RELEASE;
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