--  railwaySignal_19.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_19 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne41 : in hex_char;
			correspondence_T08 : out hex_char;
			correspondence_S37 : in hex_char;
			--Ocupation level 2
			track_ne7 : in hex_char;
			track_ne42 : in hex_char;
			correspondence_J20 : in hex_char;
			correspondence_B36 : in hex_char;
			Sw08_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_19;
architecture Behavioral of railwaySignal_19 is
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
	signal S37_aspect : signalStates;
	signal S37_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne7_state : nodeStates := FREE;
	signal ne7_lock : objectLock := RELEASED;
	signal ne42_state : nodeStates := FREE;
	signal ne42_lock : objectLock := RELEASED;
	signal J20_aspect : signalStates;
	signal J20_lock : objectLock := RELEASED;
	signal B36_aspect : signalStates;
	signal B36_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_T08 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	S37_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S37)(2 to 3))));
	S37_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S37)(0 to 1))));
	--Ocupation level 2
	ne7_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne7)(2 to 3))));
	ne7_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne7)(0 to 1))));
	ne42_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne42)(2 to 3))));
	ne42_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne42)(0 to 1))));
	J20_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J20)(2 to 3))));
	J20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J20)(0 to 1))));
	B36_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B36)(2 to 3))));
	B36_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B36)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R4_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R4_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R4_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R4_command = LOCK) then
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
				if ((Sw08_position = NORMAL and Sw08_position = REVERSE) or (Sw08_position = NORMAL and Sw08_position = REVERSE)) then
					if (Sw08_position = NORMAL and Sw08_position = REVERSE) then
						path <= 1;
					end if;
					if (Sw08_position = NORMAL and Sw08_position = REVERSE) then
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

	process(path,S37_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (S37_aspect = RED) then
					aspectStateOut <= DOUBLE_YELLOW;
				end if;
				if (S37_aspect = DOUBLE_YELLOW) then
					aspectStateOut <= YELLOW;
				end if;
				if (S37_aspect = YELLOW) then
					aspectStateOut <= GREEN;
				end if;
				if (S37_aspect = GREEN) then
					aspectStateOut <= GREEN;
				end if;
			when 2 =>
				if (S37_aspect = RED) then
					aspectStateOut <= DOUBLE_YELLOW;
				end if;
				if (S37_aspect = DOUBLE_YELLOW) then
					aspectStateOut <= YELLOW;
				end if;
				if (S37_aspect = YELLOW) then
					aspectStateOut <= GREEN;
				end if;
				if (S37_aspect = GREEN) then
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