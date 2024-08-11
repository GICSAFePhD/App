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
			R77_command : in routeCommands;
			R78_command : in routeCommands;
			--Ocupation level 0
			track_ne41 : in hex_char;
			correspondence_B130 : out hex_char;
			--Ocupation level 1
			track_ne82 : in hex_char;
			track_ne32 : in hex_char;
			track_ne85 : in hex_char;
			track_ne100 : in hex_char;
			track_ne101 : in hex_char;
			track_ne44 : in hex_char;
			correspondence_C100 : in hex_char;
			correspondence_S105 : in hex_char;
			Sw04_state : in hex_char;
			Sw05_state : in hex_char;
			Sw41_state : in hex_char;
			--Ocupation level 2
			track_ne110 : in hex_char;
			track_ne26 : in hex_char;
			track_ne43 : in hex_char;
			track_ne102 : in hex_char;
			track_ne48 : in hex_char;
			track_ne65 : in hex_char;
			correspondence_C138 : in hex_char;
			correspondence_L29 : in hex_char;
			correspondence_S93 : in hex_char;
			Sw09_state : in hex_char;
			s71W01_state : in hex_char;
			s71W02_state : in hex_char;
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
	signal ne82_state : nodeStates := FREE;
	signal ne82_lock : objectLock := RELEASED;
	signal ne32_state : nodeStates := FREE;
	signal ne32_lock : objectLock := RELEASED;
	signal ne85_state : nodeStates := FREE;
	signal ne85_lock : objectLock := RELEASED;
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal ne44_state : nodeStates := FREE;
	signal ne44_lock : objectLock := RELEASED;
	signal C100_aspect : signalStates;
	signal C100_lock : objectLock := RELEASED;
	signal S105_aspect : signalStates;
	signal S105_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw05_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw41_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw05_lock : objectLock := RELEASED;
	signal Sw41_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal ne26_state : nodeStates := FREE;
	signal ne26_lock : objectLock := RELEASED;
	signal ne43_state : nodeStates := FREE;
	signal ne43_lock : objectLock := RELEASED;
	signal ne102_state : nodeStates := FREE;
	signal ne102_lock : objectLock := RELEASED;
	signal ne48_state : nodeStates := FREE;
	signal ne48_lock : objectLock := RELEASED;
	signal ne65_state : nodeStates := FREE;
	signal ne65_lock : objectLock := RELEASED;
	signal C138_aspect : signalStates;
	signal C138_lock : objectLock := RELEASED;
	signal L29_aspect : signalStates;
	signal L29_lock : objectLock := RELEASED;
	signal S93_aspect : signalStates;
	signal S93_lock : objectLock := RELEASED;
	signal Sw09_position : singleSwitchStates := NORMAL;
	signal s71W01_position : singleSwitchStates := NORMAL;
	signal s71W02_position : singleSwitchStates := NORMAL;
	signal Sw09_lock : objectLock := RELEASED;
	signal s71W01_lock : objectLock := RELEASED;
	signal s71W02_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_B130 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne82_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne82)(2 to 3))));
	ne82_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne82)(0 to 1))));
	ne32_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne32)(2 to 3))));
	ne32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne32)(0 to 1))));
	ne85_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne85)(2 to 3))));
	ne85_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne85)(0 to 1))));
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	ne44_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne44)(2 to 3))));
	ne44_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne44)(0 to 1))));
	C100_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C100)(2 to 3))));
	C100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C100)(0 to 1))));
	S105_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S105)(2 to 3))));
	S105_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S105)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw05_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw41_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw41_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	Sw41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw41_state)(0 to 1))));
	--Ocupation level 2
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	ne26_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne26)(2 to 3))));
	ne26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne26)(0 to 1))));
	ne43_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne43)(2 to 3))));
	ne43_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne43)(0 to 1))));
	ne102_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne102)(2 to 3))));
	ne102_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne102)(0 to 1))));
	ne48_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne48)(2 to 3))));
	ne48_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne48)(0 to 1))));
	ne65_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne65)(2 to 3))));
	ne65_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne65)(0 to 1))));
	C138_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C138)(2 to 3))));
	C138_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C138)(0 to 1))));
	L29_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L29)(2 to 3))));
	L29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L29)(0 to 1))));
	S93_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S93)(2 to 3))));
	S93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S93)(0 to 1))));
	Sw09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw09_state)(2 to 3))));
	s71W01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s71W01_state)(2 to 3))));
	s71W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s71W02_state)(2 to 3))));
	Sw09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw09_state)(0 to 1))));
	s71W01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s71W01_state)(0 to 1))));
	s71W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s71W02_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R77_command,R78_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R77_command = RELEASE and R78_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R77_command = RESERVE or R78_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R77_command = LOCK or R78_command = LOCK) then
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

	process(commandState,Sw05_position,Sw41_position,s71W01_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw04_position = REVERSE and Sw05_position = NORMAL_REVERSE and Sw09_position = NORMAL) or (Sw05_position = DOUBLE_NORMAL and Sw41_position = REVERSE and s71W01_position = REVERSE and s71W02_position = NORMAL) or (Sw05_position = DOUBLE_NORMAL and Sw41_position = REVERSE and s71W01_position = NORMAL)) then
					if (Sw04_position = REVERSE and Sw05_position = NORMAL_REVERSE and Sw09_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw05_position = DOUBLE_NORMAL and Sw41_position = REVERSE and s71W01_position = REVERSE and s71W02_position = NORMAL) then
						path <= 2;
					end if;
					if (Sw05_position = DOUBLE_NORMAL and Sw41_position = REVERSE and s71W01_position = NORMAL) then
						path <= 3;
					end if;
				else
					path <= 0;
				end if;
			when RESERVE =>
				path <= 4;
			when LOCK =>
				path <= 0;
			when others =>
				path <= 0;
		end case;
	end process;

	process(path,ne82_state,ne32_state,ne85_state,ne100_state,ne101_state,ne44_state,C100_aspect,S105_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne82_state = OCCUPIED or ne82_lock = LOCKED or ne32_state = OCCUPIED or ne32_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C100_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C100_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C100_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C100_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne85_state = OCCUPIED or ne85_lock = LOCKED or ne100_state = OCCUPIED or ne100_lock = LOCKED or ne101_state = OCCUPIED or ne101_lock = LOCKED or ne44_state = OCCUPIED or ne44_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S105_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S105_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S105_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S105_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne85_state = OCCUPIED or ne85_lock = LOCKED or ne100_state = OCCUPIED or ne100_lock = LOCKED or ne101_state = OCCUPIED or ne101_lock = LOCKED or ne44_state = OCCUPIED or ne44_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S105_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S105_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S105_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S105_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 4 =>
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