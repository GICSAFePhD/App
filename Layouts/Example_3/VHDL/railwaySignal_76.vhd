--  railwaySignal_76.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_76 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R91_command : in routeCommands;
			R3_command : in routeCommands;
			R42_command : in routeCommands;
			--Ocupation level 0
			track_ne52 : in hex_char;
			correspondence_S146 : out hex_char;
			--Ocupation level 1
			track_ne77 : in hex_char;
			correspondence_B145 : in hex_char;
			Sw03_state : in hex_char;
			--Ocupation level 2
			track_ne97 : in hex_char;
			track_ne94 : in hex_char;
			track_ne79 : in hex_char;
			track_ne78 : in hex_char;
			track_ne99 : in hex_char;
			correspondence_L33 : in hex_char;
			correspondence_P69 : in hex_char;
			Sw06_state : in hex_char;
			Sw07_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_76;
architecture Behavioral of railwaySignal_76 is
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
	signal ne77_state : nodeStates := FREE;
	signal ne77_lock : objectLock := RELEASED;
	signal B145_aspect : signalStates;
	signal B145_lock : objectLock := RELEASED;
	signal Sw03_position : scissorCrossingStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne97_state : nodeStates := FREE;
	signal ne97_lock : objectLock := RELEASED;
	signal ne94_state : nodeStates := FREE;
	signal ne94_lock : objectLock := RELEASED;
	signal ne79_state : nodeStates := FREE;
	signal ne79_lock : objectLock := RELEASED;
	signal ne78_state : nodeStates := FREE;
	signal ne78_lock : objectLock := RELEASED;
	signal ne99_state : nodeStates := FREE;
	signal ne99_lock : objectLock := RELEASED;
	signal L33_aspect : signalStates;
	signal L33_lock : objectLock := RELEASED;
	signal P69_aspect : signalStates;
	signal P69_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw07_position : doubleSwitchStates := DOUBLE_NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
	signal Sw07_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S146 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne77_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne77)(2 to 3))));
	ne77_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne77)(0 to 1))));
	B145_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B145)(2 to 3))));
	B145_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B145)(0 to 1))));
	Sw03_position <= scissorCrossingStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	--Ocupation level 2
	ne97_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne97)(2 to 3))));
	ne97_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne97)(0 to 1))));
	ne94_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne94)(2 to 3))));
	ne94_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne94)(0 to 1))));
	ne79_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne79)(2 to 3))));
	ne79_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne79)(0 to 1))));
	ne78_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne78)(2 to 3))));
	ne78_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne78)(0 to 1))));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	ne99_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne99)(0 to 1))));
	L33_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L33)(2 to 3))));
	L33_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L33)(0 to 1))));
	P69_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P69)(2 to 3))));
	P69_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P69)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw07_position <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw07_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	Sw07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw07_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R91_command,R3_command,R42_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R91_command = RELEASE and R3_command = RELEASE and R42_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R91_command = RESERVE or R3_command = RESERVE or R42_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R91_command = LOCK or R3_command = LOCK or R42_command = LOCK) then
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

	process(commandState,Sw03_position,Sw07_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw03_position = REVERSE and Sw06_position = REVERSE and Sw07_position = DOUBLE_REVERSE) or (Sw03_position = REVERSE and Sw07_position = REVERSE_NORMAL)) then
					if (Sw03_position = REVERSE and Sw06_position = REVERSE and Sw07_position = DOUBLE_REVERSE) then
						path <= 1;
					end if;
					if (Sw03_position = REVERSE and Sw07_position = REVERSE_NORMAL) then
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

	process(path,ne77_state,B145_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne77_state = OCCUPIED or ne77_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B145_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B145_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B145_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B145_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne77_state = OCCUPIED or ne77_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B145_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B145_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B145_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B145_aspect = GREEN) then
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