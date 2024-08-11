--  railwaySignal_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			Lc06_state : in hex_char;
			--Ocupation level 0
			track_ne1 : in hex_char;
			correspondence_S22 : out hex_char;
			--Ocupation level 1
			track_ne8 : in hex_char;
			track_ne9 : in hex_char;
			track_ne14 : in hex_char;
			track_ne15 : in hex_char;
			correspondence_S32 : in hex_char;
			correspondence_X15 : in hex_char;
			correspondence_T05 : in hex_char;
			Sw04_state : in hex_char;
			Sw07_state : in hex_char;
			--Ocupation level 2
			track_ne12 : in hex_char;
			track_ne24 : in hex_char;
			track_ne22 : in hex_char;
			correspondence_J11 : in hex_char;
			correspondence_C25 : in hex_char;
			correspondence_T03 : in hex_char;
			Sw12_state : in hex_char;
			Sw13_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_1;
architecture Behavioral of railwaySignal_1 is
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
	signal Lc06_position : levelCrossingStates := UP;
	signal Lc06_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne8_state : nodeStates := FREE;
	signal ne8_lock : objectLock := RELEASED;
	signal ne9_state : nodeStates := FREE;
	signal ne9_lock : objectLock := RELEASED;
	signal ne14_state : nodeStates := FREE;
	signal ne14_lock : objectLock := RELEASED;
	signal ne15_state : nodeStates := FREE;
	signal ne15_lock : objectLock := RELEASED;
	signal S32_aspect : signalStates;
	signal S32_lock : objectLock := RELEASED;
	signal X15_aspect : signalStates;
	signal X15_lock : objectLock := RELEASED;
	signal T05_aspect : signalStates;
	signal T05_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw07_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw07_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne12_state : nodeStates := FREE;
	signal ne12_lock : objectLock := RELEASED;
	signal ne24_state : nodeStates := FREE;
	signal ne24_lock : objectLock := RELEASED;
	signal ne22_state : nodeStates := FREE;
	signal ne22_lock : objectLock := RELEASED;
	signal J11_aspect : signalStates;
	signal J11_lock : objectLock := RELEASED;
	signal C25_aspect : signalStates;
	signal C25_lock : objectLock := RELEASED;
	signal T03_aspect : signalStates;
	signal T03_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw13_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal Sw13_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S22 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc06_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc06_state)(2 to 3))));
	Lc06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc06_state)(0 to 1))));
	--Ocupation level 1
	ne8_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne8)(2 to 3))));
	ne8_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne8)(0 to 1))));
	ne9_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne9)(2 to 3))));
	ne9_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne9)(0 to 1))));
	ne14_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne14)(2 to 3))));
	ne14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne14)(0 to 1))));
	ne15_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne15)(2 to 3))));
	ne15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne15)(0 to 1))));
	S32_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S32)(2 to 3))));
	S32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S32)(0 to 1))));
	X15_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X15)(2 to 3))));
	X15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X15)(0 to 1))));
	T05_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(2 to 3))));
	T05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw07_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw07_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw07_state)(0 to 1))));
	--Ocupation level 2
	ne12_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne12)(2 to 3))));
	ne12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne12)(0 to 1))));
	ne24_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne24)(2 to 3))));
	ne24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne24)(0 to 1))));
	ne22_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne22)(2 to 3))));
	ne22_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne22)(0 to 1))));
	J11_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J11)(2 to 3))));
	J11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J11)(0 to 1))));
	C25_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C25)(2 to 3))));
	C25_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C25)(0 to 1))));
	T03_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T03)(2 to 3))));
	T03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T03)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw13_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw13_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	Sw13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw13_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R11_command,R12_command,R13_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R11_command = RELEASE and R12_command = RELEASE and R13_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R11_command = RESERVE or R12_command = RESERVE or R13_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R11_command = LOCK or R12_command = LOCK or R13_command = LOCK) then
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

	process(commandState,Sw04_position,Sw07_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw04_position = NORMAL and Sw12_position = NORMAL) or (Sw04_position = NORMAL and Sw12_position = REVERSE and Sw13_position = REVERSE) or (Sw04_position = REVERSE and Sw07_position = REVERSE and Lc06_position = DOWN) or (Sw04_position = REVERSE and Sw07_position = NORMAL)) then
					if (Sw04_position = NORMAL and Sw12_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw04_position = NORMAL and Sw12_position = REVERSE and Sw13_position = REVERSE) then
						path <= 2;
					end if;
					if (Sw04_position = REVERSE and Sw07_position = REVERSE and Lc06_position = DOWN) then
						path <= 3;
					end if;
					if (Sw04_position = REVERSE and Sw07_position = NORMAL) then
						path <= 4;
					end if;
				else
					path <= 0;
				end if;
			when RESERVE =>
				path <= 5;
			when LOCK =>
				path <= 0;
			when others =>
				path <= 0;
		end case;
	end process;

	process(path,ne8_state,ne9_state,ne14_state,ne15_state,S32_aspect,X15_aspect,T05_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne8_state = OCCUPIED or ne8_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S32_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S32_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S32_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S32_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne8_state = OCCUPIED or ne8_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S32_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S32_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S32_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S32_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne9_state = OCCUPIED or ne9_lock = LOCKED or ne14_state = OCCUPIED or ne14_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (X15_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (X15_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (X15_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (X15_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 4 =>
				if (ne9_state = OCCUPIED or ne9_lock = LOCKED or ne15_state = OCCUPIED or ne15_lock = LOCKED) then
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
			when 5 =>
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