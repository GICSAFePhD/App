--  railwaySignal_34.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_34 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R47_command : in routeCommands;
			R48_command : in routeCommands;
			R21_command : in routeCommands;
			--Ocupation level 0
			track_ne64 : in hex_char;
			correspondence_S90 : out hex_char;
			--Ocupation level 1
			track_ne23 : in hex_char;
			track_ne24 : in hex_char;
			correspondence_P60 : in hex_char;
			correspondence_B92 : in hex_char;
			s70W01_state : in hex_char;
			--Ocupation level 2
			track_ne26 : in hex_char;
			correspondence_L27 : in hex_char;
			s70W02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_34;
architecture Behavioral of railwaySignal_34 is
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
	signal P60_aspect : signalStates;
	signal P60_lock : objectLock := RELEASED;
	signal B92_aspect : signalStates;
	signal B92_lock : objectLock := RELEASED;
	signal s70W01_position : singleSwitchStates := NORMAL;
	signal s70W01_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne26_state : nodeStates := FREE;
	signal ne26_lock : objectLock := RELEASED;
	signal L27_aspect : signalStates;
	signal L27_lock : objectLock := RELEASED;
	signal s70W02_position : singleSwitchStates := NORMAL;
	signal s70W02_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S90 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne23_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne23)(2 to 3))));
	ne23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne23)(0 to 1))));
	ne24_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne24)(2 to 3))));
	ne24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne24)(0 to 1))));
	P60_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P60)(2 to 3))));
	P60_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P60)(0 to 1))));
	B92_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B92)(2 to 3))));
	B92_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B92)(0 to 1))));
	s70W01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s70W01_state)(2 to 3))));
	s70W01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s70W01_state)(0 to 1))));
	--Ocupation level 2
	ne26_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne26)(2 to 3))));
	ne26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne26)(0 to 1))));
	L27_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L27)(2 to 3))));
	L27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L27)(0 to 1))));
	s70W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s70W02_state)(2 to 3))));
	s70W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s70W02_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R47_command,R48_command,R21_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R47_command = RELEASE and R48_command = RELEASE and R21_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R47_command = RESERVE or R48_command = RESERVE or R21_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R47_command = LOCK or R48_command = LOCK or R21_command = LOCK) then
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

	process(commandState,s70W01_position,s70W02_position)
	begin
		case commandState is
			when RELEASE =>
				if ((s70W01_position = REVERSE and s70W02_position = NORMAL) or (s70W01_position = NORMAL and s70W02_position = REVERSE)) then
					if (s70W01_position = REVERSE and s70W02_position = NORMAL) then
						path <= 1;
					end if;
					if (s70W01_position = NORMAL and s70W02_position = REVERSE) then
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

	process(path,ne23_state,ne24_state,P60_aspect,B92_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne23_state = OCCUPIED or ne23_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (P60_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (P60_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (P60_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (P60_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne24_state = OCCUPIED or ne24_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B92_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B92_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B92_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B92_aspect = GREEN) then
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