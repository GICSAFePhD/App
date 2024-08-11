--  railwaySignal_27.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_27 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R83_command : in routeCommands;
			R84_command : in routeCommands;
			R13_command : in routeCommands;
			R48_command : in routeCommands;
			R52_command : in routeCommands;
			--Ocupation level 0
			track_ne400 : in hex_char;
			correspondence_S123 : out hex_char;
			--Ocupation level 1
			track_ne993 : in hex_char;
			track_ne994 : in hex_char;
			track_ne992 : in hex_char;
			correspondence_T25 : in hex_char;
			correspondence_J40 : in hex_char;
			Sw05_state : in hex_char;
			Sw01_state : in hex_char;
			--Ocupation level 2
			track_ne100 : in hex_char;
			correspondence_L31 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_27;
architecture Behavioral of railwaySignal_27 is
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
	signal ne993_state : nodeStates := FREE;
	signal ne993_lock : objectLock := RELEASED;
	signal ne994_state : nodeStates := FREE;
	signal ne994_lock : objectLock := RELEASED;
	signal ne992_state : nodeStates := FREE;
	signal ne992_lock : objectLock := RELEASED;
	signal T25_aspect : signalStates;
	signal T25_lock : objectLock := RELEASED;
	signal J40_aspect : signalStates;
	signal J40_lock : objectLock := RELEASED;
	signal Sw05_position : singleSwitchStates := NORMAL;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw05_lock : objectLock := RELEASED;
	signal Sw01_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal L31_aspect : signalStates;
	signal L31_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S123 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne993_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne993)(2 to 3))));
	ne993_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne993)(0 to 1))));
	ne994_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne994)(2 to 3))));
	ne994_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne994)(0 to 1))));
	ne992_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne992)(2 to 3))));
	ne992_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne992)(0 to 1))));
	T25_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T25)(2 to 3))));
	T25_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T25)(0 to 1))));
	J40_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J40)(2 to 3))));
	J40_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J40)(0 to 1))));
	Sw05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	--Ocupation level 2
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	L31_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L31)(2 to 3))));
	L31_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L31)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R83_command,R84_command,R13_command,R48_command,R52_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R83_command = RELEASE and R84_command = RELEASE and R13_command = RELEASE and R48_command = RELEASE and R52_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R83_command = RESERVE or R84_command = RESERVE or R13_command = RESERVE or R48_command = RESERVE or R52_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R83_command = LOCK or R84_command = LOCK or R13_command = LOCK or R48_command = LOCK or R52_command = LOCK) then
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

	process(commandState,Sw01_position,Sw05_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw05_position = NORMAL) or (Sw01_position = REVERSE and Sw05_position = REVERSE)) then
					if (Sw05_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw01_position = REVERSE and Sw05_position = REVERSE) then
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

	process(path,ne993_state,ne994_state,ne992_state,T25_aspect,J40_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne993_state = OCCUPIED or ne993_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T25_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T25_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T25_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T25_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne994_state = OCCUPIED or ne994_lock = LOCKED or ne992_state = OCCUPIED or ne992_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J40_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J40_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J40_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J40_aspect = GREEN) then
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