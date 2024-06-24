--  railwaySignal_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R24_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			R1_command : in routeCommands;
			Lc10_state : in hex_char;
			Lc11_state : in hex_char;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne3 : in hex_char;
			correspondence_S42 : out hex_char;
			--Ocupation level 1
			track_ne46 : in hex_char;
			track_ne53 : in hex_char;
			track_ne49 : in hex_char;
			track_ne50 : in hex_char;
			correspondence_J16 : in hex_char;
			correspondence_J12 : in hex_char;
			correspondence_J14 : in hex_char;
			Sw31_state : in hex_char;
			Sw33_state : in hex_char;
			correspondence_J10 : in hex_char;
			correspondence_J06 : in hex_char;
			correspondence_B46 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_4;
architecture Behavioral of railwaySignal_4 is
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
	signal Lc10_position : levelCrossingStates := UP;
	signal Lc10_lock : objectLock := RELEASED;
	signal Lc11_position : levelCrossingStates := UP;
	signal Lc11_lock : objectLock := RELEASED;
	signal Lc09_position : levelCrossingStates := UP;
	signal Lc09_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne46_state : nodeStates := FREE;
	signal ne46_lock : objectLock := RELEASED;
	signal ne53_state : nodeStates := FREE;
	signal ne53_lock : objectLock := RELEASED;
	signal ne49_state : nodeStates := FREE;
	signal ne49_lock : objectLock := RELEASED;
	signal ne50_state : nodeStates := FREE;
	signal ne50_lock : objectLock := RELEASED;
	signal J16_aspect : signalStates;
	signal J16_lock : objectLock := RELEASED;
	signal J12_aspect : signalStates;
	signal J12_lock : objectLock := RELEASED;
	signal J14_aspect : signalStates;
	signal J14_lock : objectLock := RELEASED;
	signal Sw31_position : singleSwitchStates := NORMAL;
	signal Sw33_position : singleSwitchStates := NORMAL;
	signal Sw31_lock : objectLock := RELEASED;
	signal Sw33_lock : objectLock := RELEASED;
	signal J10_aspect : signalStates;
	signal J10_lock : objectLock := RELEASED;
	signal J06_aspect : signalStates;
	signal J06_lock : objectLock := RELEASED;
	signal B46_aspect : signalStates;
	signal B46_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S42 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc10_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc10_state)(2 to 3))));
	Lc10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc10_state)(0 to 1))));
	Lc11_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc11_state)(2 to 3))));
	Lc11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc11_state)(0 to 1))));
	Lc09_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc09_state)(2 to 3))));
	Lc09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc09_state)(0 to 1))));
	--Ocupation level 1
	ne46_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne46)(2 to 3))));
	ne46_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne46)(0 to 1))));
	ne53_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne53)(2 to 3))));
	ne53_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne53)(0 to 1))));
	ne49_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne49)(2 to 3))));
	ne49_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne49)(0 to 1))));
	ne50_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne50)(2 to 3))));
	ne50_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne50)(0 to 1))));
	J16_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J16)(2 to 3))));
	J16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J16)(0 to 1))));
	J12_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J12)(2 to 3))));
	J12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J12)(0 to 1))));
	J14_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J14)(2 to 3))));
	J14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J14)(0 to 1))));
	Sw31_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw31_state)(2 to 3))));
	Sw33_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw33_state)(2 to 3))));
	Sw31_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw31_state)(0 to 1))));
	Sw33_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw33_state)(0 to 1))));
	J10_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J10)(2 to 3))));
	J10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J10)(0 to 1))));
	J06_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J06)(2 to 3))));
	J06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J06)(0 to 1))));
	B46_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B46)(2 to 3))));
	B46_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B46)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R24_command,R25_command,R26_command,R1_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R24_command = RELEASE and R25_command = RELEASE and R26_command = RELEASE and R1_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R24_command = RESERVE or R25_command = RESERVE or R26_command = RESERVE or R1_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R24_command = LOCK or R25_command = LOCK or R26_command = LOCK or R1_command = LOCK) then
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
				if ((Sw31_position = NORMAL and Lc10_position = DOWN) or (Sw31_position = REVERSE and Sw33_position = NORMAL and Lc11_position = DOWN) or (Sw31_position = REVERSE and Sw33_position = REVERSE and Lc09_position = DOWN)) then
					if (Sw31_position = NORMAL and Lc10_position = DOWN) then
						path <= 1;
					end if;
					if (Sw31_position = REVERSE and Sw33_position = NORMAL and Lc11_position = DOWN) then
						path <= 2;
					end if;
					if (Sw31_position = REVERSE and Sw33_position = REVERSE and Lc09_position = DOWN) then
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

	process(path,ne46_state,ne53_state,ne49_state,ne50_state,J16_aspect,J12_aspect,J14_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne46_state = OCCUPIED or ne46_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J16_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J16_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J16_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J16_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne53_state = OCCUPIED or ne53_lock = LOCKED or ne49_state = OCCUPIED or ne49_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J12_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J12_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J12_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J12_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne53_state = OCCUPIED or ne53_lock = LOCKED or ne50_state = OCCUPIED or ne50_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J14_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J14_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J14_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J14_aspect = GREEN) then
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