--  railwaySignal_76.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_76 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R88_command : in routeCommands;
			R89_command : in routeCommands;
			R31_command : in routeCommands;
			--Ocupation level 0
			track_ne996 : in hex_char;
			correspondence_S129 : out hex_char;
			--Ocupation level 1
			track_ne292 : in hex_char;
			track_ne997 : in hex_char;
			track_ne297 : in hex_char;
			correspondence_J37 : in hex_char;
			correspondence_S71 : in hex_char;
			Sw04_state : in hex_char;
			Sw03_state : in hex_char;
			--Ocupation level 2
			track_ne290 : in hex_char;
			track_ne384 : in hex_char;
			track_ne295 : in hex_char;
			correspondence_J35 : in hex_char;
			correspondence_C67 : in hex_char;
			correspondence_S84 : in hex_char;
			D14_state : in hex_char;
			D04_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_76;
architecture Behavioral of railwaySignal_76 is
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
	signal ne292_state : nodeStates := FREE;
	signal ne292_lock : objectLock := RELEASED;
	signal ne997_state : nodeStates := FREE;
	signal ne997_lock : objectLock := RELEASED;
	signal ne297_state : nodeStates := FREE;
	signal ne297_lock : objectLock := RELEASED;
	signal J37_aspect : signalStates;
	signal J37_lock : objectLock := RELEASED;
	signal S71_aspect : signalStates;
	signal S71_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw03_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne290_state : nodeStates := FREE;
	signal ne290_lock : objectLock := RELEASED;
	signal ne384_state : nodeStates := FREE;
	signal ne384_lock : objectLock := RELEASED;
	signal ne295_state : nodeStates := FREE;
	signal ne295_lock : objectLock := RELEASED;
	signal J35_aspect : signalStates;
	signal J35_lock : objectLock := RELEASED;
	signal C67_aspect : signalStates;
	signal C67_lock : objectLock := RELEASED;
	signal S84_aspect : signalStates;
	signal S84_lock : objectLock := RELEASED;
	signal D14_position : singleSwitchStates := NORMAL;
	signal D04_position : singleSwitchStates := NORMAL;
	signal D14_lock : objectLock := RELEASED;
	signal D04_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S129 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne292_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne292)(2 to 3))));
	ne292_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne292)(0 to 1))));
	ne997_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne997)(2 to 3))));
	ne997_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne997)(0 to 1))));
	ne297_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne297)(2 to 3))));
	ne297_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne297)(0 to 1))));
	J37_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J37)(2 to 3))));
	J37_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J37)(0 to 1))));
	S71_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S71)(2 to 3))));
	S71_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S71)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	--Ocupation level 2
	ne290_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne290)(2 to 3))));
	ne290_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne290)(0 to 1))));
	ne384_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne384)(2 to 3))));
	ne384_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne384)(0 to 1))));
	ne295_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne295)(2 to 3))));
	ne295_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne295)(0 to 1))));
	J35_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J35)(2 to 3))));
	J35_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J35)(0 to 1))));
	C67_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C67)(2 to 3))));
	C67_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C67)(0 to 1))));
	S84_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S84)(2 to 3))));
	S84_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S84)(0 to 1))));
	D14_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D14_state)(2 to 3))));
	D04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D04_state)(2 to 3))));
	D14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D14_state)(0 to 1))));
	D04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D04_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R88_command,R89_command,R31_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R88_command = RELEASE and R89_command = RELEASE and R31_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R88_command = RESERVE or R89_command = RESERVE or R31_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R88_command = LOCK or R89_command = LOCK or R31_command = LOCK) then
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

	process(commandState,Sw03_position,Sw04_position,D04_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw04_position = NORMAL and D14_position = NORMAL) or (Sw03_position = REVERSE and Sw04_position = REVERSE and D04_position = NORMAL) or (Sw03_position = REVERSE and Sw04_position = REVERSE and D04_position = REVERSE)) then
					if (Sw04_position = NORMAL and D14_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw03_position = REVERSE and Sw04_position = REVERSE and D04_position = NORMAL) then
						path <= 2;
					end if;
					if (Sw03_position = REVERSE and Sw04_position = REVERSE and D04_position = REVERSE) then
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

	process(path,ne292_state,ne997_state,ne297_state,J37_aspect,S71_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne292_state = OCCUPIED or ne292_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J37_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J37_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J37_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J37_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne997_state = OCCUPIED or ne997_lock = LOCKED or ne297_state = OCCUPIED or ne297_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S71_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S71_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S71_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S71_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne997_state = OCCUPIED or ne997_lock = LOCKED or ne297_state = OCCUPIED or ne297_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S71_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S71_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S71_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S71_aspect = GREEN) then
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