--  railwaySignal_65.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_65 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R20_command : in routeCommands;
			R12_command : in routeCommands;
			--Ocupation level 0
			track_ne101 : in hex_char;
			correspondence_L40 : out hex_char;
			--Ocupation level 1
			track_ne100 : in hex_char;
			correspondence_S139 : in hex_char;
			--Ocupation level 2
			track_ne85 : in hex_char;
			track_ne110 : in hex_char;
			correspondence_S102 : in hex_char;
			correspondence_S131 : in hex_char;
			Sw41_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_65;
architecture Behavioral of railwaySignal_65 is
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
	signal ne100_state : nodeStates := FREE;
	signal ne100_lock : objectLock := RELEASED;
	signal S139_aspect : signalStates;
	signal S139_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne85_state : nodeStates := FREE;
	signal ne85_lock : objectLock := RELEASED;
	signal ne110_state : nodeStates := FREE;
	signal ne110_lock : objectLock := RELEASED;
	signal S102_aspect : signalStates;
	signal S102_lock : objectLock := RELEASED;
	signal S131_aspect : signalStates;
	signal S131_lock : objectLock := RELEASED;
	signal Sw41_position : singleSwitchStates := NORMAL;
	signal Sw41_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_L40 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne100_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne100)(2 to 3))));
	ne100_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne100)(0 to 1))));
	S139_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S139)(2 to 3))));
	S139_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S139)(0 to 1))));
	--Ocupation level 2
	ne85_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne85)(2 to 3))));
	ne85_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne85)(0 to 1))));
	ne110_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne110)(2 to 3))));
	ne110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne110)(0 to 1))));
	S102_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S102)(2 to 3))));
	S102_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S102)(0 to 1))));
	S131_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S131)(2 to 3))));
	S131_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S131)(0 to 1))));
	Sw41_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw41_state)(2 to 3))));
	Sw41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw41_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R20_command,R12_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R20_command = RELEASE and R12_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R20_command = RESERVE or R12_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R20_command = LOCK or R12_command = LOCK) then
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

	process(commandState,Sw41_position,Sw41_position)
	begin
		case commandState is

				if ((Sw41_position = NORMAL and Sw41_position = REVERSE) or (Sw41_position = NORMAL and Sw41_position = REVERSE)) then
					if (Sw41_position = NORMAL and Sw41_position = REVERSE) then
						path <= 1;
					end if;
					if (Sw41_position = NORMAL and Sw41_position = REVERSE) then
						path <= 2;
					end if;
				else
					path <= 0;
				end if;

				path <= 3;

				path <= 0;

				path <= 0;
		end case;
	end process;

	process(path,ne100_state,S139_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne100_state = OCCUPIED or ne100_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S139_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S139_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S139_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S139_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne100_state = OCCUPIED or ne100_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S139_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S139_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S139_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S139_aspect = GREEN) then
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