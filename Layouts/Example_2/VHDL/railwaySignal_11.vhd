--  railwaySignal_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			--Ocupation level 0
			track_ne20 : in hex_char;
			correspondence_S21 : out hex_char;
			--Ocupation level 1
			track_ne17 : in hex_char;
			track_ne16 : in hex_char;
			track_ne19 : in hex_char;
			correspondence_S15 : in hex_char;
			correspondence_T01 : in hex_char;
			Sw02_state : in hex_char;
			Sw03_state : in hex_char;
			--Ocupation level 2
			track_ne15 : in hex_char;
			track_ne14 : in hex_char;
			correspondence_P09 : in hex_char;
			correspondence_L04 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_11;
architecture Behavioral of railwaySignal_11 is
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
	signal ne16_state : nodeStates := FREE;
	signal ne16_lock : objectLock := RELEASED;
	signal ne19_state : nodeStates := FREE;
	signal ne19_lock : objectLock := RELEASED;
	signal S15_aspect : signalStates;
	signal S15_lock : objectLock := RELEASED;
	signal T01_aspect : signalStates;
	signal T01_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	signal Sw03_lock : objectLock := RELEASED;
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
	correspondence_S21 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne17_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne17)(2 to 3))));
	ne17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne17)(0 to 1))));
	ne16_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne16)(2 to 3))));
	ne16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne16)(0 to 1))));
	ne19_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne19)(2 to 3))));
	ne19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne19)(0 to 1))));
	S15_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S15)(2 to 3))));
	S15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S15)(0 to 1))));
	T01_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(2 to 3))));
	T01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
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

	process(timeout,R9_command,R10_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R9_command = RELEASE and R10_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R9_command = RESERVE or R10_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R9_command = LOCK or R10_command = LOCK) then
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

	process(commandState,Sw03_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw02_position = REVERSE and Sw03_position = REVERSE and Sw01_position = NORMAL) or (Sw02_position = REVERSE and Sw03_position = REVERSE and Sw01_position = REVERSE) or (Sw03_position = NORMAL)) then
					if (Sw02_position = REVERSE and Sw03_position = REVERSE and Sw01_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw02_position = REVERSE and Sw03_position = REVERSE and Sw01_position = REVERSE) then
						path <= 2;
					end if;
					if (Sw03_position = NORMAL) then
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

	process(path,ne17_state,ne16_state,ne19_state,S15_aspect,T01_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne17_state = OCCUPIED or ne17_lock = LOCKED or ne16_state = OCCUPIED or ne16_lock = LOCKED) then
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
				if (ne17_state = OCCUPIED or ne17_lock = LOCKED or ne16_state = OCCUPIED or ne16_lock = LOCKED) then
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
				if (ne19_state = OCCUPIED or ne19_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T01_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T01_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T01_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T01_aspect = GREEN) then
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