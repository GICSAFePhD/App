--  railwaySignal_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			Lc08_state : in hex_char;
			--Ocupation level 0
			track_ne2 : in hex_char;
			correspondence_S27 : out hex_char;
			--Ocupation level 1
			track_ne12 : in hex_char;
			track_ne13 : in hex_char;
			correspondence_S35 : in hex_char;
			correspondence_T01 : in hex_char;
			Sw06_state : in hex_char;
			--Ocupation level 2
			track_ne24 : in hex_char;
			track_ne8 : in hex_char;
			track_ne23 : in hex_char;
			correspondence_J14 : in hex_char;
			correspondence_C21 : in hex_char;
			Sw13_state : in hex_char;
			Sw12_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_3;
architecture Behavioral of railwaySignal_3 is
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
	signal Lc08_position : levelCrossingStates := UP;
	signal Lc08_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne12_state : nodeStates := FREE;
	signal ne12_lock : objectLock := RELEASED;
	signal ne13_state : nodeStates := FREE;
	signal ne13_lock : objectLock := RELEASED;
	signal S35_aspect : signalStates;
	signal S35_lock : objectLock := RELEASED;
	signal T01_aspect : signalStates;
	signal T01_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne24_state : nodeStates := FREE;
	signal ne24_lock : objectLock := RELEASED;
	signal ne8_state : nodeStates := FREE;
	signal ne8_lock : objectLock := RELEASED;
	signal ne23_state : nodeStates := FREE;
	signal ne23_lock : objectLock := RELEASED;
	signal J14_aspect : signalStates;
	signal J14_lock : objectLock := RELEASED;
	signal C21_aspect : signalStates;
	signal C21_lock : objectLock := RELEASED;
	signal Sw13_position : singleSwitchStates := NORMAL;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw13_lock : objectLock := RELEASED;
	signal Sw12_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S27 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc08_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc08_state)(2 to 3))));
	Lc08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc08_state)(0 to 1))));
	--Ocupation level 1
	ne12_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne12)(2 to 3))));
	ne12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne12)(0 to 1))));
	ne13_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne13)(2 to 3))));
	ne13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne13)(0 to 1))));
	S35_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S35)(2 to 3))));
	S35_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S35)(0 to 1))));
	T01_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(2 to 3))));
	T01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	--Ocupation level 2
	ne24_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne24)(2 to 3))));
	ne24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne24)(0 to 1))));
	ne8_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne8)(2 to 3))));
	ne8_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne8)(0 to 1))));
	ne23_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne23)(2 to 3))));
	ne23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne23)(0 to 1))));
	J14_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J14)(2 to 3))));
	J14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J14)(0 to 1))));
	C21_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C21)(2 to 3))));
	C21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C21)(0 to 1))));
	Sw13_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw13_state)(2 to 3))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw13_state)(0 to 1))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R15_command,R16_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R15_command = RELEASE and R16_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R15_command = RESERVE or R16_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R15_command = LOCK or R16_command = LOCK) then
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

	process(commandState,Sw06_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw06_position = NORMAL and Sw13_position = NORMAL) or (Sw06_position = NORMAL and Sw12_position = REVERSE and Sw13_position = REVERSE) or (Sw06_position = REVERSE and Lc08_position = DOWN)) then
					if (Sw06_position = NORMAL and Sw13_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw06_position = NORMAL and Sw12_position = REVERSE and Sw13_position = REVERSE) then
						path <= 2;
					end if;
					if (Sw06_position = REVERSE and Lc08_position = DOWN) then
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

	process(path,ne12_state,ne13_state,S35_aspect,T01_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne12_state = OCCUPIED or ne12_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S35_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S35_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S35_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S35_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne12_state = OCCUPIED or ne12_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S35_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S35_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S35_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S35_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne13_state = OCCUPIED or ne13_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T01_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T01_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T01_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T01_aspect = GREEN) then
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