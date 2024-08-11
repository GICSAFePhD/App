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
			R53_command : in routeCommands;
			R54_command : in routeCommands;
			R35_command : in routeCommands;
			--Ocupation level 0
			track_ne61 : in hex_char;
			correspondence_S78 : out hex_char;
			--Ocupation level 1
			track_ne404 : in hex_char;
			track_ne123 : in hex_char;
			correspondence_C73 : in hex_char;
			correspondence_B77 : in hex_char;
			D08_state : in hex_char;
			--Ocupation level 2
			track_ne400 : in hex_char;
			track_ne407 : in hex_char;
			correspondence_S123 : in hex_char;
			D07_state : in hex_char;
			D16_state : in hex_char;
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
	signal ne404_state : nodeStates := FREE;
	signal ne404_lock : objectLock := RELEASED;
	signal ne123_state : nodeStates := FREE;
	signal ne123_lock : objectLock := RELEASED;
	signal C73_aspect : signalStates;
	signal C73_lock : objectLock := RELEASED;
	signal B77_aspect : signalStates;
	signal B77_lock : objectLock := RELEASED;
	signal D08_position : singleSwitchStates := NORMAL;
	signal D08_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne400_state : nodeStates := FREE;
	signal ne400_lock : objectLock := RELEASED;
	signal ne407_state : nodeStates := FREE;
	signal ne407_lock : objectLock := RELEASED;
	signal S123_aspect : signalStates;
	signal S123_lock : objectLock := RELEASED;
	signal D07_position : singleSwitchStates := NORMAL;
	signal D16_position : singleSwitchStates := NORMAL;
	signal D07_lock : objectLock := RELEASED;
	signal D16_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S78 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne404_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne404)(2 to 3))));
	ne404_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne404)(0 to 1))));
	ne123_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne123)(2 to 3))));
	ne123_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne123)(0 to 1))));
	C73_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C73)(2 to 3))));
	C73_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C73)(0 to 1))));
	B77_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B77)(2 to 3))));
	B77_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B77)(0 to 1))));
	D08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D08_state)(2 to 3))));
	D08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D08_state)(0 to 1))));
	--Ocupation level 2
	ne400_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne400)(2 to 3))));
	ne400_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne400)(0 to 1))));
	ne407_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne407)(2 to 3))));
	ne407_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne407)(0 to 1))));
	S123_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S123)(2 to 3))));
	S123_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S123)(0 to 1))));
	D07_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D07_state)(2 to 3))));
	D16_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D16_state)(2 to 3))));
	D07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D07_state)(0 to 1))));
	D16_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D16_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R53_command,R54_command,R35_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R53_command = RELEASE and R54_command = RELEASE and R35_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R53_command = RESERVE or R54_command = RESERVE or R35_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R53_command = LOCK or R54_command = LOCK or R35_command = LOCK) then
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

	process(commandState,D08_position,D07_position,D16_position)
	begin
		case commandState is
			when RELEASE =>
				if ((D08_position = NORMAL and D07_position = NORMAL) or (D08_position = REVERSE and D07_position = REVERSE and D16_position = NORMAL)) then
					if (D08_position = NORMAL and D07_position = NORMAL) then
						path <= 1;
					end if;
					if (D08_position = REVERSE and D07_position = REVERSE and D16_position = NORMAL) then
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

	process(path,ne404_state,ne123_state,C73_aspect,B77_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne404_state = OCCUPIED or ne404_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C73_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C73_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C73_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C73_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne123_state = OCCUPIED or ne123_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B77_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B77_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B77_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B77_aspect = GREEN) then
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