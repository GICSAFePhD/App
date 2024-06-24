--  railwaySignal_10.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R16_command : in routeCommands;
			Lc11_state : in hex_char;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne40 : in hex_char;
			correspondence_S36 : out hex_char;
			--Ocupation level 1
			track_ne46 : in hex_char;
			track_ne48 : in hex_char;
			track_ne49 : in hex_char;
			track_ne50 : in hex_char;
			correspondence_J09 : in hex_char;
			correspondence_J05 : in hex_char;
			correspondence_J07 : in hex_char;
			Sw27_state : in hex_char;
			Sw29_state : in hex_char;
			correspondence_X31 : in hex_char;
			correspondence_J11 : in hex_char;
			correspondence_J13 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_10;
architecture Behavioral of railwaySignal_10 is
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
	signal Lc11_position : levelCrossingStates := UP;
	signal Lc11_lock : objectLock := RELEASED;
	signal Lc09_position : levelCrossingStates := UP;
	signal Lc09_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne46_state : nodeStates := FREE;
	signal ne46_lock : objectLock := RELEASED;
	signal ne48_state : nodeStates := FREE;
	signal ne48_lock : objectLock := RELEASED;
	signal ne49_state : nodeStates := FREE;
	signal ne49_lock : objectLock := RELEASED;
	signal ne50_state : nodeStates := FREE;
	signal ne50_lock : objectLock := RELEASED;
	signal J09_aspect : signalStates;
	signal J09_lock : objectLock := RELEASED;
	signal J05_aspect : signalStates;
	signal J05_lock : objectLock := RELEASED;
	signal J07_aspect : signalStates;
	signal J07_lock : objectLock := RELEASED;
	signal Sw27_position : singleSwitchStates := NORMAL;
	signal Sw29_position : singleSwitchStates := NORMAL;
	signal Sw27_lock : objectLock := RELEASED;
	signal Sw29_lock : objectLock := RELEASED;
	signal X31_aspect : signalStates;
	signal X31_lock : objectLock := RELEASED;
	signal J11_aspect : signalStates;
	signal J11_lock : objectLock := RELEASED;
	signal J13_aspect : signalStates;
	signal J13_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S36 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc11_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc11_state)(2 to 3))));
	Lc11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc11_state)(0 to 1))));
	Lc09_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc09_state)(2 to 3))));
	Lc09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc09_state)(0 to 1))));
	--Ocupation level 1
	ne46_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne46)(2 to 3))));
	ne46_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne46)(0 to 1))));
	ne48_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne48)(2 to 3))));
	ne48_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne48)(0 to 1))));
	ne49_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne49)(2 to 3))));
	ne49_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne49)(0 to 1))));
	ne50_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne50)(2 to 3))));
	ne50_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne50)(0 to 1))));
	J09_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J09)(2 to 3))));
	J09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J09)(0 to 1))));
	J05_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J05)(2 to 3))));
	J05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J05)(0 to 1))));
	J07_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J07)(2 to 3))));
	J07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J07)(0 to 1))));
	Sw27_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw27_state)(2 to 3))));
	Sw29_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw29_state)(2 to 3))));
	Sw27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw27_state)(0 to 1))));
	Sw29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw29_state)(0 to 1))));
	X31_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X31)(2 to 3))));
	X31_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X31)(0 to 1))));
	J11_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J11)(2 to 3))));
	J11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J11)(0 to 1))));
	J13_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J13)(2 to 3))));
	J13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J13)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R20_command,R21_command,R22_command,R16_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R20_command = RELEASE and R21_command = RELEASE and R22_command = RELEASE and R16_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R20_command = RESERVE or R21_command = RESERVE or R22_command = RESERVE or R16_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R20_command = LOCK or R21_command = LOCK or R22_command = LOCK or R16_command = LOCK) then
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

	process(commandState)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw27_position = NORMAL) or (Sw27_position = REVERSE and Sw29_position = NORMAL and Lc11_position = DOWN) or (Sw27_position = REVERSE and Sw29_position = REVERSE and Lc09_position = DOWN)) then
					if (Sw27_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw27_position = REVERSE and Sw29_position = NORMAL and Lc11_position = DOWN) then
						path <= 2;
					end if;
					if (Sw27_position = REVERSE and Sw29_position = REVERSE and Lc09_position = DOWN) then
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

	process(path,ne46_state,ne48_state,ne49_state,ne50_state,J09_aspect,J05_aspect,J07_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne46_state = OCCUPIED or ne46_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J09_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J09_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J09_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J09_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne48_state = OCCUPIED or ne48_lock = LOCKED or ne49_state = OCCUPIED or ne49_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J05_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J05_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J05_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J05_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne48_state = OCCUPIED or ne48_lock = LOCKED or ne50_state = OCCUPIED or ne50_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J07_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J07_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J07_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J07_aspect = GREEN) then
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