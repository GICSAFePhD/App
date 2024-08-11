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
			R39_command : in routeCommands;
			R40_command : in routeCommands;
			R1_command : in routeCommands;
			--Ocupation level 0
			track_ne991 : in hex_char;
			correspondence_S64 : out hex_char;
			--Ocupation level 1
			track_ne288 : in hex_char;
			track_ne290 : in hex_char;
			correspondence_S69 : in hex_char;
			correspondence_S86 : in hex_char;
			D01_state : in hex_char;
			--Ocupation level 2
			track_ne295 : in hex_char;
			track_ne110 : in hex_char;
			track_ne292 : in hex_char;
			track_ne111 : in hex_char;
			track_ne377 : in hex_char;
			correspondence_C70 : in hex_char;
			correspondence_B68 : in hex_char;
			correspondence_J36 : in hex_char;
			correspondence_T03 : in hex_char;
			D03_state : in hex_char;
			D14_state : in hex_char;
			D15_state : in hex_char;
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
	--Ocupation level 1
	signal ne288_state : nodeStates := FREE;
	signal ne288_lock : objectLock := RELEASED;
	signal ne290_state : nodeStates := FREE;
	signal ne290_lock : objectLock := RELEASED;
	signal S69_aspect : signalStates;
	signal S69_lock : objectLock := RELEASED;
	signal S86_aspect : signalStates;
	signal S86_lock : objectLock := RELEASED;
	signal D01_position : singleSwitchStates := NORMAL;
	signal D01_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne295_state : nodeStates := FREE;
	signal ne295_lock : objectLock := RELEASED;
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal ne292_state : nodeStates := FREE;
	signal ne292_lock : objectLock := RELEASED;
	signal ne111_state : nodeStates := FREE;
	signal ne111_lock : objectLock := RELEASED;
	signal ne377_state : nodeStates := FREE;
	signal ne377_lock : objectLock := RELEASED;
	signal C70_aspect : signalStates;
	signal C70_lock : objectLock := RELEASED;
	signal B68_aspect : signalStates;
	signal B68_lock : objectLock := RELEASED;
	signal J36_aspect : signalStates;
	signal J36_lock : objectLock := RELEASED;
	signal T03_aspect : signalStates;
	signal T03_lock : objectLock := RELEASED;
	signal D03_position : singleSwitchStates := NORMAL;
	signal D14_position : singleSwitchStates := NORMAL;
	signal D15_position : singleSwitchStates := NORMAL;
	signal D03_lock : objectLock := RELEASED;
	signal D14_lock : objectLock := RELEASED;
	signal D15_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S64 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne288_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne288)(2 to 3))));
	ne288_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne288)(0 to 1))));
	ne290_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne290)(2 to 3))));
	ne290_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne290)(0 to 1))));
	S69_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S69)(2 to 3))));
	S69_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S69)(0 to 1))));
	S86_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S86)(2 to 3))));
	S86_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S86)(0 to 1))));
	D01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D01_state)(2 to 3))));
	D01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D01_state)(0 to 1))));
	--Ocupation level 2
	ne295_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne295)(2 to 3))));
	ne295_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne295)(0 to 1))));
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	ne292_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne292)(2 to 3))));
	ne292_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne292)(0 to 1))));
	ne111_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne111)(2 to 3))));
	ne111_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne111)(0 to 1))));
	ne377_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne377)(2 to 3))));
	ne377_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne377)(0 to 1))));
	C70_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C70)(2 to 3))));
	C70_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C70)(0 to 1))));
	B68_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B68)(2 to 3))));
	B68_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B68)(0 to 1))));
	J36_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J36)(2 to 3))));
	J36_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J36)(0 to 1))));
	T03_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T03)(2 to 3))));
	T03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T03)(0 to 1))));
	D03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D03_state)(2 to 3))));
	D14_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D14_state)(2 to 3))));
	D15_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D15_state)(2 to 3))));
	D03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D03_state)(0 to 1))));
	D14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D14_state)(0 to 1))));
	D15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D15_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R39_command,R40_command,R1_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R39_command = RELEASE and R40_command = RELEASE and R1_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R39_command = RESERVE or R40_command = RESERVE or R1_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R39_command = LOCK or R40_command = LOCK or R1_command = LOCK) then
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

	process(commandState,D01_position,D14_position,D15_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D01_position = REVERSE and D03_position = NORMAL) or (D01_position = REVERSE and D03_position = REVERSE) or (D01_position = NORMAL and D14_position = NORMAL) or (D01_position = NORMAL and D14_position = REVERSE and D15_position = REVERSE)) then
					if (D01_position = REVERSE and D03_position = NORMAL) then
						path <= 1;
					end if;
					if (D01_position = REVERSE and D03_position = REVERSE) then
						path <= 2;
					end if;
					if (D01_position = NORMAL and D14_position = NORMAL) then
						path <= 3;
					end if;
					if (D01_position = NORMAL and D14_position = REVERSE and D15_position = REVERSE) then
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

	process(path,ne288_state,ne290_state,S69_aspect,S86_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne288_state = OCCUPIED or ne288_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S69_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S69_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S69_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S69_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne288_state = OCCUPIED or ne288_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S69_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S69_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S69_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S69_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne290_state = OCCUPIED or ne290_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S86_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S86_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S86_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S86_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 4 =>
				if (ne290_state = OCCUPIED or ne290_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S86_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S86_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S86_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S86_aspect = GREEN) then
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