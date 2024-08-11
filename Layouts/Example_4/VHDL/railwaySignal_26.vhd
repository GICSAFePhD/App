--  railwaySignal_26.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_26 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R49_command : in routeCommands;
			R50_command : in routeCommands;
			R81_command : in routeCommands;
			R82_command : in routeCommands;
			--Ocupation level 0
			track_ne400 : in hex_char;
			correspondence_S74 : out hex_char;
			--Ocupation level 1
			track_ne404 : in hex_char;
			track_ne407 : in hex_char;
			correspondence_C76 : in hex_char;
			correspondence_S93 : in hex_char;
			D07_state : in hex_char;
			--Ocupation level 2
			track_ne61 : in hex_char;
			track_ne98 : in hex_char;
			track_ne99 : in hex_char;
			track_ne122 : in hex_char;
			track_ne123 : in hex_char;
			correspondence_X51 : in hex_char;
			correspondence_T17 : in hex_char;
			D05_state : in hex_char;
			D08_state : in hex_char;
			D16_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_26;
architecture Behavioral of railwaySignal_26 is
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
	signal ne404_state : nodeStates := FREE;
	signal ne404_lock : objectLock := RELEASED;
	signal ne407_state : nodeStates := FREE;
	signal ne407_lock : objectLock := RELEASED;
	signal C76_aspect : signalStates;
	signal C76_lock : objectLock := RELEASED;
	signal S93_aspect : signalStates;
	signal S93_lock : objectLock := RELEASED;
	signal D07_position : singleSwitchStates := NORMAL;
	signal D07_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne61_state : nodeStates := FREE;
	signal ne61_lock : objectLock := RELEASED;
	signal ne98_state : nodeStates := FREE;
	signal ne98_lock : objectLock := RELEASED;
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal ne122_state : nodeStates := FREE;
	signal ne122_lock : objectLock := RELEASED;
	signal ne123_state : nodeStates := FREE;
	signal ne123_lock : objectLock := RELEASED;
	signal X51_aspect : signalStates;
	signal X51_lock : objectLock := RELEASED;
	signal T17_aspect : signalStates;
	signal T17_lock : objectLock := RELEASED;
	signal D05_position : singleSwitchStates := NORMAL;
	signal D08_position : singleSwitchStates := NORMAL;
	signal D16_position : singleSwitchStates := NORMAL;
	signal D05_lock : objectLock := RELEASED;
	signal D08_lock : objectLock := RELEASED;
	signal D16_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S74 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne404_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne404)(2 to 3))));
	ne404_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne404)(0 to 1))));
	ne407_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne407)(2 to 3))));
	ne407_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne407)(0 to 1))));
	C76_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C76)(2 to 3))));
	C76_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C76)(0 to 1))));
	S93_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S93)(2 to 3))));
	S93_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S93)(0 to 1))));
	D07_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D07_state)(2 to 3))));
	D07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D07_state)(0 to 1))));
	--Ocupation level 2
	ne61_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne61)(2 to 3))));
	ne61_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne61)(0 to 1))));
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne98_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne98)(0 to 1))));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	ne122_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne122)(2 to 3))));
	ne122_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne122)(0 to 1))));
	ne123_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne123)(2 to 3))));
	ne123_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne123)(0 to 1))));
	X51_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(2 to 3))));
	X51_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_X51)(0 to 1))));
	T17_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T17)(2 to 3))));
	T17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T17)(0 to 1))));
	D05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D05_state)(2 to 3))));
	D08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D08_state)(2 to 3))));
	D16_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D16_state)(2 to 3))));
	D05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D05_state)(0 to 1))));
	D08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D08_state)(0 to 1))));
	D16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D16_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R49_command,R50_command,R81_command,R82_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R49_command = RELEASE and R50_command = RELEASE and R81_command = RELEASE and R82_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R49_command = RESERVE or R50_command = RESERVE or R81_command = RESERVE or R82_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R49_command = LOCK or R50_command = LOCK or R81_command = LOCK or R82_command = LOCK) then
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

	process(commandState,D07_position,D05_position,D08_position,D16_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D07_position = NORMAL and D05_position = REVERSE and D08_position = NORMAL) or (D07_position = REVERSE and D16_position = REVERSE) or (D07_position = REVERSE and D05_position = REVERSE and D08_position = REVERSE and D16_position = NORMAL)) then
					if (D07_position = NORMAL and D05_position = REVERSE and D08_position = NORMAL) then
						path <= 1;
					end if;
					if (D07_position = REVERSE and D16_position = REVERSE) then
						path <= 2;
					end if;
					if (D07_position = REVERSE and D05_position = REVERSE and D08_position = REVERSE and D16_position = NORMAL) then
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

	process(path,ne404_state,ne407_state,C76_aspect,S93_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne404_state = OCCUPIED or ne404_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C76_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C76_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C76_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C76_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne407_state = OCCUPIED or ne407_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S93_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S93_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S93_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S93_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne407_state = OCCUPIED or ne407_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S93_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S93_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S93_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S93_aspect = GREEN) then
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