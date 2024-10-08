--  railwaySignal_20.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_20 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R45_command : in routeCommands;
			R43_command : in routeCommands;
			--Ocupation level 0
			track_ne295 : in hex_char;
			correspondence_C70 : out hex_char;
			--Ocupation level 1
			track_ne297 : in hex_char;
			correspondence_S126 : in hex_char;
			D04_state : in hex_char;
			--Ocupation level 2
			track_ne996 : in hex_char;
			track_ne997 : in hex_char;
			track_ne995 : in hex_char;
			correspondence_T27 : in hex_char;
			correspondence_J38 : in hex_char;
			Sw03_state : in hex_char;
			Sw04_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_20;
architecture Behavioral of railwaySignal_20 is
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
	signal ne297_state : nodeStates := FREE;
	signal ne297_lock : objectLock := RELEASED;
	signal S126_aspect : signalStates;
	signal S126_lock : objectLock := RELEASED;
	signal D04_position : singleSwitchStates := NORMAL;
	signal D04_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne996_state : nodeStates := FREE;
	signal ne996_lock : objectLock := RELEASED;
	signal ne997_state : nodeStates := FREE;
	signal ne997_lock : objectLock := RELEASED;
	signal ne995_state : nodeStates := FREE;
	signal ne995_lock : objectLock := RELEASED;
	signal T27_aspect : signalStates;
	signal T27_lock : objectLock := RELEASED;
	signal J38_aspect : signalStates;
	signal J38_lock : objectLock := RELEASED;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	signal Sw04_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_C70 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne297_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne297)(2 to 3))));
	ne297_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne297)(0 to 1))));
	S126_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S126)(2 to 3))));
	S126_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S126)(0 to 1))));
	D04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D04_state)(2 to 3))));
	D04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D04_state)(0 to 1))));
	--Ocupation level 2
	ne996_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne996)(2 to 3))));
	ne996_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne996)(0 to 1))));
	ne997_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne997)(2 to 3))));
	ne997_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne997)(0 to 1))));
	ne995_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne995)(2 to 3))));
	ne995_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne995)(0 to 1))));
	T27_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T27)(2 to 3))));
	T27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T27)(0 to 1))));
	J38_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J38)(2 to 3))));
	J38_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J38)(0 to 1))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R45_command,R43_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R45_command = RELEASE and R43_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R45_command = RESERVE or R43_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R45_command = LOCK or R43_command = LOCK) then
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

	process(commandState,D04_position,Sw03_position,Sw04_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D04_position = NORMAL and Sw03_position = NORMAL) or (D04_position = NORMAL and Sw03_position = REVERSE and Sw04_position = REVERSE)) then
					if (D04_position = NORMAL and Sw03_position = NORMAL) then
						path <= 1;
					end if;
					if (D04_position = NORMAL and Sw03_position = REVERSE and Sw04_position = REVERSE) then
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

	process(path,ne297_state,S126_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne297_state = OCCUPIED or ne297_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S126_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S126_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S126_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S126_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne297_state = OCCUPIED or ne297_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S126_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S126_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S126_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S126_aspect = GREEN) then
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