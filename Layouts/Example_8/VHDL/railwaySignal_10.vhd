--  railwaySignal_10.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			Lc05_state : in hex_char;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne25 : in hex_char;
			correspondence_X14 : out hex_char;
			--Ocupation level 1
			track_ne23 : in hex_char;
			correspondence_X12 : in hex_char;
			Sw11_state : in hex_char;
			correspondence_P19 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_10;
architecture Behavioral of railwaySignal_10 is
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
	signal Lc05_position : levelCrossingStates := UP;
	signal Lc05_lock : objectLock := RELEASED;
	signal Lc09_position : levelCrossingStates := UP;
	signal Lc09_lock : objectLock := RELEASED;
	--Ocupation level 1
	signal ne23_state : nodeStates := FREE;
	signal ne23_lock : objectLock := RELEASED;
	signal X12_aspect : signalStates;
	signal X12_lock : objectLock := RELEASED;
	signal Sw11_position : singleSwitchStates := NORMAL;
	signal Sw11_lock : objectLock := RELEASED;
	signal P19_aspect : signalStates;
	signal P19_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_X14 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc05_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc05_state)(2 to 3))));
	Lc05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc05_state)(0 to 1))));
	Lc09_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc09_state)(2 to 3))));
	Lc09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc09_state)(0 to 1))));
	--Ocupation level 1
	ne23_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne23)(2 to 3))));
	ne23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne23)(0 to 1))));
	X12_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X12)(2 to 3))));
	X12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X12)(0 to 1))));
	Sw11_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw11_state)(2 to 3))));
	Sw11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw11_state)(0 to 1))));
	P19_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P19)(2 to 3))));
	P19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P19)(0 to 1))));
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

	process(commandState,Sw11_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw11_position = NORMAL and Lc05_position = DOWN and Lc09_position = DOWN)) then
					if (Sw11_position = NORMAL and Lc05_position = DOWN and Lc09_position = DOWN) then
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

	process(path,ne23_state,X12_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne23_state = OCCUPIED or ne23_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (X12_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (X12_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (X12_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (X12_aspect = GREEN) then
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