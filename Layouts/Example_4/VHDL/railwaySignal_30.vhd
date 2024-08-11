--  railwaySignal_30.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_30 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R63_command : in routeCommands;
			R64_command : in routeCommands;
			R50_command : in routeCommands;
			Lc01_state : in hex_char;
			--Ocupation level 0
			track_ne407 : in hex_char;
			correspondence_S93 : out hex_char;
			--Ocupation level 1
			track_ne122 : in hex_char;
			track_ne123 : in hex_char;
			track_ne61 : in hex_char;
			track_ne99 : in hex_char;
			track_ne98 : in hex_char;
			correspondence_T17 : in hex_char;
			correspondence_X51 : in hex_char;
			D16_state : in hex_char;
			D05_state : in hex_char;
			D08_state : in hex_char;
			--Ocupation level 2
			track_ne996 : in hex_char;
			correspondence_S129 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_30;
architecture Behavioral of railwaySignal_30 is
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
	signal ne122_state : nodeStates := FREE;
	signal ne122_lock : objectLock := RELEASED;
	signal ne123_state : nodeStates := FREE;
	signal ne123_lock : objectLock := RELEASED;
	signal ne61_state : nodeStates := FREE;
	signal ne61_lock : objectLock := RELEASED;
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal ne98_state : nodeStates := FREE;
	signal ne98_lock : objectLock := RELEASED;
	signal T17_aspect : signalStates;
	signal T17_lock : objectLock := RELEASED;
	signal X51_aspect : signalStates;
	signal X51_lock : objectLock := RELEASED;
	signal D16_position : singleSwitchStates := NORMAL;
	signal D05_position : singleSwitchStates := NORMAL;
	signal D08_position : singleSwitchStates := NORMAL;
	signal D16_lock : objectLock := RELEASED;
	signal D05_lock : objectLock := RELEASED;
	signal D08_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne996_state : nodeStates := FREE;
	signal ne996_lock : objectLock := RELEASED;
	signal S129_aspect : signalStates;
	signal S129_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S93 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	--Ocupation level 1
	ne122_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne122)(2 to 3))));
	ne122_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne122)(0 to 1))));
	ne123_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne123)(2 to 3))));
	ne123_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne123)(0 to 1))));
	ne61_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne61)(2 to 3))));
	ne61_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne61)(0 to 1))));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne98_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne98)(0 to 1))));
	T17_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T17)(2 to 3))));
	T17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T17)(0 to 1))));
	X51_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(2 to 3))));
	X51_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(0 to 1))));
	D16_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D16_state)(2 to 3))));
	D05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D05_state)(2 to 3))));
	D08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D08_state)(2 to 3))));
	D16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D16_state)(0 to 1))));
	D05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D05_state)(0 to 1))));
	D08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D08_state)(0 to 1))));
	--Ocupation level 2
	ne996_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne996)(2 to 3))));
	ne996_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne996)(0 to 1))));
	S129_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S129)(2 to 3))));
	S129_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S129)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R63_command,R64_command,R50_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R63_command = RELEASE and R64_command = RELEASE and R50_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R63_command = RESERVE or R64_command = RESERVE or R50_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R63_command = LOCK or R64_command = LOCK or R50_command = LOCK) then
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

	process(commandState,D05_position,D08_position,D16_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D16_position = REVERSE) or (D05_position = REVERSE and D08_position = REVERSE and D16_position = NORMAL and Lc01_position = DOWN)) then
					if (D16_position = REVERSE) then
						path <= 1;
					end if;
					if (D05_position = REVERSE and D08_position = REVERSE and D16_position = NORMAL and Lc01_position = DOWN) then
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

	process(path,ne122_state,ne123_state,ne61_state,ne99_state,ne98_state,T17_aspect,X51_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne122_state = OCCUPIED or ne122_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T17_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T17_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T17_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T17_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne123_state = OCCUPIED or ne123_lock = LOCKED or ne61_state = OCCUPIED or ne61_lock = LOCKED or ne99_state = OCCUPIED or ne99_lock = LOCKED or ne98_state = OCCUPIED or ne98_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (X51_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (X51_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (X51_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (X51_aspect = GREEN) then
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