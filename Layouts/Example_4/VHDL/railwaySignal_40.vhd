--  railwaySignal_40.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_40 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R35_command : in routeCommands;
			R36_command : in routeCommands;
			R30_command : in routeCommands;
			--Ocupation level 0
			track_ne99 : in hex_char;
			correspondence_S55 : out hex_char;
			--Ocupation level 1
			track_ne61 : in hex_char;
			track_ne63 : in hex_char;
			correspondence_S78 : in hex_char;
			correspondence_S95 : in hex_char;
			D05_state : in hex_char;
			--Ocupation level 2
			track_ne404 : in hex_char;
			track_ne123 : in hex_char;
			track_ne421 : in hex_char;
			track_ne65 : in hex_char;
			track_ne124 : in hex_char;
			correspondence_C73 : in hex_char;
			correspondence_B77 : in hex_char;
			correspondence_C119 : in hex_char;
			correspondence_T05 : in hex_char;
			D08_state : in hex_char;
			D18_state : in hex_char;
			D19_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_40;
architecture Behavioral of railwaySignal_40 is
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
	signal ne61_state : nodeStates := FREE;
	signal ne61_lock : objectLock := RELEASED;
	signal ne63_state : nodeStates := FREE;
	signal ne63_lock : objectLock := RELEASED;
	signal S78_aspect : signalStates;
	signal S78_lock : objectLock := RELEASED;
	signal S95_aspect : signalStates;
	signal S95_lock : objectLock := RELEASED;
	signal D05_position : singleSwitchStates := NORMAL;
	signal D05_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne404_state : nodeStates := FREE;
	signal ne404_lock : objectLock := RELEASED;
	signal ne123_state : nodeStates := FREE;
	signal ne123_lock : objectLock := RELEASED;
	signal ne421_state : nodeStates := FREE;
	signal ne421_lock : objectLock := RELEASED;
	signal ne65_state : nodeStates := FREE;
	signal ne65_lock : objectLock := RELEASED;
	signal ne124_state : nodeStates := FREE;
	signal ne124_lock : objectLock := RELEASED;
	signal C73_aspect : signalStates;
	signal C73_lock : objectLock := RELEASED;
	signal B77_aspect : signalStates;
	signal B77_lock : objectLock := RELEASED;
	signal C119_aspect : signalStates;
	signal C119_lock : objectLock := RELEASED;
	signal T05_aspect : signalStates;
	signal T05_lock : objectLock := RELEASED;
	signal D08_position : singleSwitchStates := NORMAL;
	signal D18_position : singleSwitchStates := NORMAL;
	signal D19_position : singleSwitchStates := NORMAL;
	signal D08_lock : objectLock := RELEASED;
	signal D18_lock : objectLock := RELEASED;
	signal D19_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S55 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne61_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne61)(2 to 3))));
	ne61_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne61)(0 to 1))));
	ne63_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne63)(2 to 3))));
	ne63_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne63)(0 to 1))));
	S78_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S78)(2 to 3))));
	S78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S78)(0 to 1))));
	S95_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S95)(2 to 3))));
	S95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S95)(0 to 1))));
	D05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D05_state)(2 to 3))));
	D05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D05_state)(0 to 1))));
	--Ocupation level 2
	ne404_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne404)(2 to 3))));
	ne404_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne404)(0 to 1))));
	ne123_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne123)(2 to 3))));
	ne123_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne123)(0 to 1))));
	ne421_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne421)(2 to 3))));
	ne421_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne421)(0 to 1))));
	ne65_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne65)(2 to 3))));
	ne65_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne65)(0 to 1))));
	ne124_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne124)(2 to 3))));
	ne124_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne124)(0 to 1))));
	C73_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C73)(2 to 3))));
	C73_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C73)(0 to 1))));
	B77_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B77)(2 to 3))));
	B77_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B77)(0 to 1))));
	C119_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C119)(2 to 3))));
	C119_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C119)(0 to 1))));
	T05_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(2 to 3))));
	T05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(0 to 1))));
	D08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D08_state)(2 to 3))));
	D18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D18_state)(2 to 3))));
	D19_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D19_state)(2 to 3))));
	D08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D08_state)(0 to 1))));
	D18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D18_state)(0 to 1))));
	D19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D19_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R35_command,R36_command,R30_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R35_command = RELEASE and R36_command = RELEASE and R30_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R35_command = RESERVE or R36_command = RESERVE or R30_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R35_command = LOCK or R36_command = LOCK or R30_command = LOCK) then
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

	process(commandState,D05_position,D18_position,D19_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D05_position = REVERSE and D08_position = NORMAL) or (D05_position = REVERSE and D08_position = REVERSE) or (D05_position = NORMAL and D18_position = NORMAL) or (D05_position = NORMAL and D18_position = REVERSE and D19_position = REVERSE)) then
					if (D05_position = REVERSE and D08_position = NORMAL) then
						path <= 1;
					end if;
					if (D05_position = REVERSE and D08_position = REVERSE) then
						path <= 2;
					end if;
					if (D05_position = NORMAL and D18_position = NORMAL) then
						path <= 3;
					end if;
					if (D05_position = NORMAL and D18_position = REVERSE and D19_position = REVERSE) then
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

	process(path,ne61_state,ne63_state,S78_aspect,S95_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne61_state = OCCUPIED or ne61_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S78_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S78_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S78_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S78_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne61_state = OCCUPIED or ne61_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S78_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S78_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S78_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S78_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne63_state = OCCUPIED or ne63_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S95_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S95_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S95_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S95_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 4 =>
				if (ne63_state = OCCUPIED or ne63_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S95_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S95_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S95_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S95_aspect = GREEN) then
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