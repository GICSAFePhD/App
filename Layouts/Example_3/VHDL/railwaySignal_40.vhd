--  railwaySignal_40.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_40 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R64_command : in routeCommands;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			R33_command : in routeCommands;
			--Ocupation level 0
			track_ne78 : in hex_char;
			correspondence_S110 : out hex_char;
			--Ocupation level 1
			track_ne17 : in hex_char;
			track_ne79 : in hex_char;
			track_ne77 : in hex_char;
			track_ne21 : in hex_char;
			correspondence_C82 : in hex_char;
			correspondence_B133 : in hex_char;
			correspondence_P72 : in hex_char;
			Sw06_state : in hex_char;
			Sw07_state : in hex_char;
			--Ocupation level 2
			track_ne59 : in hex_char;
			track_ne95 : in hex_char;
			track_ne52 : in hex_char;
			correspondence_X51 : in hex_char;
			correspondence_S86 : in hex_char;
			correspondence_S144 : in hex_char;
			s69W03_state : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_40;
architecture Behavioral of railwaySignal_40 is
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
	signal ne17_state : nodeStates := FREE;
	signal ne17_lock : objectLock := RELEASED;
	signal ne79_state : nodeStates := FREE;
	signal ne79_lock : objectLock := RELEASED;
	signal ne77_state : nodeStates := FREE;
	signal ne77_lock : objectLock := RELEASED;
	signal ne21_state : nodeStates := FREE;
	signal ne21_lock : objectLock := RELEASED;
	signal C82_aspect : signalStates;
	signal C82_lock : objectLock := RELEASED;
	signal B133_aspect : signalStates;
	signal B133_lock : objectLock := RELEASED;
	signal P72_aspect : signalStates;
	signal P72_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw07_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal Sw07_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne59_state : nodeStates := FREE;
	signal ne59_lock : objectLock := RELEASED;
	signal ne95_state : nodeStates := FREE;
	signal ne95_lock : objectLock := RELEASED;
	signal ne52_state : nodeStates := FREE;
	signal ne52_lock : objectLock := RELEASED;
	signal X51_aspect : signalStates;
	signal X51_lock : objectLock := RELEASED;
	signal S86_aspect : signalStates;
	signal S86_lock : objectLock := RELEASED;
	signal S144_aspect : signalStates;
	signal S144_lock : objectLock := RELEASED;
	signal s69W03_position : singleSwitchStates := NORMAL;
	signal Sw03_position : scissorCrossingStates := NORMAL;
	signal s69W03_lock : objectLock := RELEASED;
	signal Sw03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S110 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne17_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne17)(2 to 3))));
	ne17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne17)(0 to 1))));
	ne79_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne79)(2 to 3))));
	ne79_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne79)(0 to 1))));
	ne77_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne77)(2 to 3))));
	ne77_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne77)(0 to 1))));
	ne21_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne21)(2 to 3))));
	ne21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne21)(0 to 1))));
	C82_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C82)(2 to 3))));
	C82_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C82)(0 to 1))));
	B133_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B133)(2 to 3))));
	B133_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B133)(0 to 1))));
	P72_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P72)(2 to 3))));
	P72_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P72)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw07_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw07_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	Sw07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw07_state)(0 to 1))));
	--Ocupation level 2
	ne59_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne59)(2 to 3))));
	ne59_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne59)(0 to 1))));
	ne95_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne95)(2 to 3))));
	ne95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne95)(0 to 1))));
	ne52_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne52)(2 to 3))));
	ne52_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne52)(0 to 1))));
	X51_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(2 to 3))));
	X51_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(0 to 1))));
	S86_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S86)(2 to 3))));
	S86_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S86)(0 to 1))));
	S144_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S144)(2 to 3))));
	S144_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S144)(0 to 1))));
	s69W03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s69W03_state)(2 to 3))));
	Sw03_position <= scissorCrossingStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	s69W03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s69W03_state)(0 to 1))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R64_command,R65_command,R66_command,R33_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R64_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R33_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R64_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE or R33_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R64_command = LOCK or R65_command = LOCK or R66_command = LOCK or R33_command = LOCK) then
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

	process(commandState,Sw06_position,Sw07_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw06_position = NORMAL and s69W03_position = NORMAL) or (Sw06_position = REVERSE and Sw07_position = DOUBLE_REVERSE and Sw03_position = REVERSE) or (Sw06_position = REVERSE and Sw07_position = NORMAL_REVERSE)) then
					if (Sw06_position = NORMAL and s69W03_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw06_position = REVERSE and Sw07_position = DOUBLE_REVERSE and Sw03_position = REVERSE) then
						path <= 2;
					end if;
					if (Sw06_position = REVERSE and Sw07_position = NORMAL_REVERSE) then
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

	process(path,ne17_state,ne79_state,ne77_state,ne21_state,C82_aspect,B133_aspect,P72_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne17_state = OCCUPIED or ne17_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C82_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C82_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C82_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C82_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne79_state = OCCUPIED or ne79_lock = LOCKED or ne77_state = OCCUPIED or ne77_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B133_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B133_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B133_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B133_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne79_state = OCCUPIED or ne79_lock = LOCKED or ne21_state = OCCUPIED or ne21_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (P72_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (P72_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (P72_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (P72_aspect = GREEN) then
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