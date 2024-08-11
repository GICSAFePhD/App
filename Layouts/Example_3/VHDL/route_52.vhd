--  route_52.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R53 ['Sw08', 'Sw12'] 
--dw  R53 [] 
--sc  R53 [] 
--lc  R53 [] 
	entity route_52 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne29 : in hex_char;
			ne29_command : out routeCommands := RELEASE;
			track_ne30 : in hex_char;
			ne30_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			B96_state : in hex_char;
			B96_command : out routeCommands := RELEASE;
			S122_state : in hex_char;
			S122_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_52;
architecture Behavioral of route_52 is
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
	signal ne29_used , ne30_used : std_logic := '0';
	signal ne29_state : nodeStates := FREE;
	signal ne29_lock : objectLock := RELEASED;
	signal ne30_state : nodeStates := FREE;
	signal ne30_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal B96_aspectIn : signalStates := RED;
	signal B96_lock: objectLock := RELEASED;
	signal S122_aspectIn : signalStates := RED;
	signal S122_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne29_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne29)(2 to 3))));
	ne29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne29)(0 to 1))));
	ne30_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne30)(2 to 3))));
	ne30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne30)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	B96_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B96_state)(2 to 3))));
	B96_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B96_state)(0 to 1))));
	S122_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S122_state)(2 to 3))));
	S122_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S122_state)(0 to 1))));
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
				if ((ne29_lock = RELEASED and ne30_lock = RELEASED) and (ne30_state = FREE)) then
					ne29_command <= RESERVE;
					ne30_command <= RESERVE;
				end if;
				if (ne29_lock = RESERVED and ne30_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne29_lock = RESERVED and ne30_lock = RESERVED) and (ne30_state = FREE)) then
					ne29_command <= LOCK;
					ne30_command <= LOCK;
				end if;
				if (ne29_lock = LOCKED and ne30_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw08_lock = RELEASED and Sw12_lock = RELEASED) then
					Sw08_command <= RESERVE;
					Sw12_command <= RESERVE;
				end if;
				if (Sw08_lock = RESERVED and Sw12_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw08_lock = RESERVED and Sw12_lock = RESERVED) then
					Sw08_command <= LOCK;
					Sw12_command <= LOCK;
				end if;
				if (Sw08_lock = LOCKED and Sw12_lock = LOCKED)then
					ne29_used <= '0';
					ne30_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (B96_lock = RELEASED and S122_lock = RELEASED) then
					B96_command <= RESERVE;
					S122_command <= LOCK;
				end if;
				if (B96_lock = RESERVED and S122_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne29_used = '0' and ne29_state = OCCUPIED) then 
					ne29_used <= '1';
				end if;
				if (ne29_used = '1' and ne29_state = FREE) then
					ne29_used <= '0';
					ne29_command <= RELEASE;
				end if;
					---
				if (ne29_lock = RELEASED and ne30_used = '0' and ne30_state = OCCUPIED) then 
					ne30_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw08_command <= RELEASE;
				Sw12_command <= RELEASE;
				ne29_command <= RELEASE;
				ne30_command <= RELEASE;
				B96_command <= RELEASE;
				S122_command <= RELEASE;
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