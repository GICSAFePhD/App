--  route_87.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R88 [] 
--dw  R88 [] 
--sc  R88 ['Sw03'] 
--lc  R88 [] 
	entity route_87 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne21 : in hex_char;
			ne21_command : out routeCommands := RELEASE;
			track_ne104 : in hex_char;
			ne104_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			S144_state : in hex_char;
			S144_command : out routeCommands := RELEASE;
			B143_state : in hex_char;
			B143_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_87;
architecture Behavioral of route_87 is
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
	signal ne21_used , ne104_used : std_logic := '0';
	signal ne21_state : nodeStates := FREE;
	signal ne21_lock : objectLock := RELEASED;
	signal ne104_state : nodeStates := FREE;
	signal ne104_lock : objectLock := RELEASED;
	signal Sw03_position : scissorCrossingStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal S144_aspectIn : signalStates := RED;
	signal S144_lock: objectLock := RELEASED;
	signal B143_aspectIn : signalStates := RED;
	signal B143_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne21_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne21)(2 to 3))));
	ne21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne21)(0 to 1))));
	ne104_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne104)(2 to 3))));
	ne104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne104)(0 to 1))));
	Sw03_position <= scissorCrossingStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	S144_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(S144_state)(2 to 3))));
	S144_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(S144_state)(0 to 1))));
	B143_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(B143_state)(2 to 3))));
	B143_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(B143_state)(0 to 1))));
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
				if ((ne21_lock = RELEASED and ne104_lock = RELEASED) and (ne104_state = FREE)) then
					ne21_command <= RESERVE;
					ne104_command <= RESERVE;
				end if;
				if (ne21_lock = RESERVED and ne104_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne21_lock = RESERVED and ne104_lock = RESERVED) and (ne104_state = FREE)) then
					ne21_command <= LOCK;
					ne104_command <= LOCK;
				end if;
				if (ne21_lock = LOCKED and ne104_lock = LOCKED)then
					restart <= '1';
					routeState <= RESERVING_INFRASTRUCTURE;
				end if;
			when RESERVING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw03_lock = RELEASED) then
					Sw03_command <= RESERVE;
				end if;
				if (Sw03_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_INFRASTRUCTURE;
				end if;
			when LOCKING_INFRASTRUCTURE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (Sw03_lock = RESERVED) then
					Sw03_command <= LOCK;
				end if;
				if (Sw03_lock = LOCKED)then
					ne21_used <= '0';
					ne104_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
				end if;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (S144_lock = RELEASED and B143_lock = RELEASED) then
					S144_command <= RESERVE;
					B143_command <= LOCK;
				end if;
				if (S144_lock = RESERVED and B143_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne21_used = '0' and ne21_state = OCCUPIED) then 
					ne21_used <= '1';
				end if;
				if (ne21_used = '1' and ne21_state = FREE) then
					ne21_used <= '0';
					ne21_command <= RELEASE;
				end if;
					---
				if (ne21_lock = RELEASED and ne104_used = '0' and ne104_state = OCCUPIED) then 
					ne104_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				Sw03_command <= RELEASE;
				ne21_command <= RELEASE;
				ne104_command <= RELEASE;
				S144_command <= RELEASE;
				B143_command <= RELEASE;
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