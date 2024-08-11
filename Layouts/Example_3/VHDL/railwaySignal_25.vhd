--  railwaySignal_25.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_25 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R68_command : in routeCommands;
			R69_command : in routeCommands;
			R70_command : in routeCommands;
			R58_command : in routeCommands;
			--Ocupation level 0
			track_ne32 : in hex_char;
			correspondence_S115 : out hex_char;
			--Ocupation level 1
			track_ne83 : in hex_char;
			track_ne82 : in hex_char;
			track_ne41 : in hex_char;
			track_ne84 : in hex_char;
			correspondence_C95 : in hex_char;
			correspondence_P58 : in hex_char;
			correspondence_T13 : in hex_char;
			Sw04_state : in hex_char;
			Sw05_state : in hex_char;
			--Ocupation level 2
			track_ne30 : in hex_char;
			correspondence_S122 : in hex_char;
			Sw08_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_25;
architecture Behavioral of railwaySignal_25 is
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
	signal ne83_state : nodeStates := FREE;
	signal ne83_lock : objectLock := RELEASED;
	signal ne82_state : nodeStates := FREE;
	signal ne82_lock : objectLock := RELEASED;
	signal ne41_state : nodeStates := FREE;
	signal ne41_lock : objectLock := RELEASED;
	signal ne84_state : nodeStates := FREE;
	signal ne84_lock : objectLock := RELEASED;
	signal C95_aspect : signalStates;
	signal C95_lock : objectLock := RELEASED;
	signal P58_aspect : signalStates;
	signal P58_lock : objectLock := RELEASED;
	signal T13_aspect : signalStates;
	signal T13_lock : objectLock := RELEASED;
	signal Sw04_position : singleSwitchStates := NORMAL;
	signal Sw05_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw04_lock : objectLock := RELEASED;
	signal Sw05_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne30_state : nodeStates := FREE;
	signal ne30_lock : objectLock := RELEASED;
	signal S122_aspect : signalStates;
	signal S122_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S115 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne83_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne83)(2 to 3))));
	ne83_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne83)(0 to 1))));
	ne82_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne82)(2 to 3))));
	ne82_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne82)(0 to 1))));
	ne41_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne41)(2 to 3))));
	ne41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne41)(0 to 1))));
	ne84_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne84)(2 to 3))));
	ne84_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne84)(0 to 1))));
	C95_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C95)(2 to 3))));
	C95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C95)(0 to 1))));
	P58_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P58)(2 to 3))));
	P58_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P58)(0 to 1))));
	T13_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T13)(2 to 3))));
	T13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T13)(0 to 1))));
	Sw04_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw04_state)(2 to 3))));
	Sw05_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw04_state)(0 to 1))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	--Ocupation level 2
	ne30_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne30)(2 to 3))));
	ne30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne30)(0 to 1))));
	S122_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S122)(2 to 3))));
	S122_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S122)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R68_command,R69_command,R70_command,R58_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R68_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R58_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R68_command = RESERVE or R69_command = RESERVE or R70_command = RESERVE or R58_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R68_command = LOCK or R69_command = LOCK or R70_command = LOCK or R58_command = LOCK) then
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

	process(commandState,Sw04_position,Sw05_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw04_position = NORMAL and Sw08_position = NORMAL) or (Sw04_position = REVERSE and Sw05_position = NORMAL_REVERSE) or (Sw04_position = REVERSE and Sw05_position = DOUBLE_REVERSE)) then
					if (Sw04_position = NORMAL and Sw08_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw04_position = REVERSE and Sw05_position = NORMAL_REVERSE) then
						path <= 2;
					end if;
					if (Sw04_position = REVERSE and Sw05_position = DOUBLE_REVERSE) then
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

	process(path,ne83_state,ne82_state,ne41_state,ne84_state,C95_aspect,P58_aspect,T13_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne83_state = OCCUPIED or ne83_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C95_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C95_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C95_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C95_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne82_state = OCCUPIED or ne82_lock = LOCKED or ne41_state = OCCUPIED or ne41_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (P58_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (P58_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (P58_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (P58_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne82_state = OCCUPIED or ne82_lock = LOCKED or ne84_state = OCCUPIED or ne84_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T13_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T13_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T13_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T13_aspect = GREEN) then
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