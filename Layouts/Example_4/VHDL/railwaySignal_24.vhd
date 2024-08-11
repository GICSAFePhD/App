--  railwaySignal_24.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_24 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			--Ocupation level 0
			track_ne377 : in hex_char;
			correspondence_T04 : out hex_char;
			--Ocupation level 1
			track_ne111 : in hex_char;
			track_ne290 : in hex_char;
			track_ne113 : in hex_char;
			correspondence_J35 : in hex_char;
			correspondence_T15 : in hex_char;
			D14_state : in hex_char;
			D15_state : in hex_char;
			--Ocupation level 2
			track_ne991 : in hex_char;
			correspondence_T01 : in hex_char;
			D01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_24;
architecture Behavioral of railwaySignal_24 is
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
	signal ne111_state : nodeStates := FREE;
	signal ne111_lock : objectLock := RELEASED;
	signal ne290_state : nodeStates := FREE;
	signal ne290_lock : objectLock := RELEASED;
	signal ne113_state : nodeStates := FREE;
	signal ne113_lock : objectLock := RELEASED;
	signal J35_aspect : signalStates;
	signal J35_lock : objectLock := RELEASED;
	signal T15_aspect : signalStates;
	signal T15_lock : objectLock := RELEASED;
	signal D14_position : singleSwitchStates := NORMAL;
	signal D15_position : singleSwitchStates := NORMAL;
	signal D14_lock : objectLock := RELEASED;
	signal D15_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne991_state : nodeStates := FREE;
	signal ne991_lock : objectLock := RELEASED;
	signal T01_aspect : signalStates;
	signal T01_lock : objectLock := RELEASED;
	signal D01_position : singleSwitchStates := NORMAL;
	signal D01_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_T04 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne111_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne111)(2 to 3))));
	ne111_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne111)(0 to 1))));
	ne290_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne290)(2 to 3))));
	ne290_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne290)(0 to 1))));
	ne113_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne113)(2 to 3))));
	ne113_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne113)(0 to 1))));
	J35_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J35)(2 to 3))));
	J35_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J35)(0 to 1))));
	T15_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T15)(2 to 3))));
	T15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T15)(0 to 1))));
	D14_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D14_state)(2 to 3))));
	D15_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D15_state)(2 to 3))));
	D14_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D14_state)(0 to 1))));
	D15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D15_state)(0 to 1))));
	--Ocupation level 2
	ne991_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne991)(2 to 3))));
	ne991_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne991)(0 to 1))));
	T01_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(2 to 3))));
	T01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(0 to 1))));
	D01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D01_state)(2 to 3))));
	D01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D01_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R2_command,R3_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R2_command = RELEASE and R3_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R2_command = RESERVE or R3_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R2_command = LOCK or R3_command = LOCK) then
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

	process(commandState,D15_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D14_position = REVERSE and D15_position = REVERSE and D01_position = NORMAL) or (D15_position = NORMAL)) then
					if (D14_position = REVERSE and D15_position = REVERSE and D01_position = NORMAL) then
						path <= 1;
					end if;
					if (D15_position = NORMAL) then
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

	process(path,ne111_state,ne290_state,ne113_state,J35_aspect,T15_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne111_state = OCCUPIED or ne111_lock = LOCKED or ne290_state = OCCUPIED or ne290_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J35_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J35_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J35_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J35_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne113_state = OCCUPIED or ne113_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T15_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T15_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T15_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T15_aspect = GREEN) then
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