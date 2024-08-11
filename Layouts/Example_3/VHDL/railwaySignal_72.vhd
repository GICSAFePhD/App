--  railwaySignal_72.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_72 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R81_command : in routeCommands;
			R65_command : in routeCommands;
			R82_command : in routeCommands;
			--Ocupation level 0
			track_ne77 : in hex_char;
			correspondence_B133 : out hex_char;
			--Ocupation level 1
			track_ne52 : in hex_char;
			correspondence_S86 : in hex_char;
			Sw03_state : in hex_char;
			--Ocupation level 2
			track_ne59 : in hex_char;
			track_ne11 : in hex_char;
			track_ne14 : in hex_char;
			track_ne95 : in hex_char;
			correspondence_X51 : in hex_char;
			correspondence_T07 : in hex_char;
			s69W03_state : in hex_char;
			s69W04_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_72;
architecture Behavioral of railwaySignal_72 is
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
	signal ne52_state : nodeStates := FREE;
	signal ne52_lock : objectLock := RELEASED;
	signal S86_aspect : signalStates;
	signal S86_lock : objectLock := RELEASED;
	signal Sw03_position : scissorCrossingStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne59_state : nodeStates := FREE;
	signal ne59_lock : objectLock := RELEASED;
	signal ne11_state : nodeStates := FREE;
	signal ne11_lock : objectLock := RELEASED;
	signal ne14_state : nodeStates := FREE;
	signal ne14_lock : objectLock := RELEASED;
	signal ne95_state : nodeStates := FREE;
	signal ne95_lock : objectLock := RELEASED;
	signal X51_aspect : signalStates;
	signal X51_lock : objectLock := RELEASED;
	signal T07_aspect : signalStates;
	signal T07_lock : objectLock := RELEASED;
	signal s69W03_position : singleSwitchStates := NORMAL;
	signal s69W04_position : singleSwitchStates := NORMAL;
	signal s69W03_lock : objectLock := RELEASED;
	signal s69W04_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_B133 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne52_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne52)(2 to 3))));
	ne52_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne52)(0 to 1))));
	S86_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S86)(2 to 3))));
	S86_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S86)(0 to 1))));
	Sw03_position <= scissorCrossingStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	--Ocupation level 2
	ne59_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne59)(2 to 3))));
	ne59_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne59)(0 to 1))));
	ne11_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne11)(2 to 3))));
	ne11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne11)(0 to 1))));
	ne14_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne14)(2 to 3))));
	ne14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne14)(0 to 1))));
	ne95_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne95)(2 to 3))));
	ne95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne95)(0 to 1))));
	X51_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(2 to 3))));
	X51_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(0 to 1))));
	T07_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T07)(2 to 3))));
	T07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T07)(0 to 1))));
	s69W03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s69W03_state)(2 to 3))));
	s69W04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s69W04_state)(2 to 3))));
	s69W03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s69W03_state)(0 to 1))));
	s69W04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s69W04_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R81_command,R65_command,R82_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R81_command = RELEASE and R65_command = RELEASE and R82_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R81_command = RESERVE or R65_command = RESERVE or R82_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R81_command = LOCK or R65_command = LOCK or R82_command = LOCK) then
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

	process(commandState,Sw03_position,s69W04_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw03_position = REVERSE and s69W03_position = REVERSE and s69W04_position = REVERSE) or (Sw03_position = REVERSE and s69W04_position = NORMAL)) then
					if (Sw03_position = REVERSE and s69W03_position = REVERSE and s69W04_position = REVERSE) then
						path <= 1;
					end if;
					if (Sw03_position = REVERSE and s69W04_position = NORMAL) then
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

	process(path,ne52_state,S86_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne52_state = OCCUPIED or ne52_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S86_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S86_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S86_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S86_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne52_state = OCCUPIED or ne52_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S86_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S86_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S86_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S86_aspect = GREEN) then
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