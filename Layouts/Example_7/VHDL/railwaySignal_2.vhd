--  railwaySignal_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R1_command : in routeCommands;
			--Ocupation level 0
			track_ne1 : in hex_char;
			correspondence_S14 : out hex_char;
			--Ocupation level 1
			track_ne41 : in hex_char;
			track_ne40 : in hex_char;
			track_ne31 : in hex_char;
			track_ne32 : in hex_char;
			correspondence_B18 : in hex_char;
			correspondence_T03 : in hex_char;
			correspondence_T05 : in hex_char;
			Sw18_state : in hex_char;
			Sw14_state : in hex_char;
			--Ocupation level 2
			track_ne42 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw19_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_2;
architecture Behavioral of railwaySignal_2 is
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
	signal ne41_state : nodeStates := FREE;
	signal ne41_lock : objectLock := RELEASED;
	signal ne40_state : nodeStates := FREE;
	signal ne40_lock : objectLock := RELEASED;
	signal ne31_state : nodeStates := FREE;
	signal ne31_lock : objectLock := RELEASED;
	signal ne32_state : nodeStates := FREE;
	signal ne32_lock : objectLock := RELEASED;
	signal B18_aspect : signalStates;
	signal B18_lock : objectLock := RELEASED;
	signal T03_aspect : signalStates;
	signal T03_lock : objectLock := RELEASED;
	signal T05_aspect : signalStates;
	signal T05_lock : objectLock := RELEASED;
	signal Sw18_position : singleSwitchStates := NORMAL;
	signal Sw14_position : singleSwitchStates := NORMAL;
	signal Sw18_lock : objectLock := RELEASED;
	signal Sw14_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne42_state : nodeStates := FREE;
	signal ne42_lock : objectLock := RELEASED;
	signal T07_aspect : signalStates;
	signal T07_lock : objectLock := RELEASED;
	signal Sw19_position : singleSwitchStates := NORMAL;
	signal Sw19_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S14 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne41_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne41)(2 to 3))));
	ne41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne41)(0 to 1))));
	ne40_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne40)(2 to 3))));
	ne40_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne40)(0 to 1))));
	ne31_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne31)(2 to 3))));
	ne31_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne31)(0 to 1))));
	ne32_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne32)(2 to 3))));
	ne32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne32)(0 to 1))));
	B18_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B18)(2 to 3))));
	B18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B18)(0 to 1))));
	T03_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T03)(2 to 3))));
	T03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T03)(0 to 1))));
	T05_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(2 to 3))));
	T05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(0 to 1))));
	Sw18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw18_state)(2 to 3))));
	Sw14_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw14_state)(2 to 3))));
	Sw18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw18_state)(0 to 1))));
	Sw14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw14_state)(0 to 1))));
	--Ocupation level 2
	ne42_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne42)(2 to 3))));
	ne42_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne42)(0 to 1))));
	T07_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T07)(2 to 3))));
	T07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T07)(0 to 1))));
	Sw19_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw19_state)(2 to 3))));
	Sw19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw19_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R6_command,R7_command,R8_command,R1_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R6_command = RELEASE and R7_command = RELEASE and R8_command = RELEASE and R1_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R6_command = RESERVE or R7_command = RESERVE or R8_command = RESERVE or R1_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R6_command = LOCK or R7_command = LOCK or R8_command = LOCK or R1_command = LOCK) then
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

	process(commandState,Sw14_position,Sw18_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw18_position = NORMAL and Sw19_position = REVERSE) or (Sw14_position = REVERSE and Sw18_position = REVERSE) or (Sw14_position = NORMAL and Sw18_position = REVERSE)) then
					if (Sw18_position = NORMAL and Sw19_position = REVERSE) then
						path <= 1;
					end if;
					if (Sw14_position = REVERSE and Sw18_position = REVERSE) then
						path <= 2;
					end if;
					if (Sw14_position = NORMAL and Sw18_position = REVERSE) then
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

	process(path,ne41_state,ne40_state,ne31_state,ne32_state,B18_aspect,T03_aspect,T05_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne41_state = OCCUPIED or ne41_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B18_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B18_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B18_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B18_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne40_state = OCCUPIED or ne40_lock = LOCKED or ne31_state = OCCUPIED or ne31_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T03_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T03_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T03_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T03_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne40_state = OCCUPIED or ne40_lock = LOCKED or ne32_state = OCCUPIED or ne32_lock = LOCKED) then
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