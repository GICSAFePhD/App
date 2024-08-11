--  railwaySignal_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			--Ocupation level 0
			track_ne15 : in hex_char;
			correspondence_B14 : out hex_char;
			--Ocupation level 1
			track_ne16 : in hex_char;
			correspondence_S18 : in hex_char;
			Sw01_state : in hex_char;
			--Ocupation level 2
			track_ne20 : in hex_char;
			track_ne17 : in hex_char;
			track_ne18 : in hex_char;
			correspondence_P12 : in hex_char;
			correspondence_L06 : in hex_char;
			Sw02_state : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_3;
architecture Behavioral of railwaySignal_3 is
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
	signal S18_aspect : signalStates;
	signal S18_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne20_state : nodeStates := FREE;
	signal ne20_lock : objectLock := RELEASED;
	signal ne17_state : nodeStates := FREE;
	signal ne17_lock : objectLock := RELEASED;
	signal ne18_state : nodeStates := FREE;
	signal ne18_lock : objectLock := RELEASED;
	signal P12_aspect : signalStates;
	signal P12_lock : objectLock := RELEASED;
	signal L06_aspect : signalStates;
	signal L06_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	signal Sw03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_B14 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne16_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne16)(2 to 3))));
	ne16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne16)(0 to 1))));
	S18_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S18)(2 to 3))));
	S18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S18)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	--Ocupation level 2
	ne20_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne20)(2 to 3))));
	ne20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne20)(0 to 1))));
	ne17_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne17)(2 to 3))));
	ne17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne17)(0 to 1))));
	ne18_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne18)(2 to 3))));
	ne18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne18)(0 to 1))));
	P12_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P12)(2 to 3))));
	P12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P12)(0 to 1))));
	L06_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L06)(2 to 3))));
	L06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L06)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R3_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R3_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R3_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R3_command = LOCK) then
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

	process(commandState,Sw01_position,Sw02_position,Sw03_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw01_position = REVERSE and Sw02_position = NORMAL) or (Sw01_position = REVERSE and Sw02_position = REVERSE and Sw03_position = REVERSE)) then
					if (Sw01_position = REVERSE and Sw02_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw01_position = REVERSE and Sw02_position = REVERSE and Sw03_position = REVERSE) then
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

	process(path,ne16_state,S18_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne16_state = OCCUPIED or ne16_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S18_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S18_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S18_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S18_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne16_state = OCCUPIED or ne16_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S18_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S18_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S18_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S18_aspect = GREEN) then
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