--  route_27.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
--sw  R28 [] 
--dw  R28 [] 
--sc  R28 [] 
--lc  R28 [] 
	entity route_27 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne24 : in hex_char;
			ne24_command : out routeCommands := RELEASE;
			track_ne64 : in hex_char;
			ne64_command : out routeCommands := RELEASE;
			track_ne103 : in hex_char;
			ne103_command : out routeCommands := RELEASE;
			track_ne67 : in hex_char;
			ne67_command : out routeCommands := RELEASE;
			P63_state : in hex_char;
			P63_command : out routeCommands := RELEASE;
			P64_state : in hex_char;
			P64_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end entity route_27;
architecture Behavioral of route_27 is
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
	signal ne24_used , ne64_used , ne103_used , ne67_used : std_logic := '0';
	signal ne24_state : nodeStates := FREE;
	signal ne24_lock : objectLock := RELEASED;
	signal ne64_state : nodeStates := FREE;
	signal ne64_lock : objectLock := RELEASED;
	signal ne103_state : nodeStates := FREE;
	signal ne103_lock : objectLock := RELEASED;
	signal ne67_state : nodeStates := FREE;
	signal ne67_lock : objectLock := RELEASED;
	signal P63_aspectIn : signalStates := RED;
	signal P63_lock: objectLock := RELEASED;
	signal P64_aspectIn : signalStates := RED;
	signal P64_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	routingIn <= routeStates'val(to_integer(unsigned(hex_to_slv(routeRequest))));
	routeExecute <= slv_to_hex(std_logic_vector(to_unsigned(routeStates'pos(routeState),4)));
	ne24_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne24)(2 to 3))));
	ne24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne24)(0 to 1))));
	ne64_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne64)(2 to 3))));
	ne64_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne64)(0 to 1))));
	ne103_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne103)(2 to 3))));
	ne103_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne103)(0 to 1))));
	ne67_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne67)(2 to 3))));
	ne67_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne67)(0 to 1))));
	P63_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P63_state)(2 to 3))));
	P63_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P63_state)(0 to 1))));
	P64_aspectIn <= signalStates'val(to_integer(unsigned(hex_to_slv(P64_state)(2 to 3))));
	P64_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(P64_state)(0 to 1))));
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
				if ((ne24_lock = RELEASED and ne64_lock = RELEASED and ne103_lock = RELEASED and ne67_lock = RELEASED) and (ne64_state = FREE and ne103_state = FREE and ne67_state = FREE)) then
					ne24_command <= RESERVE;
					ne64_command <= RESERVE;
					ne103_command <= RESERVE;
					ne67_command <= RESERVE;
				end if;
				if (ne24_lock = RESERVED and ne64_lock = RESERVED and ne103_lock = RESERVED and ne67_lock = RESERVED)then
					restart <= '1';
					routeState <= LOCKING_TRACKS;
				end if;
			when LOCKING_TRACKS =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if ((ne24_lock = RESERVED and ne64_lock = RESERVED and ne103_lock = RESERVED and ne67_lock = RESERVED) and (ne64_state = FREE and ne103_state = FREE and ne67_state = FREE)) then
					ne24_command <= LOCK;
					ne64_command <= LOCK;
					ne103_command <= LOCK;
					ne67_command <= LOCK;
				end if;
				if (ne24_lock = LOCKED and ne64_lock = LOCKED and ne103_lock = LOCKED and ne67_lock = LOCKED)then
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
					ne24_used <= '0';
					ne64_used <= '0';
					ne103_used <= '0';
					ne67_used <= '0';
					restart <= '1';
					routeState <= DRIVING_SIGNAL;
			when DRIVING_SIGNAL =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				if (P63_lock = RELEASED and P64_lock = RELEASED) then
					P63_command <= RESERVE;
					P64_command <= LOCK;
				end if;
				if (P63_lock = RESERVED and P64_lock = LOCKED) then
					restart <= '1';
					routeState <= SEQUENTIAL_RELEASE;
				end if;
			when SEQUENTIAL_RELEASE =>
				restart <= '0';
				if (routingIn = CANCEL_ROUTE or timeout ='1') then
					routeState <= CANCEL_ROUTE;
				end if;
				--- Sequential release
				if (ne24_used = '0' and ne24_state = OCCUPIED) then 
					ne24_used <= '1';
				end if;
				if (ne24_used = '1' and ne24_state = FREE) then
					ne24_used <= '0';
					ne24_command <= RELEASE;
				end if;
					---
				if (ne24_lock = RELEASED and ne64_used = '0' and ne64_state = OCCUPIED) then 
					ne64_used <= '1';
				end if;
				if (ne64_used = '1' and ne64_state = FREE) then
					ne64_used <= '0';
					ne64_command <= RELEASE;
				end if;
					---
				if (ne64_lock = RELEASED and ne103_used = '0' and ne103_state = OCCUPIED) then 
					ne103_used <= '1';
				end if;
				if (ne103_used = '1' and ne103_state = FREE) then
					ne103_used <= '0';
					ne103_command <= RELEASE;
				end if;
					---
				if (ne103_lock = RELEASED and ne67_used = '0' and ne67_state = OCCUPIED) then 
					ne67_used <= '1';
					--- Finish -> Release all
					restart <= '1';
					routeState <= RELEASING_INFRASTRUCTURE;
				end if;
			when RELEASING_INFRASTRUCTURE =>
				ne24_command <= RELEASE;
				ne64_command <= RELEASE;
				ne103_command <= RELEASE;
				ne67_command <= RELEASE;
				P63_command <= RELEASE;
				P64_command <= RELEASE;
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