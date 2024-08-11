--  railwaySignal_42.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_42 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R32_command : in routeCommands;
			R19_command : in routeCommands;
			Lc04_state : in hex_char;
			--Ocupation level 0
			track_ne100 : in hex_char;
			correspondence_X52 : out hex_char;
			--Ocupation level 1
			track_ne101 : in hex_char;
			correspondence_S59 : in hex_char;
			--Ocupation level 2
			track_ne910 : in hex_char;
			track_ne912 : in hex_char;
			correspondence_S110 : in hex_char;
			correspondence_S81 : in hex_char;
			D09_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_42;
architecture Behavioral of railwaySignal_42 is
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
	signal Lc04_position : levelCrossingStates := UP;
	signal Lc04_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal S59_aspect : signalStates;
	signal S59_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne910_state : nodeStates := FREE;
	signal ne910_lock : objectLock := RELEASED;
	signal ne912_state : nodeStates := FREE;
	signal ne912_lock : objectLock := RELEASED;
	signal S110_aspect : signalStates;
	signal S110_lock : objectLock := RELEASED;
	signal S81_aspect : signalStates;
	signal S81_lock : objectLock := RELEASED;
	signal D09_position : singleSwitchStates := NORMAL;
	signal D09_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_X52 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc04_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc04_state)(2 to 3))));
	Lc04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc04_state)(0 to 1))));
	--Ocupation level 1
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	S59_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S59)(2 to 3))));
	S59_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S59)(0 to 1))));
	--Ocupation level 2
	ne910_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne910)(2 to 3))));
	ne910_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne910)(0 to 1))));
	ne912_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne912)(2 to 3))));
	ne912_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne912)(0 to 1))));
	S110_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S110)(2 to 3))));
	S110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S110)(0 to 1))));
	S81_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S81)(2 to 3))));
	S81_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S81)(0 to 1))));
	D09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D09_state)(2 to 3))));
	D09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D09_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R32_command,R19_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R32_command = RELEASE and R19_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R32_command = RESERVE or R19_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R32_command = LOCK or R19_command = LOCK) then
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

	process(commandState,D09_position,D09_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D09_position = NORMAL and D09_position = REVERSE and Lc04_position = DOWN) or (D09_position = NORMAL and D09_position = REVERSE and Lc04_position = DOWN)) then
					if (D09_position = NORMAL and D09_position = REVERSE and Lc04_position = DOWN) then
						path <= 1;
					end if;
					if (D09_position = NORMAL and D09_position = REVERSE and Lc04_position = DOWN) then
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

	process(path,ne101_state,S59_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne101_state = OCCUPIED or ne101_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S59_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S59_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S59_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S59_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne101_state = OCCUPIED or ne101_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S59_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S59_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S59_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S59_aspect = GREEN) then
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