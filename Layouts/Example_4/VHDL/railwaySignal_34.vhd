--  railwaySignal_34.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_34 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			--Ocupation level 0
			track_ne450 : in hex_char;
			correspondence_T08 : out hex_char;
			--Ocupation level 1
			track_ne127 : in hex_char;
			track_ne130 : in hex_char;
			correspondence_S117 : in hex_char;
			correspondence_C79 : in hex_char;
			D12_state : in hex_char;
			--Ocupation level 2
			track_ne910 : in hex_char;
			track_ne134 : in hex_char;
			track_ne135 : in hex_char;
			track_ne101 : in hex_char;
			correspondence_J43 : in hex_char;
			correspondence_T23 : in hex_char;
			D09_state : in hex_char;
			D10_state : in hex_char;
			D24_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_34;
architecture Behavioral of railwaySignal_34 is
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
	signal ne127_state : nodeStates := FREE;
	signal ne127_lock : objectLock := RELEASED;
	signal ne130_state : nodeStates := FREE;
	signal ne130_lock : objectLock := RELEASED;
	signal S117_aspect : signalStates;
	signal S117_lock : objectLock := RELEASED;
	signal C79_aspect : signalStates;
	signal C79_lock : objectLock := RELEASED;
	signal D12_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal D12_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne910_state : nodeStates := FREE;
	signal ne910_lock : objectLock := RELEASED;
	signal ne134_state : nodeStates := FREE;
	signal ne134_lock : objectLock := RELEASED;
	signal ne135_state : nodeStates := FREE;
	signal ne135_lock : objectLock := RELEASED;
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal J43_aspect : signalStates;
	signal J43_lock : objectLock := RELEASED;
	signal T23_aspect : signalStates;
	signal T23_lock : objectLock := RELEASED;
	signal D09_position : singleSwitchStates := NORMAL;
	signal D10_position : singleSwitchStates := NORMAL;
	signal D24_position : singleSwitchStates := NORMAL;
	signal D09_lock : objectLock := RELEASED;
	signal D10_lock : objectLock := RELEASED;
	signal D24_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_T08 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne127_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne127)(2 to 3))));
	ne127_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne127)(0 to 1))));
	ne130_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne130)(2 to 3))));
	ne130_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne130)(0 to 1))));
	S117_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S117)(2 to 3))));
	S117_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S117)(0 to 1))));
	C79_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C79)(2 to 3))));
	C79_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C79)(0 to 1))));
	D12_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(D12_state)(2 to 3))));
	D12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D12_state)(0 to 1))));
	--Ocupation level 2
	ne910_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne910)(2 to 3))));
	ne910_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne910)(0 to 1))));
	ne134_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne134)(2 to 3))));
	ne134_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne134)(0 to 1))));
	ne135_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne135)(2 to 3))));
	ne135_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne135)(0 to 1))));
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	J43_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J43)(2 to 3))));
	J43_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J43)(0 to 1))));
	T23_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T23)(2 to 3))));
	T23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T23)(0 to 1))));
	D09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D09_state)(2 to 3))));
	D10_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D10_state)(2 to 3))));
	D24_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D24_state)(2 to 3))));
	D09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D09_state)(0 to 1))));
	D10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D10_state)(0 to 1))));
	D24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D24_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R6_command,R7_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R6_command = RELEASE and R7_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R6_command = RESERVE or R7_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R6_command = LOCK or R7_command = LOCK) then
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

	process(commandState,D12_position,D09_position,D10_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D12_position = REVERSE_NORMAL and D09_position = REVERSE and D10_position = REVERSE and D24_position = NORMAL) or (D12_position = REVERSE_NORMAL and D24_position = REVERSE) or (D12_position = DOUBLE_NORMAL and D09_position = REVERSE and D10_position = NORMAL)) then
					if (D12_position = REVERSE_NORMAL and D09_position = REVERSE and D10_position = REVERSE and D24_position = NORMAL) then
						path <= 1;
					end if;
					if (D12_position = REVERSE_NORMAL and D24_position = REVERSE) then
						path <= 2;
					end if;
					if (D12_position = DOUBLE_NORMAL and D09_position = REVERSE and D10_position = NORMAL) then
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

	process(path,ne127_state,ne130_state,S117_aspect,C79_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne127_state = OCCUPIED or ne127_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S117_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S117_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S117_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S117_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne127_state = OCCUPIED or ne127_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S117_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S117_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S117_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S117_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne130_state = OCCUPIED or ne130_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C79_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C79_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C79_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C79_aspect = GREEN) then
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