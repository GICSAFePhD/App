--  railwaySignal_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			Lc06_state : in hex_char;
			Lc03_state : in hex_char;
			Lc04_state : in hex_char;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne3 : in hex_char;
			correspondence_S25 : out hex_char;
			--Ocupation level 1
			track_ne26 : in hex_char;
			track_ne27 : in hex_char;
			track_ne23 : in hex_char;
			correspondence_X07 : in hex_char;
			correspondence_X12 : in hex_char;
			Sw12_state : in hex_char;
			Sw11_state : in hex_char;
			correspondence_L04 : in hex_char;
			correspondence_P19 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_2;
architecture Behavioral of railwaySignal_2 is
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
	signal Lc06_position : levelCrossingStates := UP;
	signal Lc06_lock : objectLock := RELEASED;
	signal Lc03_position : levelCrossingStates := UP;
	signal Lc03_lock : objectLock := RELEASED;
	signal Lc04_position : levelCrossingStates := UP;
	signal Lc04_lock : objectLock := RELEASED;
	signal Lc09_position : levelCrossingStates := UP;
	signal Lc09_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne26_state : nodeStates := FREE;
	signal ne26_lock : objectLock := RELEASED;
	signal ne27_state : nodeStates := FREE;
	signal ne27_lock : objectLock := RELEASED;
	signal ne23_state : nodeStates := FREE;
	signal ne23_lock : objectLock := RELEASED;
	signal X07_aspect : signalStates;
	signal X07_lock : objectLock := RELEASED;
	signal X12_aspect : signalStates;
	signal X12_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw11_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal Sw11_lock : objectLock := RELEASED;
	signal L04_aspect : signalStates;
	signal L04_lock : objectLock := RELEASED;
	signal P19_aspect : signalStates;
	signal P19_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S25 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc06_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc06_state)(2 to 3))));
	Lc06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc06_state)(0 to 1))));
	Lc03_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc03_state)(2 to 3))));
	Lc03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc03_state)(0 to 1))));
	Lc04_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc04_state)(2 to 3))));
	Lc04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc04_state)(0 to 1))));
	Lc09_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc09_state)(2 to 3))));
	Lc09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc09_state)(0 to 1))));
	--Ocupation level 1
	ne26_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne26)(2 to 3))));
	ne26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne26)(0 to 1))));
	ne27_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne27)(2 to 3))));
	ne27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne27)(0 to 1))));
	ne23_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne23)(2 to 3))));
	ne23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne23)(0 to 1))));
	X07_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X07)(2 to 3))));
	X07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X07)(0 to 1))));
	X12_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X12)(2 to 3))));
	X12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X12)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw11_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw11_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	Sw11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw11_state)(0 to 1))));
	L04_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L04)(2 to 3))));
	L04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L04)(0 to 1))));
	P19_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P19)(2 to 3))));
	P19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P19)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R12_command,R13_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R12_command = RELEASE and R13_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R12_command = RESERVE or R13_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R12_command = LOCK or R13_command = LOCK) then
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
				if ((Sw12_position = NORMAL and Lc06_position = DOWN and Lc06_position = DOWN and Lc03_position = DOWN and Lc04_position = DOWN) or (Sw11_position = REVERSE and Sw12_position = REVERSE and Lc06_position = DOWN and Lc06_position = DOWN and Lc09_position = DOWN)) then
					if (Sw12_position = NORMAL and Lc06_position = DOWN and Lc06_position = DOWN and Lc03_position = DOWN and Lc04_position = DOWN) then
						path <= 1;
					end if;
					if (Sw11_position = REVERSE and Sw12_position = REVERSE and Lc06_position = DOWN and Lc06_position = DOWN and Lc09_position = DOWN) then
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

	process(path,ne26_state,ne27_state,ne23_state,X07_aspect,X12_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne26_state = OCCUPIED or ne26_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (X07_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (X07_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (X07_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (X07_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne27_state = OCCUPIED or ne27_lock = LOCKED or ne23_state = OCCUPIED or ne23_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (X12_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (X12_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (X12_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (X12_aspect = GREEN) then
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