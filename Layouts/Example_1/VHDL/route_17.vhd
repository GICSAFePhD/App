--  route_17.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R18 ['Sw12'] 
--YYY  R18 [] 
	entity route_17 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne8 : in hex_char;
			ne8_command : out routeCommands := RELEASE;
			track_ne22 : in hex_char;
			ne22_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			S32_state : in hex_char;
			S32_command : out routeCommands := RELEASE;
			J11_state : in hex_char;
			J11_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_17;
architecture Behavioral of route_17 is
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
	signal ne8_used , ne22_used : std_logic := '0';
	signal ne8_state : nodeStates := FREE;
	signal ne8_lock : objectLock := RELEASED;
	signal ne22_state : nodeStates := FREE;
	signal ne22_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal S32_aspectIn : signalStates := RED;
	signal S32_lock: objectLock := RELEASED;
	signal J11_aspectIn : signalStates := RED;
	signal J11_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne8_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne8)(2 to 3))));
	ne8_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne8)(0 to 1))));
	ne22_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne22)(2 to 3))));
	ne22_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne22)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	S32_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S32_state)(2 to 3))));
	S32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S32_state)(0 to 1))));
	J11_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J11_state)(2 to 3))));
	J11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J11_state)(0 to 1))));
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
				if ((ne8_lock = RELEASED and ne22_lock = RELEASED) and (ne22_state = FREE)) then
					ne8_command <= RESERVE;
					ne22_command <= RESERVE;
				end if;
				if (ne8_lock = RESERVED and ne22_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne8_lock = RESERVED and ne22_lock = RESERVED) and (ne22_state = FREE)) then
					ne8_command <= LOCK;
					ne22_command <= LOCK;
				end if;
				if (ne8_lock = LOCKED and ne22_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw12_lock = RELEASED) then
					Sw12_command <= RESERVE;
				end if;
				if (Sw12_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw12_lock = RESERVED) then
					Sw12_command <= LOCK;
				end if;
				if (Sw12_lock = LOCKED)then
					ne8_used <= '0';
					ne22_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S32_lock = RELEASED and J11_lock = RELEASED) then
					S32_command <= RESERVE;
					J11_command <= LOCK;
				end if;
				if (S32_lock = RESERVED and J11_lock = LOCKED) then
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
				if (ne8_lock = RELEASED and ne22_used = '0' and ne22_state = OCCUPIED) then 
					ne22_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw12_command <= RELEASE;
				ne8_command <= RELEASE;
				ne22_command <= RELEASE;
				S32_command <= RELEASE;
				J11_command <= RELEASE;
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