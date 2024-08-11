--  railwaySignal_17.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_17 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R21_command : in routeCommands;
			R61_command : in routeCommands;
			--Ocupation level 0
			track_ne292 : in hex_char;
			correspondence_J36 : out hex_char;
			--Ocupation level 1
			track_ne996 : in hex_char;
			correspondence_J38 : in hex_char;
			Sw04_state : in hex_char;
			--Ocupation level 2
			track_ne98 : in hex_char;
			correspondence_L30 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_17;
architecture Behavioral of railwaySignal_17 is
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
	signal ne996_state : nodeStates := FREE;
	signal ne996_lock : objectLock := RELEASED;
	signal J38_aspect : signalStates;
	signal J38_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne98_state : nodeStates := FREE;
	signal ne98_lock : objectLock := RELEASED;
	signal L30_aspect : signalStates;
	signal L30_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_J36 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne996_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne996)(2 to 3))));
	ne996_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne996)(0 to 1))));
	J38_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J38)(2 to 3))));
	J38_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J38)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	--Ocupation level 2
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne98_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne98)(0 to 1))));
	L30_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L30)(2 to 3))));
	L30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L30)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R21_command,R61_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R21_command = RELEASE and R61_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R21_command = RESERVE or R61_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R21_command = LOCK or R61_command = LOCK) then
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

	process(commandState,Sw04_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw04_position = NORMAL)) then
					if (Sw04_position = NORMAL) then
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

	process(path,ne996_state,J38_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne996_state = OCCUPIED or ne996_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J38_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J38_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J38_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J38_aspect = GREEN) then
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