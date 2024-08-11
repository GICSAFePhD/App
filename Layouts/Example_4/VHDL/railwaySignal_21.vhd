--  railwaySignal_21.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_21 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R46_command : in routeCommands;
			R47_command : in routeCommands;
			R85_command : in routeCommands;
			R89_command : in routeCommands;
			--Ocupation level 0
			track_ne297 : in hex_char;
			correspondence_S71 : out hex_char;
			--Ocupation level 1
			track_ne295 : in hex_char;
			track_ne384 : in hex_char;
			correspondence_C67 : in hex_char;
			correspondence_S84 : in hex_char;
			D04_state : in hex_char;
			--Ocupation level 2
			track_ne991 : in hex_char;
			track_ne288 : in hex_char;
			track_ne104 : in hex_char;
			track_ne110 : in hex_char;
			correspondence_T01 : in hex_char;
			correspondence_T13 : in hex_char;
			D01_state : in hex_char;
			D03_state : in hex_char;
			Sw02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_21;
architecture Behavioral of railwaySignal_21 is
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
	signal ne384_state : nodeStates := FREE;
	signal ne384_lock : objectLock := RELEASED;
	signal C67_aspect : signalStates;
	signal C67_lock : objectLock := RELEASED;
	signal S84_aspect : signalStates;
	signal S84_lock : objectLock := RELEASED;
	signal D04_position : singleSwitchStates := NORMAL;
	signal D04_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne991_state : nodeStates := FREE;
	signal ne991_lock : objectLock := RELEASED;
	signal ne288_state : nodeStates := FREE;
	signal ne288_lock : objectLock := RELEASED;
	signal ne104_state : nodeStates := FREE;
	signal ne104_lock : objectLock := RELEASED;
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal T01_aspect : signalStates;
	signal T01_lock : objectLock := RELEASED;
	signal T13_aspect : signalStates;
	signal T13_lock : objectLock := RELEASED;
	signal D01_position : singleSwitchStates := NORMAL;
	signal D03_position : singleSwitchStates := NORMAL;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal D01_lock : objectLock := RELEASED;
	signal D03_lock : objectLock := RELEASED;
	signal Sw02_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S71 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne295_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne295)(2 to 3))));
	ne295_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne295)(0 to 1))));
	ne384_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne384)(2 to 3))));
	ne384_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne384)(0 to 1))));
	C67_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C67)(2 to 3))));
	C67_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C67)(0 to 1))));
	S84_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S84)(2 to 3))));
	S84_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S84)(0 to 1))));
	D04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D04_state)(2 to 3))));
	D04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D04_state)(0 to 1))));
	--Ocupation level 2
	ne991_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne991)(2 to 3))));
	ne991_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne991)(0 to 1))));
	ne288_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne288)(2 to 3))));
	ne288_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne288)(0 to 1))));
	ne104_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne104)(2 to 3))));
	ne104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne104)(0 to 1))));
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	T01_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(2 to 3))));
	T01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(0 to 1))));
	T13_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T13)(2 to 3))));
	T13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T13)(0 to 1))));
	D01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D01_state)(2 to 3))));
	D03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D03_state)(2 to 3))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	D01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D01_state)(0 to 1))));
	D03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D03_state)(0 to 1))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R46_command,R47_command,R85_command,R89_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R46_command = RELEASE and R47_command = RELEASE and R85_command = RELEASE and R89_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R46_command = RESERVE or R47_command = RESERVE or R85_command = RESERVE or R89_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R46_command = LOCK or R47_command = LOCK or R85_command = LOCK or R89_command = LOCK) then
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

	process(commandState,D04_position,D01_position,D03_position,Sw02_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D04_position = NORMAL and D01_position = REVERSE and D03_position = NORMAL) or (D04_position = REVERSE and Sw02_position = REVERSE) or (D04_position = REVERSE and D01_position = REVERSE and D03_position = REVERSE and Sw02_position = NORMAL)) then
					if (D04_position = NORMAL and D01_position = REVERSE and D03_position = NORMAL) then
						path <= 1;
					end if;
					if (D04_position = REVERSE and Sw02_position = REVERSE) then
						path <= 2;
					end if;
					if (D04_position = REVERSE and D01_position = REVERSE and D03_position = REVERSE and Sw02_position = NORMAL) then
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

	process(path,ne295_state,ne384_state,C67_aspect,S84_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne295_state = OCCUPIED or ne295_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C67_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C67_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C67_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C67_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne384_state = OCCUPIED or ne384_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S84_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S84_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S84_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S84_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne384_state = OCCUPIED or ne384_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S84_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S84_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S84_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S84_aspect = GREEN) then
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