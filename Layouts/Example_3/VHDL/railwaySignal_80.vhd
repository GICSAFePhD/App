--  railwaySignal_80.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_80 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R58_command : in routeCommands;
			R59_command : in routeCommands;
			R85_command : in routeCommands;
			--Ocupation level 0
			track_ne110 : in hex_char;
			correspondence_S102 : out hex_char;
			--Ocupation level 1
			track_ne32 : in hex_char;
			track_ne29 : in hex_char;
			correspondence_S115 : in hex_char;
			correspondence_B101 : in hex_char;
			Sw09_state : in hex_char;
			--Ocupation level 2
			track_ne84 : in hex_char;
			track_ne83 : in hex_char;
			track_ne41 : in hex_char;
			track_ne82 : in hex_char;
			correspondence_C95 : in hex_char;
			correspondence_P58 : in hex_char;
			correspondence_T13 : in hex_char;
			correspondence_B96 : in hex_char;
			Sw04_state : in hex_char;
			Sw05_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_80;
architecture Behavioral of railwaySignal_80 is
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
	signal ne32_state : nodeStates := FREE;
	signal ne32_lock : objectLock := RELEASED;
	signal ne29_state : nodeStates := FREE;
	signal ne29_lock : objectLock := RELEASED;
	signal S115_aspect : signalStates;
	signal S115_lock : objectLock := RELEASED;
	signal B101_aspect : signalStates;
	signal B101_lock : objectLock := RELEASED;
	signal Sw09_position : singleSwitchStates := NORMAL;
	signal Sw09_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne84_state : nodeStates := FREE;
	signal ne84_lock : objectLock := RELEASED;
	signal ne83_state : nodeStates := FREE;
	signal ne83_lock : objectLock := RELEASED;
	signal ne41_state : nodeStates := FREE;
	signal ne41_lock : objectLock := RELEASED;
	signal ne82_state : nodeStates := FREE;
	signal ne82_lock : objectLock := RELEASED;
	signal C95_aspect : signalStates;
	signal C95_lock : objectLock := RELEASED;
	signal P58_aspect : signalStates;
	signal P58_lock : objectLock := RELEASED;
	signal T13_aspect : signalStates;
	signal T13_lock : objectLock := RELEASED;
	signal B96_aspect : signalStates;
	signal B96_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw05_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw05_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S102 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne32_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne32)(2 to 3))));
	ne32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne32)(0 to 1))));
	ne29_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne29)(2 to 3))));
	ne29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne29)(0 to 1))));
	S115_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S115)(2 to 3))));
	S115_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S115)(0 to 1))));
	B101_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B101)(2 to 3))));
	B101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B101)(0 to 1))));
	Sw09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw09_state)(2 to 3))));
	Sw09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw09_state)(0 to 1))));
	--Ocupation level 2
	ne84_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne84)(2 to 3))));
	ne84_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne84)(0 to 1))));
	ne83_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne83)(2 to 3))));
	ne83_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne83)(0 to 1))));
	ne41_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne41)(2 to 3))));
	ne41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne41)(0 to 1))));
	ne82_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne82)(2 to 3))));
	ne82_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne82)(0 to 1))));
	C95_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C95)(2 to 3))));
	C95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C95)(0 to 1))));
	P58_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P58)(2 to 3))));
	P58_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P58)(0 to 1))));
	T13_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T13)(2 to 3))));
	T13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T13)(0 to 1))));
	B96_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B96)(2 to 3))));
	B96_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B96)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw05_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R58_command,R59_command,R85_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R58_command = RELEASE and R59_command = RELEASE and R85_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R58_command = RESERVE or R59_command = RESERVE or R85_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R58_command = LOCK or R59_command = LOCK or R85_command = LOCK) then
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

	process(commandState,Sw09_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw09_position = NORMAL and Sw04_position = NORMAL) or (Sw09_position = NORMAL and Sw04_position = REVERSE and Sw05_position = NORMAL_REVERSE) or (Sw09_position = NORMAL and Sw04_position = REVERSE and Sw05_position = DOUBLE_REVERSE) or (Sw09_position = REVERSE)) then
					if (Sw09_position = NORMAL and Sw04_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw09_position = NORMAL and Sw04_position = REVERSE and Sw05_position = NORMAL_REVERSE) then
						path <= 2;
					end if;
					if (Sw09_position = NORMAL and Sw04_position = REVERSE and Sw05_position = DOUBLE_REVERSE) then
						path <= 3;
					end if;
					if (Sw09_position = REVERSE) then
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

	process(path,ne32_state,ne29_state,S115_aspect,B101_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne32_state = OCCUPIED or ne32_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S115_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S115_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S115_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S115_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne32_state = OCCUPIED or ne32_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S115_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S115_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S115_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S115_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne32_state = OCCUPIED or ne32_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S115_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S115_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S115_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S115_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 4 =>
				if (ne29_state = OCCUPIED or ne29_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B101_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B101_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B101_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B101_aspect = GREEN) then
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