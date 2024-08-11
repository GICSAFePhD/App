--  route_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R4 [] 
--dw  R4 [] 
--sc  R4 [] 
--lc  R4 [] 
	entity route_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne22 : in hex_char;
			ne22_command : out routeCommands := RELEASE;
			J11_state : in hex_char;
			J11_command : out routeCommands := RELEASE;
			L09_state : in hex_char;
			L09_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_3;
architecture Behavioral of route_3 is
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
	signal ne22_used : std_logic := '0';
	signal ne22_state : nodeStates := FREE;
	signal ne22_lock : objectLock := RELEASED;
	signal J11_aspectIn : signalStates := RED;
	signal J11_lock: objectLock := RELEASED;
	signal L09_aspectIn : signalStates := RED;
	signal L09_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne22_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne22)(2 to 3))));
	ne22_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne22)(0 to 1))));
	J11_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(J11_state)(2 to 3))));
	J11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(J11_state)(0 to 1))));
	L09_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L09_state)(2 to 3))));
	L09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L09_state)(0 to 1))));
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
				if (ne22_lock = RELEASED) then
					ne22_command <= RESERVE;
				end if;
				if (ne22_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne22_lock = RESERVED) then
					ne22_command <= LOCK;
				end if;
				if (ne22_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					restart <= '1';
				routeState <= LOCKING_INFRASTRUCTURE;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					ne22_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (J11_lock = RELEASED and L09_lock = RELEASED) then
					J11_command <= RESERVE;
					L09_command <= LOCK;
				end if;
				if (J11_lock = RESERVED and L09_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne22_used = '0' and ne22_state = OCCUPIED) then 
					ne22_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne22_command <= RELEASE;
				J11_command <= RELEASE;
				L09_command <= RELEASE;
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