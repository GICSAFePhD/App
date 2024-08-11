--  railwaySignal_50.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_50 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			--Ocupation level 0
			track_ne89 : in hex_char;
			correspondence_T20 : out hex_char;
			--Ocupation level 1
			track_ne30 : in hex_char;
			correspondence_S97 : in hex_char;
			Sw12_state : in hex_char;
			--Ocupation level 2
			track_ne83 : in hex_char;
			track_ne29 : in hex_char;
			track_ne110 : in hex_char;
			correspondence_C138 : in hex_char;
			correspondence_C114 : in hex_char;
			Sw08_state : in hex_char;
			Sw09_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_50;
architecture Behavioral of railwaySignal_50 is
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
	signal ne30_state : nodeStates := FREE;
	signal ne30_lock : objectLock := RELEASED;
	signal S97_aspect : signalStates;
	signal S97_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne83_state : nodeStates := FREE;
	signal ne83_lock : objectLock := RELEASED;
	signal ne29_state : nodeStates := FREE;
	signal ne29_lock : objectLock := RELEASED;
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal C138_aspect : signalStates;
	signal C138_lock : objectLock := RELEASED;
	signal C114_aspect : signalStates;
	signal C114_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw09_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
	signal Sw09_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_T20 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne30_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne30)(2 to 3))));
	ne30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne30)(0 to 1))));
	S97_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S97)(2 to 3))));
	S97_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S97)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	--Ocupation level 2
	ne83_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne83)(2 to 3))));
	ne83_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne83)(0 to 1))));
	ne29_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne29)(2 to 3))));
	ne29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne29)(0 to 1))));
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	C138_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C138)(2 to 3))));
	C138_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C138)(0 to 1))));
	C114_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C114)(2 to 3))));
	C114_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C114)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw09_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	Sw09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw09_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R7_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R7_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R7_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R7_command = LOCK) then
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

	process(commandState,Sw12_position,Sw08_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw12_position = NORMAL and Sw08_position = REVERSE and Sw09_position = REVERSE) or (Sw12_position = NORMAL and Sw08_position = NORMAL)) then
					if (Sw12_position = NORMAL and Sw08_position = REVERSE and Sw09_position = REVERSE) then
						path <= 1;
					end if;
					if (Sw12_position = NORMAL and Sw08_position = NORMAL) then
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

	process(path,ne30_state,S97_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne30_state = OCCUPIED or ne30_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S97_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S97_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S97_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S97_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne30_state = OCCUPIED or ne30_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S97_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S97_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S97_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S97_aspect = GREEN) then
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