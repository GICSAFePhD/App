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
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			Lc01_state : in hex_char;
			--Ocupation level 0
			track_ne16 : in hex_char;
			correspondence_S15 : out hex_char;
			--Ocupation level 1
			track_ne14 : in hex_char;
			track_ne15 : in hex_char;
			correspondence_P09 : in hex_char;
			correspondence_L04 : in hex_char;
			Sw01_state : in hex_char;
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
	signal Lc01_position : levelCrossingStates := UP;
	signal Lc01_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne14_state : nodeStates := FREE;
	signal ne14_lock : objectLock := RELEASED;
	signal ne15_state : nodeStates := FREE;
	signal ne15_lock : objectLock := RELEASED;
	signal P09_aspect : signalStates;
	signal P09_lock : objectLock := RELEASED;
	signal L04_aspect : signalStates;
	signal L04_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S15 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc01_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc01_state)(2 to 3))));
	Lc01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc01_state)(0 to 1))));
	--Ocupation level 1
	ne14_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne14)(2 to 3))));
	ne14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne14)(0 to 1))));
	ne15_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne15)(2 to 3))));
	ne15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne15)(0 to 1))));
	P09_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P09)(2 to 3))));
	P09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P09)(0 to 1))));
	L04_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L04)(2 to 3))));
	L04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L04)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R4_command,R5_command,R6_command,R9_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R4_command = RELEASE and R5_command = RELEASE and R6_command = RELEASE and R9_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R4_command = RESERVE or R5_command = RESERVE or R6_command = RESERVE or R9_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R4_command = LOCK or R5_command = LOCK or R6_command = LOCK or R9_command = LOCK) then
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
				if ((Sw01_position = NORMAL and Lc01_position = DOWN and Lc01_position = DOWN) or (Sw01_position = REVERSE and Lc01_position = DOWN and Lc01_position = DOWN)) then
					if (Sw01_position = NORMAL and Lc01_position = DOWN and Lc01_position = DOWN) then
						path <= 1;
					end if;
					if (Sw01_position = REVERSE and Lc01_position = DOWN and Lc01_position = DOWN) then
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

	process(path,ne14_state,ne15_state,P09_aspect,L04_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne14_state = OCCUPIED or ne14_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (P09_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (P09_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (P09_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (P09_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne15_state = OCCUPIED or ne15_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (L04_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (L04_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (L04_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (L04_aspect = GREEN) then
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