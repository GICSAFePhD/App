--  route_81.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R82 [] 
--dw  R82 ['Sw07'] 
--sc  R82 [] 
--lc  R82 [] 
	entity route_81 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne94 : in hex_char;
			ne94_command : out routeCommands := RELEASE;
			track_ne77 : in hex_char;
			ne77_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			S135_state : in hex_char;
			S135_command : out routeCommands := RELEASE;
			B133_state : in hex_char;
			B133_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_81;
architecture Behavioral of route_81 is
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
	signal ne94_used , ne77_used : std_logic := '0';
	signal ne94_state : nodeStates := FREE;
	signal ne94_lock : objectLock := RELEASED;
	signal ne77_state : nodeStates := FREE;
	signal ne77_lock : objectLock := RELEASED;
	signal Sw07_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw07_lock : objectLock := RELEASED;
	signal S135_aspectIn : signalStates := RED;
	signal S135_lock: objectLock := RELEASED;
	signal B133_aspectIn : signalStates := RED;
	signal B133_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne94_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne94)(2 to 3))));
	ne94_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne94)(0 to 1))));
	ne77_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne77)(2 to 3))));
	ne77_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne77)(0 to 1))));
	Sw07_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw07_state)(2 to 3))));
	Sw07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw07_state)(0 to 1))));
	S135_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S135_state)(2 to 3))));
	S135_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S135_state)(0 to 1))));
	B133_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B133_state)(2 to 3))));
	B133_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B133_state)(0 to 1))));
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
				if ((ne94_lock = RELEASED and ne77_lock = RELEASED) and (ne77_state = FREE)) then
					ne94_command <= RESERVE;
					ne77_command <= RESERVE;
				end if;
				if (ne94_lock = RESERVED and ne77_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne94_lock = RESERVED and ne77_lock = RESERVED) and (ne77_state = FREE)) then
					ne94_command <= LOCK;
					ne77_command <= LOCK;
				end if;
				if (ne94_lock = LOCKED and ne77_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw07_lock = RELEASED) then
					Sw07_command <= RESERVE;
				end if;
				if (Sw07_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw07_lock = RESERVED) then
					Sw07_command <= LOCK;
				end if;
				if (Sw07_lock = LOCKED)then
					ne94_used <= '0';
					ne77_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S135_lock = RELEASED and B133_lock = RELEASED) then
					S135_command <= RESERVE;
					B133_command <= LOCK;
				end if;
				if (S135_lock = RESERVED and B133_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;

				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne94_used = '0' and ne94_state = OCCUPIED) then 
					ne94_used <= '1';
				end if;
				if (ne94_used = '1' and ne94_state = FREE) then
					ne94_used <= '0';
					ne94_command <= RELEASE;
				end if;
					---
				if (ne94_lock = RELEASED and ne77_used = '0' and ne77_state = OCCUPIED) then 
					ne77_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;

				Sw07_command <= RELEASE;
				ne94_command <= RELEASE;
				ne77_command <= RELEASE;
				S135_command <= RELEASE;
				B133_command <= RELEASE;
				restart <= '1';
				routeState <= WAITING_COMMAND;

				routeState <= RELEASING_INFRASTRUCTURE;

				routeState <= WAITING_COMMAND;
		end case;
	end if;
	end process;
end Behavioral;