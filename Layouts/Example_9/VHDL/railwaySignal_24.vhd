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
			R27_command : in routeCommands;
			R11_command : in routeCommands;
			--Ocupation level 0
			track_ne50 : in hex_char;
			correspondence_B46 : out hex_char;
			--Ocupation level 1
			track_ne48 : in hex_char;
			track_ne40 : in hex_char;
			correspondence_J24 : in hex_char;
			Sw27_state : in hex_char;
			Sw29_state : in hex_char;
			correspondence_J26 : in hex_char;
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
	signal ne48_state : nodeStates := FREE;
	signal ne48_lock : objectLock := RELEASED;
	signal ne40_state : nodeStates := FREE;
	signal ne40_lock : objectLock := RELEASED;
	signal J24_aspect : signalStates;
	signal J24_lock : objectLock := RELEASED;
	signal Sw27_position : singleSwitchStates := NORMAL;
	signal Sw29_position : singleSwitchStates := NORMAL;
	signal Sw27_lock : objectLock := RELEASED;
	signal Sw29_lock : objectLock := RELEASED;
	signal J26_aspect : signalStates;
	signal J26_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_B46 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne48_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne48)(2 to 3))));
	ne48_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne48)(0 to 1))));
	ne40_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne40)(2 to 3))));
	ne40_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne40)(0 to 1))));
	J24_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J24)(2 to 3))));
	J24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J24)(0 to 1))));
	Sw27_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw27_state)(2 to 3))));
	Sw29_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw29_state)(2 to 3))));
	Sw27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw27_state)(0 to 1))));
	Sw29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw29_state)(0 to 1))));
	J26_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J26)(2 to 3))));
	J26_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J26)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R27_command,R11_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R27_command = RELEASE and R11_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R27_command = RESERVE or R11_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R27_command = LOCK or R11_command = LOCK) then
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

	process(commandState,Sw27_position,Sw29_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw27_position = REVERSE and Sw29_position = REVERSE)) then
					if (Sw27_position = REVERSE and Sw29_position = REVERSE) then
						path <= 1;
					end if;
				else
					path <= 0;
				end if;
			when RESERVE =>
				path <= 2;
			when LOCK =>
				path <= 0;
			when others =>
				path <= 0;
		end case;
	end process;

	process(path,ne48_state,ne40_state,J24_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne48_state = OCCUPIED or ne48_lock = LOCKED or ne40_state = OCCUPIED or ne40_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J24_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J24_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J24_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J24_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				aspectStateOut <= GREEN;
			when others =>
				aspectStateOut <= RED;
		end case;
	end process;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "011010000100111011100001011111") then
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