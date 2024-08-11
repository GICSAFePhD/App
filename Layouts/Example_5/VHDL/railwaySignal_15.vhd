--  railwaySignal_15.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			--Ocupation level 0
			track_ne08 : in hex_char;
			correspondence_T08 : out hex_char;
			--Ocupation level 1
			track_ne06 : in hex_char;
			track_ne07 : in hex_char;
			correspondence_C29 : in hex_char;
			correspondence_B30 : in hex_char;
			Sw04_state : in hex_char;
			--Ocupation level 2
			track_ne05 : in hex_char;
			correspondence_T05 : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_15;
architecture Behavioral of railwaySignal_15 is
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
	signal ne06_state : nodeStates := FREE;
	signal ne06_lock : objectLock := RELEASED;
	signal ne07_state : nodeStates := FREE;
	signal ne07_lock : objectLock := RELEASED;
	signal C29_aspect : signalStates;
	signal C29_lock : objectLock := RELEASED;
	signal B30_aspect : signalStates;
	signal B30_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne05_state : nodeStates := FREE;
	signal ne05_lock : objectLock := RELEASED;
	signal T05_aspect : signalStates;
	signal T05_lock : objectLock := RELEASED;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_T08 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne06_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne06)(2 to 3))));
	ne06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne06)(0 to 1))));
	ne07_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne07)(2 to 3))));
	ne07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne07)(0 to 1))));
	C29_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C29)(2 to 3))));
	C29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C29)(0 to 1))));
	B30_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B30)(2 to 3))));
	B30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B30)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	--Ocupation level 2
	ne05_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne05)(2 to 3))));
	ne05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne05)(0 to 1))));
	T05_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(2 to 3))));
	T05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(0 to 1))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R7_command,R8_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R7_command = RELEASE and R8_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R7_command = RESERVE or R8_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R7_command = LOCK or R8_command = LOCK) then
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

	process(commandState,Sw04_position,Sw03_position)
	begin
		case commandState is

				if ((Sw04_position = NORMAL and Sw03_position = NORMAL) or (Sw04_position = REVERSE and Sw03_position = REVERSE)) then
					if (Sw04_position = NORMAL and Sw03_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw04_position = REVERSE and Sw03_position = REVERSE) then
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

	process(path,ne06_state,ne07_state,C29_aspect,B30_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne06_state = OCCUPIED or ne06_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C29_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C29_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C29_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C29_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne07_state = OCCUPIED or ne07_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B30_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B30_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B30_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B30_aspect = GREEN) then
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
		if (reset = '1' or Q = "011010000100111011100001011111") then
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