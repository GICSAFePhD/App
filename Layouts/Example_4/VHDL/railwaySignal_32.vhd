--  railwaySignal_32.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_32 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			--Ocupation level 0
			track_ne421 : in hex_char;
			correspondence_T06 : out hex_char;
			--Ocupation level 1
			track_ne124 : in hex_char;
			track_ne63 : in hex_char;
			track_ne126 : in hex_char;
			correspondence_C54 : in hex_char;
			correspondence_T19 : in hex_char;
			D18_state : in hex_char;
			D19_state : in hex_char;
			--Ocupation level 2
			track_ne98 : in hex_char;
			track_ne99 : in hex_char;
			correspondence_X51 : in hex_char;
			D05_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_32;
architecture Behavioral of railwaySignal_32 is
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
	signal ne124_state : nodeStates := FREE;
	signal ne124_lock : objectLock := RELEASED;
	signal ne63_state : nodeStates := FREE;
	signal ne63_lock : objectLock := RELEASED;
	signal ne126_state : nodeStates := FREE;
	signal ne126_lock : objectLock := RELEASED;
	signal C54_aspect : signalStates;
	signal C54_lock : objectLock := RELEASED;
	signal T19_aspect : signalStates;
	signal T19_lock : objectLock := RELEASED;
	signal D18_position : singleSwitchStates := NORMAL;
	signal D19_position : singleSwitchStates := NORMAL;
	signal D18_lock : objectLock := RELEASED;
	signal D19_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne98_state : nodeStates := FREE;
	signal ne98_lock : objectLock := RELEASED;
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal X51_aspect : signalStates;
	signal X51_lock : objectLock := RELEASED;
	signal D05_position : singleSwitchStates := NORMAL;
	signal D05_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_T06 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne124_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne124)(2 to 3))));
	ne124_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne124)(0 to 1))));
	ne63_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne63)(2 to 3))));
	ne63_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne63)(0 to 1))));
	ne126_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne126)(2 to 3))));
	ne126_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne126)(0 to 1))));
	C54_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C54)(2 to 3))));
	C54_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C54)(0 to 1))));
	T19_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T19)(2 to 3))));
	T19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T19)(0 to 1))));
	D18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D18_state)(2 to 3))));
	D19_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D19_state)(2 to 3))));
	D18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D18_state)(0 to 1))));
	D19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D19_state)(0 to 1))));
	--Ocupation level 2
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne98_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne98)(0 to 1))));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	X51_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(2 to 3))));
	X51_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(0 to 1))));
	D05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D05_state)(2 to 3))));
	D05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D05_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R4_command,R5_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R4_command = RELEASE and R5_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R4_command = RESERVE or R5_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R4_command = LOCK or R5_command = LOCK) then
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

	process(commandState,D19_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D18_position = REVERSE and D19_position = REVERSE and D05_position = NORMAL) or (D19_position = NORMAL)) then
					if (D18_position = REVERSE and D19_position = REVERSE and D05_position = NORMAL) then
						path <= 1;
					end if;
					if (D19_position = NORMAL) then
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

	process(path,ne124_state,ne63_state,ne126_state,C54_aspect,T19_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne124_state = OCCUPIED or ne124_lock = LOCKED or ne63_state = OCCUPIED or ne63_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C54_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C54_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C54_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C54_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne126_state = OCCUPIED or ne126_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T19_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T19_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T19_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T19_aspect = GREEN) then
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