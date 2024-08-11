--  railwaySignal_81.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_81 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R84_command : in routeCommands;
			R54_command : in routeCommands;
			R56_command : in routeCommands;
			--Ocupation level 0
			track_ne110 : in hex_char;
			correspondence_C138 : out hex_char;
			--Ocupation level 1
			track_ne100 : in hex_char;
			track_ne101 : in hex_char;
			track_ne44 : in hex_char;
			correspondence_S105 : in hex_char;
			Sw41_state : in hex_char;
			--Ocupation level 2
			track_ne26 : in hex_char;
			track_ne43 : in hex_char;
			track_ne102 : in hex_char;
			track_ne48 : in hex_char;
			track_ne65 : in hex_char;
			correspondence_L29 : in hex_char;
			correspondence_S93 : in hex_char;
			s71W01_state : in hex_char;
			s71W02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_81;
architecture Behavioral of railwaySignal_81 is
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
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal ne44_state : nodeStates := FREE;
	signal ne44_lock : objectLock := RELEASED;
	signal S105_aspect : signalStates;
	signal S105_lock : objectLock := RELEASED;
	signal Sw41_position : singleSwitchStates := NORMAL;
	signal Sw41_lock : objectLock := RELEASED;
	--Ocupation level 2
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
	signal L29_aspect : signalStates;
	signal L29_lock : objectLock := RELEASED;
	signal S93_aspect : signalStates;
	signal S93_lock : objectLock := RELEASED;
	signal s71W01_position : singleSwitchStates := NORMAL;
	signal s71W02_position : singleSwitchStates := NORMAL;
	signal s71W01_lock : objectLock := RELEASED;
	signal s71W02_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_C138 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	ne44_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne44)(2 to 3))));
	ne44_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne44)(0 to 1))));
	S105_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S105)(2 to 3))));
	S105_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S105)(0 to 1))));
	Sw41_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw41_state)(2 to 3))));
	Sw41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw41_state)(0 to 1))));
	--Ocupation level 2
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
	L29_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L29)(2 to 3))));
	L29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L29)(0 to 1))));
	S93_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S93)(2 to 3))));
	S93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S93)(0 to 1))));
	s71W01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s71W01_state)(2 to 3))));
	s71W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s71W02_state)(2 to 3))));
	s71W01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s71W01_state)(0 to 1))));
	s71W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s71W02_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R84_command,R54_command,R56_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R84_command = RELEASE and R54_command = RELEASE and R56_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R84_command = RESERVE or R54_command = RESERVE or R56_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R84_command = LOCK or R54_command = LOCK or R56_command = LOCK) then
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

	process(commandState,Sw41_position,s71W01_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw41_position = NORMAL and s71W01_position = REVERSE and s71W02_position = NORMAL) or (Sw41_position = NORMAL and s71W01_position = NORMAL)) then
					if (Sw41_position = NORMAL and s71W01_position = REVERSE and s71W02_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw41_position = NORMAL and s71W01_position = NORMAL) then
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

	process(path,ne100_state,ne101_state,ne44_state,S105_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne100_state = OCCUPIED or ne100_lock = LOCKED or ne101_state = OCCUPIED or ne101_lock = LOCKED or ne44_state = OCCUPIED or ne44_lock = LOCKED) then
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
			when 2 =>
				if (ne100_state = OCCUPIED or ne100_lock = LOCKED or ne101_state = OCCUPIED or ne101_lock = LOCKED or ne44_state = OCCUPIED or ne44_lock = LOCKED) then
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