--  route_72.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R73 ['Sw08', 'Sw09', 'Sw12', 'Sw11', 'Sw13'] 
--dw  R73 [] 
--sc  R73 [] 
--lc  R73 [] 
	entity route_72 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne86 : in hex_char;
			ne86_command : out routeCommands := RELEASE;
			track_ne87 : in hex_char;
			ne87_command : out routeCommands := RELEASE;
			track_ne91 : in hex_char;
			ne91_command : out routeCommands := RELEASE;
			track_ne30 : in hex_char;
			ne30_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			Sw09_state : in hex_char;
			Sw09_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			Sw11_state : in hex_char;
			Sw11_command : out routeCommands := RELEASE;
			Sw13_state : in hex_char;
			Sw13_command : out routeCommands := RELEASE;
			S119_state : in hex_char;
			S119_command : out routeCommands := RELEASE;
			S97_state : in hex_char;
			S97_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_72;
architecture Behavioral of route_72 is
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
	signal ne86_used , ne87_used , ne91_used , ne30_used : std_logic := '0';
	signal ne86_state : nodeStates := FREE;
	signal ne86_lock : objectLock := RELEASED;
	signal ne87_state : nodeStates := FREE;
	signal ne87_lock : objectLock := RELEASED;
	signal ne91_state : nodeStates := FREE;
	signal ne91_lock : objectLock := RELEASED;
	signal ne30_state : nodeStates := FREE;
	signal ne30_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
	signal Sw09_position : singleSwitchStates := NORMAL;
	signal Sw09_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal Sw11_position : singleSwitchStates := NORMAL;
	signal Sw11_lock : objectLock := RELEASED;
	signal Sw13_position : singleSwitchStates := NORMAL;
	signal Sw13_lock : objectLock := RELEASED;
	signal S119_aspectIn : signalStates := RED;
	signal S119_lock: objectLock := RELEASED;
	signal S97_aspectIn : signalStates := RED;
	signal S97_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne86_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne86)(2 to 3))));
	ne86_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne86)(0 to 1))));
	ne87_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne87)(2 to 3))));
	ne87_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne87)(0 to 1))));
	ne91_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne91)(2 to 3))));
	ne91_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne91)(0 to 1))));
	ne30_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne30)(2 to 3))));
	ne30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne30)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	Sw09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw09_state)(2 to 3))));
	Sw09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw09_state)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	Sw11_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw11_state)(2 to 3))));
	Sw11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw11_state)(0 to 1))));
	Sw13_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw13_state)(2 to 3))));
	Sw13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw13_state)(0 to 1))));
	S119_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S119_state)(2 to 3))));
	S119_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S119_state)(0 to 1))));
	S97_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S97_state)(2 to 3))));
	S97_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S97_state)(0 to 1))));
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
				if ((ne86_lock = RELEASED and ne87_lock = RELEASED and ne91_lock = RELEASED and ne30_lock = RELEASED) and (ne87_state = FREE and ne91_state = FREE and ne30_state = FREE)) then
					ne86_command <= RESERVE;
					ne87_command <= RESERVE;
					ne91_command <= RESERVE;
					ne30_command <= RESERVE;
				end if;
				if (ne86_lock = RESERVED and ne87_lock = RESERVED and ne91_lock = RESERVED and ne30_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne86_lock = RESERVED and ne87_lock = RESERVED and ne91_lock = RESERVED and ne30_lock = RESERVED) and (ne87_state = FREE and ne91_state = FREE and ne30_state = FREE)) then
					ne86_command <= LOCK;
					ne87_command <= LOCK;
					ne91_command <= LOCK;
					ne30_command <= LOCK;
				end if;
				if (ne86_lock = LOCKED and ne87_lock = LOCKED and ne91_lock = LOCKED and ne30_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw08_lock = RELEASED and Sw09_lock = RELEASED and Sw12_lock = RELEASED and Sw11_lock = RELEASED and Sw13_lock = RELEASED) then
					Sw08_command <= RESERVE;
					Sw09_command <= RESERVE;
					Sw12_command <= RESERVE;
					Sw11_command <= RESERVE;
					Sw13_command <= RESERVE;
				end if;
				if (Sw08_lock = RESERVED and Sw09_lock = RESERVED and Sw12_lock = RESERVED and Sw11_lock = RESERVED and Sw13_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw08_lock = RESERVED and Sw09_lock = RESERVED and Sw12_lock = RESERVED and Sw11_lock = RESERVED and Sw13_lock = RESERVED) then
					Sw08_command <= LOCK;
					Sw09_command <= LOCK;
					Sw12_command <= LOCK;
					Sw11_command <= LOCK;
					Sw13_command <= LOCK;
				end if;
				if (Sw08_lock = LOCKED and Sw09_lock = LOCKED and Sw12_lock = LOCKED and Sw11_lock = LOCKED and Sw13_lock = LOCKED)then
					ne86_used <= '0';
					ne87_used <= '0';
					ne91_used <= '0';
					ne30_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S119_lock = RELEASED and S97_lock = RELEASED) then
					S119_command <= RESERVE;
					S97_command <= LOCK;
				end if;
				if (S119_lock = RESERVED and S97_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne86_used = '0' and ne86_state = OCCUPIED) then 
					ne86_used <= '1';
				end if;
				if (ne86_used = '1' and ne86_state = FREE) then
					ne86_used <= '0';
					ne86_command <= RELEASE;
				end if;
					---
				if (ne86_lock = RELEASED and ne87_used = '0' and ne87_state = OCCUPIED) then 
					ne87_used <= '1';
				end if;
				if (ne87_used = '1' and ne87_state = FREE) then
					ne87_used <= '0';
					ne87_command <= RELEASE;
				end if;
					---
				if (ne87_lock = RELEASED and ne91_used = '0' and ne91_state = OCCUPIED) then 
					ne91_used <= '1';
				end if;
				if (ne91_used = '1' and ne91_state = FREE) then
					ne91_used <= '0';
					ne91_command <= RELEASE;
				end if;
					---
				if (ne91_lock = RELEASED and ne30_used = '0' and ne30_state = OCCUPIED) then 
					ne30_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				Sw08_command <= RELEASE;
				Sw09_command <= RELEASE;
				Sw12_command <= RELEASE;
				Sw11_command <= RELEASE;
				Sw13_command <= RELEASE;
				ne86_command <= RELEASE;
				ne87_command <= RELEASE;
				ne91_command <= RELEASE;
				ne30_command <= RELEASE;
				S119_command <= RELEASE;
				S97_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;