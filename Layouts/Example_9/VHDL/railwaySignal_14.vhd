--  railwaySignal_14.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R18_command : in routeCommands;
			R6_command : in routeCommands;
			Lc10_state : in hex_char;
			--Ocupation level 0
			track_ne46 : in hex_char;
			correspondence_X31 : out hex_char;
			correspondence_C41 : in hex_char;
			--Ocupation level 2
			track_ne3 : in hex_char;
			correspondence_J17 : in hex_char;
			Sw31_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_14;
architecture Behavioral of railwaySignal_14 is
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
	signal Lc10_position : levelCrossingStates := UP;
	signal Lc10_lock : objectLock := RELEASED;
	signal C41_aspect : signalStates;
	signal C41_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne3_state : nodeStates := FREE;
	signal ne3_lock : objectLock := RELEASED;
	signal J17_aspect : signalStates;
	signal J17_lock : objectLock := RELEASED;
	signal Sw31_position : singleSwitchStates := NORMAL;
	signal Sw31_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_X31 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc10_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc10_state)(2 to 3))));
	Lc10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc10_state)(0 to 1))));
	C41_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C41)(2 to 3))));
	C41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C41)(0 to 1))));
	--Ocupation level 2
	ne3_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne3)(2 to 3))));
	ne3_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne3)(0 to 1))));
	J17_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J17)(2 to 3))));
	J17_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J17)(0 to 1))));
	Sw31_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw31_state)(2 to 3))));
	Sw31_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw31_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R18_command,R6_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R18_command = RELEASE and R6_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R18_command = RESERVE or R6_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R18_command = LOCK or R6_command = LOCK) then
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
				if ((Sw31_position = NORMAL and Lc10_position = DOWN)) then
					if (Sw31_position = NORMAL and Lc10_position = DOWN) then
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

	process(path,C41_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (C41_aspect = RED) then
					aspectStateOut <= DOUBLE_YELLOW;
				end if;
				if (C41_aspect = DOUBLE_YELLOW) then
					aspectStateOut <= YELLOW;
				end if;
				if (C41_aspect = YELLOW) then
					aspectStateOut <= GREEN;
				end if;
				if (C41_aspect = GREEN) then
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