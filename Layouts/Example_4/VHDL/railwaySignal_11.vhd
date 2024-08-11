--  railwaySignal_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R17_command : in routeCommands;
			R27_command : in routeCommands;
			R71_command : in routeCommands;
			R73_command : in routeCommands;
			--Ocupation level 0
			track_ne114 : in hex_char;
			correspondence_L29 : out hex_char;
			correspondence_J48 : in hex_char;
			--Ocupation level 2
			track_ne102 : in hex_char;
			correspondence_T11 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_11;
architecture Behavioral of railwaySignal_11 is
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
	signal J48_aspect : signalStates;
	signal J48_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne102_state : nodeStates := FREE;
	signal ne102_lock : objectLock := RELEASED;
	signal T11_aspect : signalStates;
	signal T11_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_L29 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	J48_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J48)(2 to 3))));
	J48_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J48)(0 to 1))));
	--Ocupation level 2
	ne102_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne102)(2 to 3))));
	ne102_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne102)(0 to 1))));
	T11_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T11)(2 to 3))));
	T11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T11)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R17_command,R27_command,R71_command,R73_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R17_command = RELEASE and R27_command = RELEASE and R71_command = RELEASE and R73_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R17_command = RESERVE or R27_command = RESERVE or R71_command = RESERVE or R73_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R17_command = LOCK or R27_command = LOCK or R71_command = LOCK or R73_command = LOCK) then
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

	process(commandState)
	begin
		case commandState is
			when RELEASE =>
				path <= 1;
			when RESERVE =>
				path <= 2;
			when LOCK =>
				path <= 0;
			when others =>
				path <= 0;
		end case;
	end process;

	process(path,J48_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (J48_aspect = RED) then
					aspectStateOut <= DOUBLE_YELLOW;
				end if;
				if (J48_aspect = DOUBLE_YELLOW) then
					aspectStateOut <= YELLOW;
				end if;
				if (J48_aspect = YELLOW) then
					aspectStateOut <= GREEN;
				end if;
				if (J48_aspect = GREEN) then
					aspectStateOut <= GREEN;
				end if;
			when 2 =>
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