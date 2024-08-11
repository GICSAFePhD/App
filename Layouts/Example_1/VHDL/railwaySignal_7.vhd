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
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R15_command : in routeCommands;
			--Ocupation level 0
			track_ne12 : in hex_char;
			correspondence_S35 : out hex_char;
			--Ocupation level 1
			track_ne23 : in hex_char;
			track_ne24 : in hex_char;
			track_ne8 : in hex_char;
			correspondence_J14 : in hex_char;
			correspondence_C21 : in hex_char;
			Sw13_state : in hex_char;
			Sw12_state : in hex_char;
			--Ocupation level 2
			track_ne1 : in hex_char;
			correspondence_L07 : in hex_char;
			Sw04_state : in hex_char;
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
	--Ocupation level 1
	signal ne23_state : nodeStates := FREE;
	signal ne23_lock : objectLock := RELEASED;
	signal ne24_state : nodeStates := FREE;
	signal ne24_lock : objectLock := RELEASED;
	signal ne8_state : nodeStates := FREE;
	signal ne8_lock : objectLock := RELEASED;
	signal J14_aspect : signalStates;
	signal J14_lock : objectLock := RELEASED;
	signal C21_aspect : signalStates;
	signal C21_lock : objectLock := RELEASED;
	signal Sw13_position : singleSwitchStates := NORMAL;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw13_lock : objectLock := RELEASED;
	signal Sw12_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne1_state : nodeStates := FREE;
	signal ne1_lock : objectLock := RELEASED;
	signal L07_aspect : signalStates;
	signal L07_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S35 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne23_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne23)(2 to 3))));
	ne23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne23)(0 to 1))));
	ne24_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne24)(2 to 3))));
	ne24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne24)(0 to 1))));
	ne8_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne8)(2 to 3))));
	ne8_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne8)(0 to 1))));
	J14_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J14)(2 to 3))));
	J14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J14)(0 to 1))));
	C21_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C21)(2 to 3))));
	C21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C21)(0 to 1))));
	Sw13_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw13_state)(2 to 3))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw13_state)(0 to 1))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	--Ocupation level 2
	ne1_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne1)(2 to 3))));
	ne1_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne1)(0 to 1))));
	L07_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L07)(2 to 3))));
	L07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L07)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R20_command,R21_command,R15_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R20_command = RELEASE and R21_command = RELEASE and R15_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R20_command = RESERVE or R21_command = RESERVE or R15_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R20_command = LOCK or R21_command = LOCK or R15_command = LOCK) then
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

	process(commandState,Sw12_position,Sw13_position,Sw04_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw13_position = NORMAL) or (Sw12_position = REVERSE and Sw13_position = REVERSE and Sw04_position = NORMAL)) then
					if (Sw13_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw12_position = REVERSE and Sw13_position = REVERSE and Sw04_position = NORMAL) then
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

	process(path,ne23_state,ne24_state,ne8_state,J14_aspect,C21_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne23_state = OCCUPIED or ne23_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J14_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J14_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J14_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J14_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne24_state = OCCUPIED or ne24_lock = LOCKED or ne8_state = OCCUPIED or ne8_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C21_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C21_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C21_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C21_aspect = GREEN) then
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