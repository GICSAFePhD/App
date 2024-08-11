--  railwaySignal_39.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_39 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R31_command : in routeCommands;
			R34_command : in routeCommands;
			R51_command : in routeCommands;
			R64_command : in routeCommands;
			Lc01_state : in hex_char;
			--Ocupation level 0
			track_ne98 : in hex_char;
			correspondence_X51 : out hex_char;
			--Ocupation level 1
			track_ne996 : in hex_char;
			correspondence_S129 : in hex_char;
			--Ocupation level 2
			track_ne292 : in hex_char;
			track_ne997 : in hex_char;
			track_ne297 : in hex_char;
			correspondence_J37 : in hex_char;
			correspondence_S71 : in hex_char;
			Sw04_state : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_39;
architecture Behavioral of railwaySignal_39 is
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
	signal Lc01_position : levelCrossingStates := UP;
	signal Lc01_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne996_state : nodeStates := FREE;
	signal ne996_lock : objectLock := RELEASED;
	signal S129_aspect : signalStates;
	signal S129_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne292_state : nodeStates := FREE;
	signal ne292_lock : objectLock := RELEASED;
	signal ne997_state : nodeStates := FREE;
	signal ne997_lock : objectLock := RELEASED;
	signal ne297_state : nodeStates := FREE;
	signal ne297_lock : objectLock := RELEASED;
	signal J37_aspect : signalStates;
	signal J37_lock : objectLock := RELEASED;
	signal S71_aspect : signalStates;
	signal S71_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_X51 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	--Ocupation level 1
	ne996_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne996)(2 to 3))));
	ne996_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne996)(0 to 1))));
	S129_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S129)(2 to 3))));
	S129_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S129)(0 to 1))));
	--Ocupation level 2
	ne292_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne292)(2 to 3))));
	ne292_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne292)(0 to 1))));
	ne997_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne997)(2 to 3))));
	ne997_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne997)(0 to 1))));
	ne297_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne297)(2 to 3))));
	ne297_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne297)(0 to 1))));
	J37_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J37)(2 to 3))));
	J37_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J37)(0 to 1))));
	S71_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S71)(2 to 3))));
	S71_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S71)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R31_command,R34_command,R51_command,R64_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R31_command = RELEASE and R34_command = RELEASE and R51_command = RELEASE and R64_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R31_command = RESERVE or R34_command = RESERVE or R51_command = RESERVE or R64_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R31_command = LOCK or R34_command = LOCK or R51_command = LOCK or R64_command = LOCK) then
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

	process(commandState,Sw04_position,Sw03_position,Sw04_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw04_position = NORMAL and Sw03_position = REVERSE and Sw04_position = REVERSE and Lc01_position = DOWN) or (Sw04_position = NORMAL and Sw03_position = REVERSE and Sw04_position = REVERSE and Lc01_position = DOWN)) then
					if (Sw04_position = NORMAL and Sw03_position = REVERSE and Sw04_position = REVERSE and Lc01_position = DOWN) then
						path <= 1;
					end if;
					if (Sw04_position = NORMAL and Sw03_position = REVERSE and Sw04_position = REVERSE and Lc01_position = DOWN) then
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

	process(path,ne996_state,S129_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne996_state = OCCUPIED or ne996_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S129_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S129_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S129_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S129_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne996_state = OCCUPIED or ne996_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S129_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S129_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S129_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S129_aspect = GREEN) then
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