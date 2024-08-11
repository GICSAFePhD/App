--  railwaySignal_8.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R57_command : in routeCommands;
			R58_command : in routeCommands;
			R38_command : in routeCommands;
			--Ocupation level 0
			track_ne910 : in hex_char;
			correspondence_S81 : out hex_char;
			--Ocupation level 1
			track_ne130 : in hex_char;
			track_ne135 : in hex_char;
			correspondence_S107 : in hex_char;
			correspondence_B80 : in hex_char;
			D10_state : in hex_char;
			--Ocupation level 2
			track_ne129 : in hex_char;
			track_ne450 : in hex_char;
			track_ne114 : in hex_char;
			track_ne127 : in hex_char;
			correspondence_L29 : in hex_char;
			correspondence_T07 : in hex_char;
			correspondence_S104 : in hex_char;
			D23_state : in hex_char;
			D12_state : in hex_char;
			D24_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_8;
architecture Behavioral of railwaySignal_8 is
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
	signal ne130_state : nodeStates := FREE;
	signal ne130_lock : objectLock := RELEASED;
	signal ne135_state : nodeStates := FREE;
	signal ne135_lock : objectLock := RELEASED;
	signal S107_aspect : signalStates;
	signal S107_lock : objectLock := RELEASED;
	signal B80_aspect : signalStates;
	signal B80_lock : objectLock := RELEASED;
	signal D10_position : singleSwitchStates := NORMAL;
	signal D10_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne129_state : nodeStates := FREE;
	signal ne129_lock : objectLock := RELEASED;
	signal ne450_state : nodeStates := FREE;
	signal ne450_lock : objectLock := RELEASED;
	signal ne114_state : nodeStates := FREE;
	signal ne114_lock : objectLock := RELEASED;
	signal ne127_state : nodeStates := FREE;
	signal ne127_lock : objectLock := RELEASED;
	signal L29_aspect : signalStates;
	signal L29_lock : objectLock := RELEASED;
	signal T07_aspect : signalStates;
	signal T07_lock : objectLock := RELEASED;
	signal S104_aspect : signalStates;
	signal S104_lock : objectLock := RELEASED;
	signal D23_position : singleSwitchStates := NORMAL;
	signal D12_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal D24_position : singleSwitchStates := NORMAL;
	signal D23_lock : objectLock := RELEASED;
	signal D12_lock : objectLock := RELEASED;
	signal D24_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S81 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne130_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne130)(2 to 3))));
	ne130_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne130)(0 to 1))));
	ne135_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne135)(2 to 3))));
	ne135_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne135)(0 to 1))));
	S107_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S107)(2 to 3))));
	S107_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S107)(0 to 1))));
	B80_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B80)(2 to 3))));
	B80_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B80)(0 to 1))));
	D10_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D10_state)(2 to 3))));
	D10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D10_state)(0 to 1))));
	--Ocupation level 2
	ne129_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne129)(2 to 3))));
	ne129_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne129)(0 to 1))));
	ne450_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne450)(2 to 3))));
	ne450_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne450)(0 to 1))));
	ne114_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne114)(2 to 3))));
	ne114_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne114)(0 to 1))));
	ne127_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne127)(2 to 3))));
	ne127_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne127)(0 to 1))));
	L29_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L29)(2 to 3))));
	L29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L29)(0 to 1))));
	T07_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T07)(2 to 3))));
	T07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T07)(0 to 1))));
	S104_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S104)(2 to 3))));
	S104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S104)(0 to 1))));
	D23_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D23_state)(2 to 3))));
	D12_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(D12_state)(2 to 3))));
	D24_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D24_state)(2 to 3))));
	D23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D23_state)(0 to 1))));
	D12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D12_state)(0 to 1))));
	D24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D24_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R57_command,R58_command,R38_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R57_command = RELEASE and R58_command = RELEASE and R38_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R57_command = RESERVE or R58_command = RESERVE or R38_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R57_command = LOCK or R58_command = LOCK or R38_command = LOCK) then
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

	process(commandState,D10_position,D24_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D10_position = NORMAL and D23_position = REVERSE and D12_position = NORMAL_REVERSE) or (D10_position = NORMAL and D12_position = DOUBLE_NORMAL) or (D10_position = REVERSE and D24_position = NORMAL)) then
					if (D10_position = NORMAL and D23_position = REVERSE and D12_position = NORMAL_REVERSE) then
						path <= 1;
					end if;
					if (D10_position = NORMAL and D12_position = DOUBLE_NORMAL) then
						path <= 2;
					end if;
					if (D10_position = REVERSE and D24_position = NORMAL) then
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

	process(path,ne130_state,ne135_state,S107_aspect,B80_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne130_state = OCCUPIED or ne130_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S107_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S107_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S107_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S107_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne130_state = OCCUPIED or ne130_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S107_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S107_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S107_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S107_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne135_state = OCCUPIED or ne135_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B80_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B80_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B80_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B80_aspect = GREEN) then
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