--  railwaySignal_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R66_command : in routeCommands;
			R67_command : in routeCommands;
			R36_command : in routeCommands;
			--Ocupation level 0
			track_ne63 : in hex_char;
			correspondence_S95 : out hex_char;
			--Ocupation level 1
			track_ne65 : in hex_char;
			track_ne124 : in hex_char;
			track_ne421 : in hex_char;
			correspondence_C119 : in hex_char;
			correspondence_T05 : in hex_char;
			D18_state : in hex_char;
			D19_state : in hex_char;
			--Ocupation level 2
			track_ne992 : in hex_char;
			correspondence_J40 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_5;
architecture Behavioral of railwaySignal_5 is
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
	signal ne65_state : nodeStates := FREE;
	signal ne65_lock : objectLock := RELEASED;
	signal ne124_state : nodeStates := FREE;
	signal ne124_lock : objectLock := RELEASED;
	signal ne421_state : nodeStates := FREE;
	signal ne421_lock : objectLock := RELEASED;
	signal C119_aspect : signalStates;
	signal C119_lock : objectLock := RELEASED;
	signal T05_aspect : signalStates;
	signal T05_lock : objectLock := RELEASED;
	signal D18_position : singleSwitchStates := NORMAL;
	signal D19_position : singleSwitchStates := NORMAL;
	signal D18_lock : objectLock := RELEASED;
	signal D19_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne992_state : nodeStates := FREE;
	signal ne992_lock : objectLock := RELEASED;
	signal J40_aspect : signalStates;
	signal J40_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S95 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne65_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne65)(2 to 3))));
	ne65_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne65)(0 to 1))));
	ne124_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne124)(2 to 3))));
	ne124_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne124)(0 to 1))));
	ne421_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne421)(2 to 3))));
	ne421_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne421)(0 to 1))));
	C119_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C119)(2 to 3))));
	C119_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C119)(0 to 1))));
	T05_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(2 to 3))));
	T05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(0 to 1))));
	D18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D18_state)(2 to 3))));
	D19_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D19_state)(2 to 3))));
	D18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D18_state)(0 to 1))));
	D19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D19_state)(0 to 1))));
	--Ocupation level 2
	ne992_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne992)(2 to 3))));
	ne992_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne992)(0 to 1))));
	J40_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J40)(2 to 3))));
	J40_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J40)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R66_command,R67_command,R36_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R66_command = RELEASE and R67_command = RELEASE and R36_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R66_command = RESERVE or R67_command = RESERVE or R36_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R66_command = LOCK or R67_command = LOCK or R36_command = LOCK) then
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

	process(commandState,D18_position,D19_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D18_position = NORMAL and Sw01_position = NORMAL) or (D18_position = REVERSE and D19_position = REVERSE)) then
					if (D18_position = NORMAL and Sw01_position = NORMAL) then
						path <= 1;
					end if;
					if (D18_position = REVERSE and D19_position = REVERSE) then
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

	process(path,ne65_state,ne124_state,ne421_state,C119_aspect,T05_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne65_state = OCCUPIED or ne65_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C119_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C119_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C119_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C119_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne124_state = OCCUPIED or ne124_lock = LOCKED or ne421_state = OCCUPIED or ne421_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T05_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T05_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T05_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T05_aspect = GREEN) then
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