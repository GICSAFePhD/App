--  railwaySignal_58.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_58 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R33_command : in routeCommands;
			R9_command : in routeCommands;
			--Ocupation level 0
			track_ne96 : in hex_char;
			correspondence_P70 : out hex_char;
			--Ocupation level 1
			track_ne93 : in hex_char;
			track_ne78 : in hex_char;
			correspondence_S110 : in hex_char;
			--Ocupation level 2
			track_ne17 : in hex_char;
			track_ne79 : in hex_char;
			track_ne21 : in hex_char;
			track_ne77 : in hex_char;
			correspondence_C82 : in hex_char;
			correspondence_B133 : in hex_char;
			correspondence_P72 : in hex_char;
			Sw06_state : in hex_char;
			Sw07_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_58;
architecture Behavioral of railwaySignal_58 is
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
	signal ne93_state : nodeStates := FREE;
	signal ne93_lock : objectLock := RELEASED;
	signal ne78_state : nodeStates := FREE;
	signal ne78_lock : objectLock := RELEASED;
	signal S110_aspect : signalStates;
	signal S110_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne17_state : nodeStates := FREE;
	signal ne17_lock : objectLock := RELEASED;
	signal ne79_state : nodeStates := FREE;
	signal ne79_lock : objectLock := RELEASED;
	signal ne21_state : nodeStates := FREE;
	signal ne21_lock : objectLock := RELEASED;
	signal ne77_state : nodeStates := FREE;
	signal ne77_lock : objectLock := RELEASED;
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
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_P70 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne93_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne93)(2 to 3))));
	ne93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne93)(0 to 1))));
	ne78_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne78)(2 to 3))));
	ne78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne78)(0 to 1))));
	S110_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S110)(2 to 3))));
	S110_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S110)(0 to 1))));
	--Ocupation level 2
	ne17_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne17)(2 to 3))));
	ne17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne17)(0 to 1))));
	ne79_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne79)(2 to 3))));
	ne79_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne79)(0 to 1))));
	ne21_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne21)(2 to 3))));
	ne21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne21)(0 to 1))));
	ne77_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne77)(2 to 3))));
	ne77_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne77)(0 to 1))));
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
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R33_command,R9_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R33_command = RELEASE and R9_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R33_command = RESERVE or R9_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R33_command = LOCK or R9_command = LOCK) then
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

	process(commandState,Sw06_position,Sw06_position,Sw07_position,Sw06_position,Sw07_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw06_position = NORMAL and Sw06_position = REVERSE and Sw07_position = DOUBLE_REVERSE and Sw06_position = REVERSE and Sw07_position = NORMAL_REVERSE) or (Sw06_position = NORMAL and Sw06_position = REVERSE and Sw07_position = DOUBLE_REVERSE and Sw06_position = REVERSE and Sw07_position = NORMAL_REVERSE) or (Sw06_position = NORMAL and Sw06_position = REVERSE and Sw07_position = DOUBLE_REVERSE and Sw06_position = REVERSE and Sw07_position = NORMAL_REVERSE)) then
					if (Sw06_position = NORMAL and Sw06_position = REVERSE and Sw07_position = DOUBLE_REVERSE and Sw06_position = REVERSE and Sw07_position = NORMAL_REVERSE) then
						path <= 1;
					end if;
					if (Sw06_position = NORMAL and Sw06_position = REVERSE and Sw07_position = DOUBLE_REVERSE and Sw06_position = REVERSE and Sw07_position = NORMAL_REVERSE) then
						path <= 2;
					end if;
					if (Sw06_position = NORMAL and Sw06_position = REVERSE and Sw07_position = DOUBLE_REVERSE and Sw06_position = REVERSE and Sw07_position = NORMAL_REVERSE) then
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

	process(path,ne93_state,ne78_state,S110_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne93_state = OCCUPIED or ne93_lock = LOCKED or ne78_state = OCCUPIED or ne78_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S110_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S110_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S110_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S110_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne93_state = OCCUPIED or ne93_lock = LOCKED or ne78_state = OCCUPIED or ne78_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S110_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S110_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S110_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S110_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne93_state = OCCUPIED or ne93_lock = LOCKED or ne78_state = OCCUPIED or ne78_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S110_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S110_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S110_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S110_aspect = GREEN) then
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