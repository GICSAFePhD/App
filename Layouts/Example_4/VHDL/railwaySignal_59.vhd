--  railwaySignal_59.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_59 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R77_command : in routeCommands;
			R78_command : in routeCommands;
			R6_command : in routeCommands;
			R69_command : in routeCommands;
			--Ocupation level 0
			track_ne127 : in hex_char;
			correspondence_S117 : out hex_char;
			--Ocupation level 1
			track_ne135 : in hex_char;
			track_ne910 : in hex_char;
			track_ne101 : in hex_char;
			track_ne134 : in hex_char;
			correspondence_J43 : in hex_char;
			correspondence_T23 : in hex_char;
			D09_state : in hex_char;
			D10_state : in hex_char;
			D24_state : in hex_char;
			--Ocupation level 2
			track_ne100 : in hex_char;
			correspondence_X53 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_59;
architecture Behavioral of railwaySignal_59 is
	component flipFlop is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			Q : out std_logic := '0'
		);
	end component flipFlop;
	signal restart : std_logic := '1';
	signal Q : std_logic_vector(30 downto 0) := (others => '0');
	signal clock_in : std_logic_vector(30 downto 0) := (others => '0');
	signal timeout : std_logic := '0';
	signal commandState : routeCommands := RELEASE;
	signal lockStateIn : objectLock := RELEASED;
	signal lockStateOut : objectLock := RELEASED;
	signal aspectStateIn : signalStates := RED;
	signal aspectStateOut : signalStates := RED;
	signal correspondenceState : signalStates := RED;
	signal path : integer := 0;
	--Ocupation level 1
	signal ne135_state : nodeStates := FREE;
	signal ne135_lock : objectLock := RELEASED;
	signal ne910_state : nodeStates := FREE;
	signal ne910_lock : objectLock := RELEASED;
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal ne134_state : nodeStates := FREE;
	signal ne134_lock : objectLock := RELEASED;
	signal J43_aspect : signalStates;
	signal J43_lock : objectLock := RELEASED;
	signal T23_aspect : signalStates;
	signal T23_lock : objectLock := RELEASED;
	signal D09_position : singleSwitchStates := NORMAL;
	signal D10_position : singleSwitchStates := NORMAL;
	signal D24_position : singleSwitchStates := NORMAL;
	signal D09_lock : objectLock := RELEASED;
	signal D10_lock : objectLock := RELEASED;
	signal D24_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal X53_aspect : signalStates;
	signal X53_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S117 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne135_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne135)(2 to 3))));
	ne135_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne135)(0 to 1))));
	ne910_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne910)(2 to 3))));
	ne910_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne910)(0 to 1))));
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	ne134_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne134)(2 to 3))));
	ne134_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne134)(0 to 1))));
	J43_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J43)(2 to 3))));
	J43_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J43)(0 to 1))));
	T23_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T23)(2 to 3))));
	T23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T23)(0 to 1))));
	D09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D09_state)(2 to 3))));
	D10_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D10_state)(2 to 3))));
	D24_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D24_state)(2 to 3))));
	D09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D09_state)(0 to 1))));
	D10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D10_state)(0 to 1))));
	D24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D24_state)(0 to 1))));
	--Ocupation level 2
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	X53_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X53)(2 to 3))));
	X53_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X53)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R77_command,R78_command,R6_command,R69_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R77_command = RELEASE and R78_command = RELEASE and R6_command = RELEASE and R69_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R77_command = RESERVE or R78_command = RESERVE or R6_command = RESERVE or R69_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R77_command = LOCK or R78_command = LOCK or R6_command = LOCK or R69_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				lockStateOut <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lockStateOut <= RESERVED;
			when LOCK => -- DONT CHANGE
				lockStateOut <= LOCKED;
			when others =>
				lockStateOut <= LOCKED;
		end case;
	end process;

	process(commandState,D24_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D09_position = REVERSE and D10_position = REVERSE and D24_position = NORMAL) or (D24_position = REVERSE)) then
					if (D09_position = REVERSE and D10_position = REVERSE and D24_position = NORMAL) then
						path <= 1;
					end if;
					if (D24_position = REVERSE) then
						path <= 2;
					end if;
				else
					path <= 0;
				end if;
			when RESERVE =>
				path <= 3;
			when LOCK =>
				path <= 0;
			when others =>
				path <= 0;
		end case;
	end process;

	process(path,ne135_state,ne910_state,ne101_state,ne134_state,J43_aspect,T23_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne135_state = OCCUPIED or ne135_lock = LOCKED or ne910_state = OCCUPIED or ne910_lock = LOCKED or ne101_state = OCCUPIED or ne101_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J43_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J43_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J43_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J43_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne134_state = OCCUPIED or ne134_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T23_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T23_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T23_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T23_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				aspectStateOut <= GREEN;
			when others =>
				aspectStateOut <= RED;
		end case;
	end process;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "010100110111001001001110000000") then
			timeout <= '1';
		end if;
		if (restart = '1') then
			timeout <= '0';
		end if;
	end process;

	process(timeout,aspectStateOut,aspectStateIn)
	begin
		if(aspectStateOut = RED and aspectStateIn = RED) then
			correspondenceState <= RED;
			restart <= '1';
		end if;
		if(aspectStateOut = GREEN and aspectStateIn = GREEN) then
			correspondenceState <= GREEN;
			restart <= '1';
		end if;
		if(aspectStateOut = DOUBLE_YELLOW and aspectStateIn = DOUBLE_YELLOW) then
			correspondenceState <= DOUBLE_YELLOW;
			restart <= '1';
		end if;
		if(aspectStateOut = YELLOW and aspectStateIn = YELLOW) then
			correspondenceState <= YELLOW;
			restart <= '1';
		end if;
	end process;
end Behavioral;