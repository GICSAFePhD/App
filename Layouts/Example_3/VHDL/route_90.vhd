--  route_90.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R91 ['Sw06'] 
--dw  R91 [] 
--sc  R91 ['Sw03'] 
--lc  R91 [] 
	entity route_90 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne52 : in hex_char;
			ne52_command : out routeCommands := RELEASE;
			track_ne77 : in hex_char;
			ne77_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			S146_state : in hex_char;
			S146_command : out routeCommands := RELEASE;
			B145_state : in hex_char;
			B145_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_90;
architecture Behavioral of route_90 is
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
	signal ne52_used , ne77_used : std_logic := '0';
	signal ne52_state : nodeStates := FREE;
	signal ne52_lock : objectLock := RELEASED;
	signal ne77_state : nodeStates := FREE;
	signal ne77_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal Sw03_position : scissorCrossingStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal S146_aspectIn : signalStates := RED;
	signal S146_lock: objectLock := RELEASED;
	signal B145_aspectIn : signalStates := RED;
	signal B145_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne52_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne52)(2 to 3))));
	ne52_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne52)(0 to 1))));
	ne77_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne77)(2 to 3))));
	ne77_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne77)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	Sw03_position <= scissorCrossingStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	S146_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S146_state)(2 to 3))));
	S146_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S146_state)(0 to 1))));
	B145_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B145_state)(2 to 3))));
	B145_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B145_state)(0 to 1))));
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
				if ((ne52_lock = RELEASED and ne77_lock = RELEASED) and (ne77_state = FREE)) then
					ne52_command <= RESERVE;
					ne77_command <= RESERVE;
				end if;
				if (ne52_lock = RESERVED and ne77_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne52_lock = RESERVED and ne77_lock = RESERVED) and (ne77_state = FREE)) then
					ne52_command <= LOCK;
					ne77_command <= LOCK;
				end if;
				if (ne52_lock = LOCKED and ne77_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw06_lock = RELEASED and Sw03_lock = RELEASED) then
					Sw06_command <= RESERVE;
					Sw03_command <= RESERVE;
				end if;
				if (Sw06_lock = RESERVED and Sw03_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw06_lock = RESERVED and Sw03_lock = RESERVED) then
					Sw06_command <= LOCK;
					Sw03_command <= LOCK;
				end if;
				if (Sw06_lock = LOCKED and Sw03_lock = LOCKED)then
					ne52_used <= '0';
					ne77_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S146_lock = RELEASED and B145_lock = RELEASED) then
					S146_command <= RESERVE;
					B145_command <= LOCK;
				end if;
				if (S146_lock = RESERVED and B145_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne52_used = '0' and ne52_state = OCCUPIED) then 
					ne52_used <= '1';
				end if;
				if (ne52_used = '1' and ne52_state = FREE) then
					ne52_used <= '0';
					ne52_command <= RELEASE;
				end if;
					---
				if (ne52_lock = RELEASED and ne77_used = '0' and ne77_state = OCCUPIED) then 
					ne77_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw06_command <= RELEASE;
				Sw03_command <= RELEASE;
				ne52_command <= RELEASE;
				ne77_command <= RELEASE;
				S146_command <= RELEASE;
				B145_command <= RELEASE;
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