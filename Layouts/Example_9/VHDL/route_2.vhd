--  route_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--XXX  R3 ['Sw31', 'Sw33'] 
--YYY  R3 ['Lc11'] 
	entity route_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne49 : in hex_char;
			ne49_command : out routeCommands := RELEASE;
			Lc11_state : in hex_char;
			Lc11_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			J05_state : in hex_char;
			J05_command : out routeCommands := RELEASE;
			J11_state : in hex_char;
			J11_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_2;
architecture Behavioral of route_2 is
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
	signal ne49_used : std_logic := '0';
	signal ne49_state : nodeStates := FREE;
	signal ne49_lock : objectLock := RELEASED;
	signal Lc11_position : levelCrossingStates := UP;
	signal Lc11_lock : objectLock := RELEASED;
	signal Sw31_position : singleSwitchStates := NORMAL;
	signal Sw31_lock : objectLock := RELEASED;
	signal Sw33_position : singleSwitchStates := NORMAL;
	signal Sw33_lock : objectLock := RELEASED;
	signal J05_aspectIn : signalStates := RED;
	signal J05_lock: objectLock := RELEASED;
	signal J11_aspectIn : signalStates := RED;
	signal J11_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne49_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne49)(2 to 3))));
	ne49_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne49)(0 to 1))));
	Lc11_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc11_state)(2 to 3))));
	Lc11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc11_state)(0 to 1))));
	Sw31_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw31_state)(2 to 3))));
	Sw31_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw31_state)(0 to 1))));
	Sw33_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw33_state)(2 to 3))));
	Sw33_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw33_state)(0 to 1))));
	J05_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J05_state)(2 to 3))));
	J05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J05_state)(0 to 1))));
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
				if (ne49_lock = RELEASED) then
					ne49_command <= RESERVE;
				end if;
				if (ne49_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne49_lock = RESERVED) then
					ne49_command <= LOCK;
				end if;
				if (ne49_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc11_lock = RELEASED and Sw31_lock = RELEASED and Sw33_lock = RELEASED) then
					Lc11_command <= RESERVE;
					Sw31_command <= RESERVE;
					Sw33_command <= RESERVE;
				end if;
				if (Lc11_lock = RESERVED and Sw31_lock = RESERVED and Sw33_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Lc11_lock = RESERVED and Sw31_lock = RESERVED and Sw33_lock = RESERVED) then
					Lc11_command <= LOCK;
					Sw31_command <= LOCK;
					Sw33_command <= LOCK;
				end if;
				if (Lc11_lock = LOCKED and Sw31_lock = LOCKED and Sw33_lock = LOCKED)then
					ne49_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (J05_lock = RELEASED and J11_lock = RELEASED) then
					J05_command <= RESERVE;
					J11_command <= LOCK;
				end if;
				if (J05_lock = RESERVED and J11_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne49_used = '0' and ne49_state = OCCUPIED) then 
					ne49_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Lc11_command <= RELEASE;
				Sw31_command <= RELEASE;
				Sw33_command <= RELEASE;
				ne49_command <= RELEASE;
				J05_command <= RELEASE;
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