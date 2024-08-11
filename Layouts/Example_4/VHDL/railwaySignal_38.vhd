--  railwaySignal_38.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_38 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R30_command : in routeCommands;
			R18_command : in routeCommands;
			Lc01_state : in hex_char;
			--Ocupation level 0
			track_ne98 : in hex_char;
			correspondence_X50 : out hex_char;
			--Ocupation level 1
			track_ne99 : in hex_char;
			correspondence_S55 : in hex_char;
			--Ocupation level 2
			track_ne63 : in hex_char;
			track_ne61 : in hex_char;
			correspondence_S78 : in hex_char;
			correspondence_S95 : in hex_char;
			D05_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_38;
architecture Behavioral of railwaySignal_38 is
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
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal S55_aspect : signalStates;
	signal S55_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne63_state : nodeStates := FREE;
	signal ne63_lock : objectLock := RELEASED;
	signal ne61_state : nodeStates := FREE;
	signal ne61_lock : objectLock := RELEASED;
	signal S78_aspect : signalStates;
	signal S78_lock : objectLock := RELEASED;
	signal S95_aspect : signalStates;
	signal S95_lock : objectLock := RELEASED;
	signal D05_position : singleSwitchStates := NORMAL;
	signal D05_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_X50 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	--Ocupation level 1
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	S55_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S55)(2 to 3))));
	S55_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S55)(0 to 1))));
	--Ocupation level 2
	ne63_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne63)(2 to 3))));
	ne63_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne63)(0 to 1))));
	ne61_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne61)(2 to 3))));
	ne61_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne61)(0 to 1))));
	S78_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S78)(2 to 3))));
	S78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S78)(0 to 1))));
	S95_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S95)(2 to 3))));
	S95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S95)(0 to 1))));
	D05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D05_state)(2 to 3))));
	D05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D05_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R30_command,R18_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R30_command = RELEASE and R18_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R30_command = RESERVE or R18_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R30_command = LOCK or R18_command = LOCK) then
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

	process(commandState,D05_position,D05_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D05_position = REVERSE and D05_position = NORMAL and Lc01_position = DOWN) or (D05_position = REVERSE and D05_position = NORMAL and Lc01_position = DOWN)) then
					if (D05_position = REVERSE and D05_position = NORMAL and Lc01_position = DOWN) then
						path <= 1;
					end if;
					if (D05_position = REVERSE and D05_position = NORMAL and Lc01_position = DOWN) then
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

	process(path,ne99_state,S55_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne99_state = OCCUPIED or ne99_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S55_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S55_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S55_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S55_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne99_state = OCCUPIED or ne99_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S55_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S55_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S55_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S55_aspect = GREEN) then
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