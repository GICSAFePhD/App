--  railwaySignal_14.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R43_command : in routeCommands;
			R44_command : in routeCommands;
			R39_command : in routeCommands;
			--Ocupation level 0
			track_ne288 : in hex_char;
			correspondence_S69 : out hex_char;
			--Ocupation level 1
			track_ne295 : in hex_char;
			track_ne110 : in hex_char;
			correspondence_C70 : in hex_char;
			correspondence_B68 : in hex_char;
			D03_state : in hex_char;
			--Ocupation level 2
			track_ne297 : in hex_char;
			track_ne384 : in hex_char;
			correspondence_S126 : in hex_char;
			D04_state : in hex_char;
			Sw02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_14;
architecture Behavioral of railwaySignal_14 is
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
	signal ne295_state : nodeStates := FREE;
	signal ne295_lock : objectLock := RELEASED;
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal C70_aspect : signalStates;
	signal C70_lock : objectLock := RELEASED;
	signal B68_aspect : signalStates;
	signal B68_lock : objectLock := RELEASED;
	signal D03_position : singleSwitchStates := NORMAL;
	signal D03_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne297_state : nodeStates := FREE;
	signal ne297_lock : objectLock := RELEASED;
	signal ne384_state : nodeStates := FREE;
	signal ne384_lock : objectLock := RELEASED;
	signal S126_aspect : signalStates;
	signal S126_lock : objectLock := RELEASED;
	signal D04_position : singleSwitchStates := NORMAL;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal D04_lock : objectLock := RELEASED;
	signal Sw02_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S69 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne295_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne295)(2 to 3))));
	ne295_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne295)(0 to 1))));
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	C70_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C70)(2 to 3))));
	C70_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C70)(0 to 1))));
	B68_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B68)(2 to 3))));
	B68_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B68)(0 to 1))));
	D03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D03_state)(2 to 3))));
	D03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D03_state)(0 to 1))));
	--Ocupation level 2
	ne297_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne297)(2 to 3))));
	ne297_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne297)(0 to 1))));
	ne384_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne384)(2 to 3))));
	ne384_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne384)(0 to 1))));
	S126_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S126)(2 to 3))));
	S126_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S126)(0 to 1))));
	D04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D04_state)(2 to 3))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	D04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D04_state)(0 to 1))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R43_command,R44_command,R39_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R43_command = RELEASE and R44_command = RELEASE and R39_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R43_command = RESERVE or R44_command = RESERVE or R39_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R43_command = LOCK or R44_command = LOCK or R39_command = LOCK) then
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

	process(commandState,D03_position,D04_position,Sw02_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D03_position = NORMAL and D04_position = NORMAL) or (D03_position = REVERSE and D04_position = REVERSE and Sw02_position = NORMAL)) then
					if (D03_position = NORMAL and D04_position = NORMAL) then
						path <= 1;
					end if;
					if (D03_position = REVERSE and D04_position = REVERSE and Sw02_position = NORMAL) then
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

	process(path,ne295_state,ne110_state,C70_aspect,B68_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne295_state = OCCUPIED or ne295_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C70_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C70_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C70_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C70_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne110_state = OCCUPIED or ne110_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B68_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B68_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B68_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B68_aspect = GREEN) then
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