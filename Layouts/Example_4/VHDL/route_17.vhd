--  route_17.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R18 [] 
--dw  R18 [] 
--sc  R18 [] 
--lc  R18 [] 
	entity route_17 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne98 : in hex_char;
			ne98_command : out routeCommands := RELEASE;
			L30_state : in hex_char;
			L30_command : out routeCommands := RELEASE;
			X50_state : in hex_char;
			X50_command : out routeCommands := RELEASE;
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
	signal ne98_used : std_logic := '0';
	signal ne98_state : nodeStates := FREE;
	signal ne98_lock : objectLock := RELEASED;
	signal L30_aspectIn : signalStates := RED;
	signal L30_lock: objectLock := RELEASED;
	signal X50_aspectIn : signalStates := RED;
	signal X50_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne98_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne98)(0 to 1))));
	L30_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(L30_state)(2 to 3))));
	L30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(L30_state)(0 to 1))));
	X50_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(X50_state)(2 to 3))));
	X50_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(X50_state)(0 to 1))));
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
				if (ne98_lock = RELEASED) then
					ne98_command <= RESERVE;
				end if;
				if (ne98_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (ne98_lock = RESERVED) then
					ne98_command <= LOCK;
				end if;
				if (ne98_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					restart <= '1';
				routeState <= LOCKING_INFRASTRUCTURE;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
					ne98_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (L30_lock = RELEASED and X50_lock = RELEASED) then
					L30_command <= RESERVE;
					X50_command <= LOCK;
				end if;
				if (L30_lock = RESERVED and X50_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne98_used = '0' and ne98_state = OCCUPIED) then 
					ne98_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				ne98_command <= RELEASE;
				L30_command <= RELEASE;
				X50_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;