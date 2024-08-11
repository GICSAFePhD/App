--  railwaySignal_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R39_command : in routeCommands;
			R40_command : in routeCommands;
			R26_command : in routeCommands;
			--Ocupation level 0
			track_ne9 : in hex_char;
			correspondence_S80 : out hex_char;
			--Ocupation level 1
			track_ne1 : in hex_char;
			track_ne7 : in hex_char;
			correspondence_T01 : in hex_char;
			correspondence_T05 : in hex_char;
			s68W02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_9;
architecture Behavioral of railwaySignal_9 is
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
	signal ne1_state : nodeStates := FREE;
	signal ne1_lock : objectLock := RELEASED;
	signal ne7_state : nodeStates := FREE;
	signal ne7_lock : objectLock := RELEASED;
	signal T01_aspect : signalStates;
	signal T01_lock : objectLock := RELEASED;
	signal T05_aspect : signalStates;
	signal T05_lock : objectLock := RELEASED;
	signal s68W02_position : singleSwitchStates := NORMAL;
	signal s68W02_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S80 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne1_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne1)(2 to 3))));
	ne1_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne1)(0 to 1))));
	ne7_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne7)(2 to 3))));
	ne7_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne7)(0 to 1))));
	T01_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(2 to 3))));
	T01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(0 to 1))));
	T05_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(2 to 3))));
	T05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(0 to 1))));
	s68W02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s68W02_state)(2 to 3))));
	s68W02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s68W02_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R39_command,R40_command,R26_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R39_command = RELEASE and R40_command = RELEASE and R26_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R39_command = RESERVE or R40_command = RESERVE or R26_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R39_command = LOCK or R40_command = LOCK or R26_command = LOCK) then
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

	process(commandState,s68W02_position)
	begin
		case commandState is
			when RELEASE =>
				if ((s68W02_position = NORMAL) or (s68W02_position = REVERSE)) then
					if (s68W02_position = NORMAL) then
						path <= 1;
					end if;
					if (s68W02_position = REVERSE) then
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

	process(path,ne1_state,ne7_state,T01_aspect,T05_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne1_state = OCCUPIED or ne1_lock = LOCKED) then
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
			when 2 =>
				if (ne7_state = OCCUPIED or ne7_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T05_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T05_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T05_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T05_aspect = GREEN) then
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