--  railwaySignal_24.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_24 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R56_command : in routeCommands;
			R5_command : in routeCommands;
			R67_command : in routeCommands;
			R77_command : in routeCommands;
			--Ocupation level 0
			track_ne32 : in hex_char;
			correspondence_C100 : out hex_char;
			--Ocupation level 1
			track_ne110 : in hex_char;
			correspondence_C138 : in hex_char;
			Sw09_state : in hex_char;
			--Ocupation level 2
			track_ne100 : in hex_char;
			track_ne101 : in hex_char;
			track_ne44 : in hex_char;
			correspondence_S105 : in hex_char;
			Sw41_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_24;
architecture Behavioral of railwaySignal_24 is
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
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal C138_aspect : signalStates;
	signal C138_lock : objectLock := RELEASED;
	signal Sw09_position : singleSwitchStates := NORMAL;
	signal Sw09_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal ne44_state : nodeStates := FREE;
	signal ne44_lock : objectLock := RELEASED;
	signal S105_aspect : signalStates;
	signal S105_lock : objectLock := RELEASED;
	signal Sw41_position : singleSwitchStates := NORMAL;
	signal Sw41_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_C100 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	C138_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C138)(2 to 3))));
	C138_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C138)(0 to 1))));
	Sw09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw09_state)(2 to 3))));
	Sw09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw09_state)(0 to 1))));
	--Ocupation level 2
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	ne44_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne44)(2 to 3))));
	ne44_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne44)(0 to 1))));
	S105_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S105)(2 to 3))));
	S105_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S105)(0 to 1))));
	Sw41_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw41_state)(2 to 3))));
	Sw41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw41_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R56_command,R5_command,R67_command,R77_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R56_command = RELEASE and R5_command = RELEASE and R67_command = RELEASE and R77_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R56_command = RESERVE or R5_command = RESERVE or R67_command = RESERVE or R77_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R56_command = LOCK or R5_command = LOCK or R67_command = LOCK or R77_command = LOCK) then
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

	process(commandState,Sw09_position,Sw41_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw09_position = NORMAL and Sw41_position = NORMAL)) then
					if (Sw09_position = NORMAL and Sw41_position = NORMAL) then
						path <= 1;
					end if;
				else
					path <= 0;
				end if;
			when RESERVE =>
				path <= 2;
			when LOCK =>
				path <= 0;
			when others =>
				path <= 0;
		end case;
	end process;

	process(path,ne110_state,C138_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne110_state = OCCUPIED or ne110_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C138_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C138_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C138_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C138_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
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