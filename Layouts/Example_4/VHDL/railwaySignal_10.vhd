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
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			R37_command : in routeCommands;
			--Ocupation level 0
			track_ne912 : in hex_char;
			correspondence_S110 : out hex_char;
			--Ocupation level 1
			track_ne131 : in hex_char;
			track_ne465 : in hex_char;
			track_ne132 : in hex_char;
			correspondence_T09 : in hex_char;
			correspondence_J46 : in hex_char;
			D20_state : in hex_char;
			D21_state : in hex_char;
			--Ocupation level 2
			track_ne114 : in hex_char;
			correspondence_L29 : in hex_char;
			D23_state : in hex_char;
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
	--Ocupation level 1
	signal ne131_state : nodeStates := FREE;
	signal ne131_lock : objectLock := RELEASED;
	signal ne465_state : nodeStates := FREE;
	signal ne465_lock : objectLock := RELEASED;
	signal ne132_state : nodeStates := FREE;
	signal ne132_lock : objectLock := RELEASED;
	signal T09_aspect : signalStates;
	signal T09_lock : objectLock := RELEASED;
	signal J46_aspect : signalStates;
	signal J46_lock : objectLock := RELEASED;
	signal D20_position : singleSwitchStates := NORMAL;
	signal D21_position : singleSwitchStates := NORMAL;
	signal D20_lock : objectLock := RELEASED;
	signal D21_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne114_state : nodeStates := FREE;
	signal ne114_lock : objectLock := RELEASED;
	signal L29_aspect : signalStates;
	signal L29_lock : objectLock := RELEASED;
	signal D23_position : singleSwitchStates := NORMAL;
	signal D23_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S110 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne131_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne131)(2 to 3))));
	ne131_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne131)(0 to 1))));
	ne465_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne465)(2 to 3))));
	ne465_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne465)(0 to 1))));
	ne132_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne132)(2 to 3))));
	ne132_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne132)(0 to 1))));
	T09_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T09)(2 to 3))));
	T09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T09)(0 to 1))));
	J46_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J46)(2 to 3))));
	J46_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J46)(0 to 1))));
	D20_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D20_state)(2 to 3))));
	D21_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D21_state)(2 to 3))));
	D20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D20_state)(0 to 1))));
	D21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D21_state)(0 to 1))));
	--Ocupation level 2
	ne114_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne114)(2 to 3))));
	ne114_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne114)(0 to 1))));
	L29_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L29)(2 to 3))));
	L29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L29)(0 to 1))));
	D23_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D23_state)(2 to 3))));
	D23_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D23_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R75_command,R76_command,R37_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R75_command = RELEASE and R76_command = RELEASE and R37_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R75_command = RESERVE or R76_command = RESERVE or R37_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R75_command = LOCK or R76_command = LOCK or R37_command = LOCK) then
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

	process(commandState,D20_position,D23_position)
	begin
		case commandState is

				if ((D20_position = REVERSE and D21_position = REVERSE) or (D20_position = NORMAL and D23_position = NORMAL)) then
					if (D20_position = REVERSE and D21_position = REVERSE) then
						path <= 1;
					end if;
					if (D20_position = NORMAL and D23_position = NORMAL) then
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

	process(path,ne131_state,ne465_state,ne132_state,T09_aspect,J46_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne131_state = OCCUPIED or ne131_lock = LOCKED or ne465_state = OCCUPIED or ne465_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T09_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T09_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T09_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T09_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne132_state = OCCUPIED or ne132_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J46_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J46_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J46_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J46_aspect = GREEN) then
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