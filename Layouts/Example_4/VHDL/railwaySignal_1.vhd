--  railwaySignal_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R1_command : in routeCommands;
			--Ocupation level 0
			track_ne991 : in hex_char;
			correspondence_T02 : out hex_char;
			correspondence_S64 : in hex_char;
			--Ocupation level 2
			track_ne290 : in hex_char;
			track_ne288 : in hex_char;
			correspondence_S69 : in hex_char;
			correspondence_S86 : in hex_char;
			D01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_1;
architecture Behavioral of railwaySignal_1 is
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
	signal S64_aspect : signalStates;
	signal S64_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne290_state : nodeStates := FREE;
	signal ne290_lock : objectLock := RELEASED;
	signal ne288_state : nodeStates := FREE;
	signal ne288_lock : objectLock := RELEASED;
	signal S69_aspect : signalStates;
	signal S69_lock : objectLock := RELEASED;
	signal S86_aspect : signalStates;
	signal S86_lock : objectLock := RELEASED;
	signal D01_position : singleSwitchStates := NORMAL;
	signal D01_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_T02 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	S64_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S64)(2 to 3))));
	S64_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S64)(0 to 1))));
	--Ocupation level 2
	ne290_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne290)(2 to 3))));
	ne290_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne290)(0 to 1))));
	ne288_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne288)(2 to 3))));
	ne288_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne288)(0 to 1))));
	S69_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S69)(2 to 3))));
	S69_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S69)(0 to 1))));
	S86_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S86)(2 to 3))));
	S86_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S86)(0 to 1))));
	D01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D01_state)(2 to 3))));
	D01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D01_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R1_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R1_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R1_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R1_command = LOCK) then
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

	process(commandState,D01_position,D01_position)
	begin
		case commandState is

				if ((D01_position = REVERSE and D01_position = NORMAL) or (D01_position = REVERSE and D01_position = NORMAL)) then
					if (D01_position = REVERSE and D01_position = NORMAL) then
						path <= 1;
					end if;
					if (D01_position = REVERSE and D01_position = NORMAL) then
						path <= 2;
					end if;
				else
					path <= 0;
				end if;

				path <= 3;

				path <= 0;

				path <= 0;
		end case;
	end process;

	process(path,S64_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (S64_aspect = RED) then
					aspectStateOut <= DOUBLE_YELLOW;
				end if;
				if (S64_aspect = DOUBLE_YELLOW) then
					aspectStateOut <= YELLOW;
				end if;
				if (S64_aspect = YELLOW) then
					aspectStateOut <= GREEN;
				end if;
				if (S64_aspect = GREEN) then
					aspectStateOut <= GREEN;
				end if;
			when 2 =>
				if (S64_aspect = RED) then
					aspectStateOut <= DOUBLE_YELLOW;
				end if;
				if (S64_aspect = DOUBLE_YELLOW) then
					aspectStateOut <= YELLOW;
				end if;
				if (S64_aspect = YELLOW) then
					aspectStateOut <= GREEN;
				end if;
				if (S64_aspect = GREEN) then
					aspectStateOut <= GREEN;
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