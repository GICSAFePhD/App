--  railwaySignal_45.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_45 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R37_command : in routeCommands;
			R38_command : in routeCommands;
			R32_command : in routeCommands;
			--Ocupation level 0
			track_ne101 : in hex_char;
			correspondence_S59 : out hex_char;
			--Ocupation level 1
			track_ne912 : in hex_char;
			track_ne910 : in hex_char;
			correspondence_S110 : in hex_char;
			correspondence_S81 : in hex_char;
			D09_state : in hex_char;
			--Ocupation level 2
			track_ne131 : in hex_char;
			track_ne132 : in hex_char;
			track_ne465 : in hex_char;
			track_ne130 : in hex_char;
			track_ne135 : in hex_char;
			correspondence_T09 : in hex_char;
			correspondence_J46 : in hex_char;
			correspondence_S107 : in hex_char;
			correspondence_B80 : in hex_char;
			D20_state : in hex_char;
			D21_state : in hex_char;
			D10_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_45;
architecture Behavioral of railwaySignal_45 is
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
	signal ne912_state : nodeStates := FREE;
	signal ne912_lock : objectLock := RELEASED;
	signal ne910_state : nodeStates := FREE;
	signal ne910_lock : objectLock := RELEASED;
	signal S110_aspect : signalStates;
	signal S110_lock : objectLock := RELEASED;
	signal S81_aspect : signalStates;
	signal S81_lock : objectLock := RELEASED;
	signal D09_position : singleSwitchStates := NORMAL;
	signal D09_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne131_state : nodeStates := FREE;
	signal ne131_lock : objectLock := RELEASED;
	signal ne132_state : nodeStates := FREE;
	signal ne132_lock : objectLock := RELEASED;
	signal ne465_state : nodeStates := FREE;
	signal ne465_lock : objectLock := RELEASED;
	signal ne130_state : nodeStates := FREE;
	signal ne130_lock : objectLock := RELEASED;
	signal ne135_state : nodeStates := FREE;
	signal ne135_lock : objectLock := RELEASED;
	signal T09_aspect : signalStates;
	signal T09_lock : objectLock := RELEASED;
	signal J46_aspect : signalStates;
	signal J46_lock : objectLock := RELEASED;
	signal S107_aspect : signalStates;
	signal S107_lock : objectLock := RELEASED;
	signal B80_aspect : signalStates;
	signal B80_lock : objectLock := RELEASED;
	signal D20_position : singleSwitchStates := NORMAL;
	signal D21_position : singleSwitchStates := NORMAL;
	signal D10_position : singleSwitchStates := NORMAL;
	signal D20_lock : objectLock := RELEASED;
	signal D21_lock : objectLock := RELEASED;
	signal D10_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S59 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne912_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne912)(2 to 3))));
	ne912_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne912)(0 to 1))));
	ne910_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne910)(2 to 3))));
	ne910_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne910)(0 to 1))));
	S110_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S110)(2 to 3))));
	S110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S110)(0 to 1))));
	S81_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S81)(2 to 3))));
	S81_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S81)(0 to 1))));
	D09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D09_state)(2 to 3))));
	D09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D09_state)(0 to 1))));
	--Ocupation level 2
	ne131_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne131)(2 to 3))));
	ne131_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne131)(0 to 1))));
	ne132_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne132)(2 to 3))));
	ne132_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne132)(0 to 1))));
	ne465_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne465)(2 to 3))));
	ne465_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne465)(0 to 1))));
	ne130_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne130)(2 to 3))));
	ne130_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne130)(0 to 1))));
	ne135_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne135)(2 to 3))));
	ne135_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne135)(0 to 1))));
	T09_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T09)(2 to 3))));
	T09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T09)(0 to 1))));
	J46_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J46)(2 to 3))));
	J46_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J46)(0 to 1))));
	S107_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S107)(2 to 3))));
	S107_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S107)(0 to 1))));
	B80_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B80)(2 to 3))));
	B80_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B80)(0 to 1))));
	D20_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D20_state)(2 to 3))));
	D21_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D21_state)(2 to 3))));
	D10_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D10_state)(2 to 3))));
	D20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D20_state)(0 to 1))));
	D21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D21_state)(0 to 1))));
	D10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D10_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R37_command,R38_command,R32_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R37_command = RELEASE and R38_command = RELEASE and R32_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R37_command = RESERVE or R38_command = RESERVE or R32_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R37_command = LOCK or R38_command = LOCK or R32_command = LOCK) then
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

	process(commandState,D09_position,D10_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D09_position = NORMAL and D20_position = REVERSE and D21_position = REVERSE) or (D09_position = NORMAL and D20_position = NORMAL) or (D09_position = REVERSE and D10_position = NORMAL) or (D09_position = REVERSE and D10_position = REVERSE)) then
					if (D09_position = NORMAL and D20_position = REVERSE and D21_position = REVERSE) then
						path <= 1;
					end if;
					if (D09_position = NORMAL and D20_position = NORMAL) then
						path <= 2;
					end if;
					if (D09_position = REVERSE and D10_position = NORMAL) then
						path <= 3;
					end if;
					if (D09_position = REVERSE and D10_position = REVERSE) then
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

	process(path,ne912_state,ne910_state,S110_aspect,S81_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne912_state = OCCUPIED or ne912_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S110_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S110_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S110_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S110_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne912_state = OCCUPIED or ne912_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S110_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S110_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S110_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S110_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne910_state = OCCUPIED or ne910_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S81_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S81_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S81_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S81_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 4 =>
				if (ne910_state = OCCUPIED or ne910_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S81_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S81_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S81_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S81_aspect = GREEN) then
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