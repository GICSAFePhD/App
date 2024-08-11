--  railwaySignal_47.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_47 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			--Ocupation level 0
			track_ne102 : in hex_char;
			correspondence_T12 : out hex_char;
			--Ocupation level 1
			track_ne114 : in hex_char;
			correspondence_S101 : in hex_char;
			--Ocupation level 2
			track_ne130 : in hex_char;
			track_ne129 : in hex_char;
			track_ne132 : in hex_char;
			track_ne127 : in hex_char;
			correspondence_J47 : in hex_char;
			correspondence_S117 : in hex_char;
			correspondence_C79 : in hex_char;
			D23_state : in hex_char;
			D12_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_47;
architecture Behavioral of railwaySignal_47 is
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
	signal ne114_state : nodeStates := FREE;
	signal ne114_lock : objectLock := RELEASED;
	signal S101_aspect : signalStates;
	signal S101_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne130_state : nodeStates := FREE;
	signal ne130_lock : objectLock := RELEASED;
	signal ne129_state : nodeStates := FREE;
	signal ne129_lock : objectLock := RELEASED;
	signal ne132_state : nodeStates := FREE;
	signal ne132_lock : objectLock := RELEASED;
	signal ne127_state : nodeStates := FREE;
	signal ne127_lock : objectLock := RELEASED;
	signal J47_aspect : signalStates;
	signal J47_lock : objectLock := RELEASED;
	signal S117_aspect : signalStates;
	signal S117_lock : objectLock := RELEASED;
	signal C79_aspect : signalStates;
	signal C79_lock : objectLock := RELEASED;
	signal D23_position : singleSwitchStates := NORMAL;
	signal D12_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal D23_lock : objectLock := RELEASED;
	signal D12_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_T12 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne114_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne114)(2 to 3))));
	ne114_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne114)(0 to 1))));
	S101_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S101)(2 to 3))));
	S101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S101)(0 to 1))));
	--Ocupation level 2
	ne130_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne130)(2 to 3))));
	ne130_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne130)(0 to 1))));
	ne129_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne129)(2 to 3))));
	ne129_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne129)(0 to 1))));
	ne132_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne132)(2 to 3))));
	ne132_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne132)(0 to 1))));
	ne127_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne127)(2 to 3))));
	ne127_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne127)(0 to 1))));
	J47_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J47)(2 to 3))));
	J47_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J47)(0 to 1))));
	S117_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S117)(2 to 3))));
	S117_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S117)(0 to 1))));
	C79_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C79)(2 to 3))));
	C79_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C79)(0 to 1))));
	D23_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D23_state)(2 to 3))));
	D12_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(D12_state)(2 to 3))));
	D23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D23_state)(0 to 1))));
	D12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D12_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R10_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R10_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R10_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R10_command = LOCK) then
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

	process(commandState,D23_position,D23_position,D12_position,D23_position,D12_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D23_position = NORMAL and D23_position = REVERSE and D12_position = DOUBLE_REVERSE and D23_position = REVERSE and D12_position = NORMAL_REVERSE) or (D23_position = NORMAL and D23_position = REVERSE and D12_position = DOUBLE_REVERSE and D23_position = REVERSE and D12_position = NORMAL_REVERSE) or (D23_position = NORMAL and D23_position = REVERSE and D12_position = DOUBLE_REVERSE and D23_position = REVERSE and D12_position = NORMAL_REVERSE)) then
					if (D23_position = NORMAL and D23_position = REVERSE and D12_position = DOUBLE_REVERSE and D23_position = REVERSE and D12_position = NORMAL_REVERSE) then
						path <= 1;
					end if;
					if (D23_position = NORMAL and D23_position = REVERSE and D12_position = DOUBLE_REVERSE and D23_position = REVERSE and D12_position = NORMAL_REVERSE) then
						path <= 2;
					end if;
					if (D23_position = NORMAL and D23_position = REVERSE and D12_position = DOUBLE_REVERSE and D23_position = REVERSE and D12_position = NORMAL_REVERSE) then
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

	process(path,ne114_state,S101_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne114_state = OCCUPIED or ne114_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S101_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S101_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S101_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S101_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne114_state = OCCUPIED or ne114_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S101_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S101_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S101_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S101_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne114_state = OCCUPIED or ne114_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S101_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S101_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S101_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S101_aspect = GREEN) then
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