--  railwaySignal_12.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R41_command : in routeCommands;
			R64_command : in routeCommands;
			Lc01_state : in hex_char;
			--Ocupation level 0
			track_ne17 : in hex_char;
			correspondence_C82 : out hex_char;
			--Ocupation level 1
			track_ne59 : in hex_char;
			track_ne95 : in hex_char;
			correspondence_X51 : in hex_char;
			s69W03_state : in hex_char;
			--Ocupation level 2
			track_ne9 : in hex_char;
			correspondence_S80 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_12;
architecture Behavioral of railwaySignal_12 is
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
	signal Lc01_position : levelCrossingStates := UP;
	signal Lc01_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne59_state : nodeStates := FREE;
	signal ne59_lock : objectLock := RELEASED;
	signal ne95_state : nodeStates := FREE;
	signal ne95_lock : objectLock := RELEASED;
	signal X51_aspect : signalStates;
	signal X51_lock : objectLock := RELEASED;
	signal s69W03_position : singleSwitchStates := NORMAL;
	signal s69W03_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne9_state : nodeStates := FREE;
	signal ne9_lock : objectLock := RELEASED;
	signal S80_aspect : signalStates;
	signal S80_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_C82 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	--Ocupation level 1
	ne59_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne59)(2 to 3))));
	ne59_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne59)(0 to 1))));
	ne95_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne95)(2 to 3))));
	ne95_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne95)(0 to 1))));
	X51_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(2 to 3))));
	X51_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(0 to 1))));
	s69W03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(s69W03_state)(2 to 3))));
	s69W03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(s69W03_state)(0 to 1))));
	--Ocupation level 2
	ne9_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne9)(2 to 3))));
	ne9_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne9)(0 to 1))));
	S80_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S80)(2 to 3))));
	S80_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S80)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R41_command,R64_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R41_command = RELEASE and R64_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R41_command = RESERVE or R64_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R41_command = LOCK or R64_command = LOCK) then
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

	process(commandState,s69W03_position)
	begin
		case commandState is
			when RELEASE =>
				if ((s69W03_position = NORMAL and Lc01_position = DOWN)) then
					if (s69W03_position = NORMAL and Lc01_position = DOWN) then
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

	process(path,ne59_state,ne95_state,X51_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne59_state = OCCUPIED or ne59_lock = LOCKED or ne95_state = OCCUPIED or ne95_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (X51_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (X51_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (X51_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (X51_aspect = GREEN) then
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