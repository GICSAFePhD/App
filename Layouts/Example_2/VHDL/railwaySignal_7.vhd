--  railwaySignal_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			--Ocupation level 0
			track_ne18 : in hex_char;
			correspondence_C17 : out hex_char;
			--Ocupation level 1
			track_ne16 : in hex_char;
			correspondence_S15 : in hex_char;
			Sw02_state : in hex_char;
			--Ocupation level 2
			track_ne15 : in hex_char;
			track_ne14 : in hex_char;
			correspondence_P09 : in hex_char;
			correspondence_L04 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_7;
architecture Behavioral of railwaySignal_7 is
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
	signal ne16_state : nodeStates := FREE;
	signal ne16_lock : objectLock := RELEASED;
	signal S15_aspect : signalStates;
	signal S15_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne15_state : nodeStates := FREE;
	signal ne15_lock : objectLock := RELEASED;
	signal ne14_state : nodeStates := FREE;
	signal ne14_lock : objectLock := RELEASED;
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
	correspondence_C17 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne16_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne16)(2 to 3))));
	ne16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne16)(0 to 1))));
	S15_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S15)(2 to 3))));
	S15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S15)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	--Ocupation level 2
	ne15_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne15)(2 to 3))));
	ne15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne15)(0 to 1))));
	ne14_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne14)(2 to 3))));
	ne14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne14)(0 to 1))));
	P09_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P09)(2 to 3))));
	P09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P09)(0 to 1))));
	L04_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L04)(2 to 3))));
	L04_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L04)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R6_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R6_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R6_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R6_command = LOCK) then
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

	process(commandState,Sw02_position,Sw01_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw02_position = NORMAL and Sw01_position = NORMAL) or (Sw02_position = NORMAL and Sw01_position = REVERSE)) then
					if (Sw02_position = NORMAL and Sw01_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw02_position = NORMAL and Sw01_position = REVERSE) then
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

	process(path,ne16_state,S15_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne16_state = OCCUPIED or ne16_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S15_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S15_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S15_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S15_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne16_state = OCCUPIED or ne16_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S15_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S15_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S15_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S15_aspect = GREEN) then
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