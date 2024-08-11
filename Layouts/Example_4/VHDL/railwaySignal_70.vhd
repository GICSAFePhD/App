--  railwaySignal_70.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_70 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R80_command : in routeCommands;
			R81_command : in routeCommands;
			R33_command : in routeCommands;
			--Ocupation level 0
			track_ne992 : in hex_char;
			correspondence_S120 : out hex_char;
			--Ocupation level 1
			track_ne65 : in hex_char;
			track_ne994 : in hex_char;
			track_ne400 : in hex_char;
			correspondence_C94 : in hex_char;
			correspondence_S74 : in hex_char;
			Sw01_state : in hex_char;
			Sw05_state : in hex_char;
			--Ocupation level 2
			track_ne63 : in hex_char;
			track_ne407 : in hex_char;
			track_ne404 : in hex_char;
			correspondence_C54 : in hex_char;
			correspondence_C76 : in hex_char;
			correspondence_S93 : in hex_char;
			D18_state : in hex_char;
			D07_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_70;
architecture Behavioral of railwaySignal_70 is
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
	signal ne65_state : nodeStates := FREE;
	signal ne65_lock : objectLock := RELEASED;
	signal ne994_state : nodeStates := FREE;
	signal ne994_lock : objectLock := RELEASED;
	signal ne400_state : nodeStates := FREE;
	signal ne400_lock : objectLock := RELEASED;
	signal C94_aspect : signalStates;
	signal C94_lock : objectLock := RELEASED;
	signal S74_aspect : signalStates;
	signal S74_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw05_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
	signal Sw05_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne63_state : nodeStates := FREE;
	signal ne63_lock : objectLock := RELEASED;
	signal ne407_state : nodeStates := FREE;
	signal ne407_lock : objectLock := RELEASED;
	signal ne404_state : nodeStates := FREE;
	signal ne404_lock : objectLock := RELEASED;
	signal C54_aspect : signalStates;
	signal C54_lock : objectLock := RELEASED;
	signal C76_aspect : signalStates;
	signal C76_lock : objectLock := RELEASED;
	signal S93_aspect : signalStates;
	signal S93_lock : objectLock := RELEASED;
	signal D18_position : singleSwitchStates := NORMAL;
	signal D07_position : singleSwitchStates := NORMAL;
	signal D18_lock : objectLock := RELEASED;
	signal D07_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S120 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne65_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne65)(2 to 3))));
	ne65_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne65)(0 to 1))));
	ne994_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne994)(2 to 3))));
	ne994_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne994)(0 to 1))));
	ne400_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne400)(2 to 3))));
	ne400_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne400)(0 to 1))));
	C94_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C94)(2 to 3))));
	C94_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C94)(0 to 1))));
	S74_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S74)(2 to 3))));
	S74_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S74)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	--Ocupation level 2
	ne63_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne63)(2 to 3))));
	ne63_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne63)(0 to 1))));
	ne407_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne407)(2 to 3))));
	ne407_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne407)(0 to 1))));
	ne404_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne404)(2 to 3))));
	ne404_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne404)(0 to 1))));
	C54_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C54)(2 to 3))));
	C54_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C54)(0 to 1))));
	C76_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C76)(2 to 3))));
	C76_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C76)(0 to 1))));
	S93_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S93)(2 to 3))));
	S93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S93)(0 to 1))));
	D18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D18_state)(2 to 3))));
	D07_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D07_state)(2 to 3))));
	D18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D18_state)(0 to 1))));
	D07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D07_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R80_command,R81_command,R33_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R80_command = RELEASE and R81_command = RELEASE and R33_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R80_command = RESERVE or R81_command = RESERVE or R33_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R80_command = LOCK or R81_command = LOCK or R33_command = LOCK) then
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

	process(commandState,Sw01_position,Sw05_position,D07_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw01_position = NORMAL and D18_position = NORMAL) or (Sw01_position = REVERSE and Sw05_position = REVERSE and D07_position = NORMAL) or (Sw01_position = REVERSE and Sw05_position = REVERSE and D07_position = REVERSE)) then
					if (Sw01_position = NORMAL and D18_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw01_position = REVERSE and Sw05_position = REVERSE and D07_position = NORMAL) then
						path <= 2;
					end if;
					if (Sw01_position = REVERSE and Sw05_position = REVERSE and D07_position = REVERSE) then
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

	process(path,ne65_state,ne994_state,ne400_state,C94_aspect,S74_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne65_state = OCCUPIED or ne65_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C94_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C94_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C94_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C94_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne994_state = OCCUPIED or ne994_lock = LOCKED or ne400_state = OCCUPIED or ne400_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S74_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S74_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S74_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S74_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne994_state = OCCUPIED or ne994_lock = LOCKED or ne400_state = OCCUPIED or ne400_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S74_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S74_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S74_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S74_aspect = GREEN) then
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