--  railwaySignal_22.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_22 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R54_command : in routeCommands;
			R55_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R73_command : in routeCommands;
			--Ocupation level 0
			track_ne30 : in hex_char;
			correspondence_S97 : out hex_char;
			--Ocupation level 1
			track_ne29 : in hex_char;
			track_ne110 : in hex_char;
			track_ne83 : in hex_char;
			correspondence_C138 : in hex_char;
			correspondence_C114 : in hex_char;
			Sw08_state : in hex_char;
			Sw09_state : in hex_char;
			--Ocupation level 2
			track_ne100 : in hex_char;
			track_ne101 : in hex_char;
			track_ne44 : in hex_char;
			track_ne32 : in hex_char;
			correspondence_S105 : in hex_char;
			correspondence_C100 : in hex_char;
			Sw41_state : in hex_char;
			Sw04_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_22;
architecture Behavioral of railwaySignal_22 is
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
	signal ne29_state : nodeStates := FREE;
	signal ne29_lock : objectLock := RELEASED;
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal ne83_state : nodeStates := FREE;
	signal ne83_lock : objectLock := RELEASED;
	signal C138_aspect : signalStates;
	signal C138_lock : objectLock := RELEASED;
	signal C114_aspect : signalStates;
	signal C114_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw09_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
	signal Sw09_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal ne44_state : nodeStates := FREE;
	signal ne44_lock : objectLock := RELEASED;
	signal ne32_state : nodeStates := FREE;
	signal ne32_lock : objectLock := RELEASED;
	signal S105_aspect : signalStates;
	signal S105_lock : objectLock := RELEASED;
	signal C100_aspect : signalStates;
	signal C100_lock : objectLock := RELEASED;
	signal Sw41_position : singleSwitchStates := NORMAL;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw41_lock : objectLock := RELEASED;
	signal Sw04_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S97 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne29_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne29)(2 to 3))));
	ne29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne29)(0 to 1))));
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	ne83_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne83)(2 to 3))));
	ne83_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne83)(0 to 1))));
	C138_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C138)(2 to 3))));
	C138_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C138)(0 to 1))));
	C114_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C114)(2 to 3))));
	C114_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C114)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw09_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	Sw09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw09_state)(0 to 1))));
	--Ocupation level 2
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	ne44_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne44)(2 to 3))));
	ne44_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne44)(0 to 1))));
	ne32_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne32)(2 to 3))));
	ne32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne32)(0 to 1))));
	S105_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S105)(2 to 3))));
	S105_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S105)(0 to 1))));
	C100_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C100)(2 to 3))));
	C100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C100)(0 to 1))));
	Sw41_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw41_state)(2 to 3))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw41_state)(0 to 1))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R54_command,R55_command,R7_command,R8_command,R73_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R54_command = RELEASE and R55_command = RELEASE and R7_command = RELEASE and R8_command = RELEASE and R73_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R54_command = RESERVE or R55_command = RESERVE or R7_command = RESERVE or R8_command = RESERVE or R73_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R54_command = LOCK or R55_command = LOCK or R7_command = LOCK or R8_command = LOCK or R73_command = LOCK) then
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

	process(commandState,Sw08_position,Sw04_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw08_position = REVERSE and Sw09_position = REVERSE and Sw41_position = NORMAL) or (Sw08_position = NORMAL and Sw04_position = NORMAL)) then
					if (Sw08_position = REVERSE and Sw09_position = REVERSE and Sw41_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw08_position = NORMAL and Sw04_position = NORMAL) then
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

	process(path,ne29_state,ne110_state,ne83_state,C138_aspect,C114_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne29_state = OCCUPIED or ne29_lock = LOCKED or ne110_state = OCCUPIED or ne110_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C138_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C138_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C138_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C138_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne83_state = OCCUPIED or ne83_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C114_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C114_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C114_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C114_aspect = GREEN) then
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