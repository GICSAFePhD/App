--  railwaySignal_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R3_command : in routeCommands;
			Lc09_state : in hex_char;
			Lc05_state : in hex_char;
			Lc06_state : in hex_char;
			--Ocupation level 0
			track_ne23 : in hex_char;
			correspondence_S22 : out hex_char;
			--Ocupation level 1
			track_ne25 : in hex_char;
			track_ne27 : in hex_char;
			track_ne3 : in hex_char;
			correspondence_X13 : in hex_char;
			correspondence_X16 : in hex_char;
			Sw11_state : in hex_char;
			Sw12_state : in hex_char;
			correspondence_L03 : in hex_char;
			correspondence_L01 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_7;
architecture Behavioral of railwaySignal_7 is
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
	signal Lc09_position : levelCrossingStates := UP;
	signal Lc09_lock : objectLock := RELEASED;
	signal Lc05_position : levelCrossingStates := UP;
	signal Lc05_lock : objectLock := RELEASED;
	signal Lc06_position : levelCrossingStates := UP;
	signal Lc06_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne25_state : nodeStates := FREE;
	signal ne25_lock : objectLock := RELEASED;
	signal ne27_state : nodeStates := FREE;
	signal ne27_lock : objectLock := RELEASED;
	signal ne3_state : nodeStates := FREE;
	signal ne3_lock : objectLock := RELEASED;
	signal X13_aspect : signalStates;
	signal X13_lock : objectLock := RELEASED;
	signal X16_aspect : signalStates;
	signal X16_lock : objectLock := RELEASED;
	signal Sw11_position : singleSwitchStates := NORMAL;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw11_lock : objectLock := RELEASED;
	signal Sw12_lock : objectLock := RELEASED;
	signal L03_aspect : signalStates;
	signal L03_lock : objectLock := RELEASED;
	signal L01_aspect : signalStates;
	signal L01_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S22 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc09_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc09_state)(2 to 3))));
	Lc09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc09_state)(0 to 1))));
	Lc05_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc05_state)(2 to 3))));
	Lc05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc05_state)(0 to 1))));
	Lc06_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc06_state)(2 to 3))));
	Lc06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc06_state)(0 to 1))));
	--Ocupation level 1
	ne25_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne25)(2 to 3))));
	ne25_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne25)(0 to 1))));
	ne27_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne27)(2 to 3))));
	ne27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne27)(0 to 1))));
	ne3_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne3)(2 to 3))));
	ne3_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne3)(0 to 1))));
	X13_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X13)(2 to 3))));
	X13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X13)(0 to 1))));
	X16_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X16)(2 to 3))));
	X16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X16)(0 to 1))));
	Sw11_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw11_state)(2 to 3))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw11_state)(0 to 1))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	L03_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L03)(2 to 3))));
	L03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L03)(0 to 1))));
	L01_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L01)(2 to 3))));
	L01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L01)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R9_command,R10_command,R3_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R9_command = RELEASE and R10_command = RELEASE and R3_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R9_command = RESERVE or R10_command = RESERVE or R3_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R9_command = LOCK or R10_command = LOCK or R3_command = LOCK) then
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

	process(commandState)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw11_position = NORMAL and Lc09_position = DOWN and Lc09_position = DOWN and Lc05_position = DOWN) or (Sw11_position = REVERSE and Sw12_position = REVERSE and Lc09_position = DOWN and Lc09_position = DOWN and Lc06_position = DOWN)) then
					if (Sw11_position = NORMAL and Lc09_position = DOWN and Lc09_position = DOWN and Lc05_position = DOWN) then
						path <= 1;
					end if;
					if (Sw11_position = REVERSE and Sw12_position = REVERSE and Lc09_position = DOWN and Lc09_position = DOWN and Lc06_position = DOWN) then
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

	process(path,ne25_state,ne27_state,ne3_state,X13_aspect,X16_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne25_state = OCCUPIED or ne25_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (X13_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (X13_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (X13_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (X13_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne27_state = OCCUPIED or ne27_lock = LOCKED or ne3_state = OCCUPIED or ne3_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (X16_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (X16_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (X16_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (X16_aspect = GREEN) then
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
		if (reset = '1' or Q = "011010000100111011100001011111") then
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