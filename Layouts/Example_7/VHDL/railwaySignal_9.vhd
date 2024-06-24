--  railwaySignal_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne42 : in hex_char;
			correspondence_T08 : out hex_char;
			correspondence_H20 : in hex_char;
			--Ocupation level 2
			track_ne43 : in hex_char;
			track_ne41 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_T01 : in hex_char;
			correspondence_T09 : in hex_char;
			Sw18_state : in hex_char;
			Sw19_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_9;
architecture Behavioral of railwaySignal_9 is
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
	signal H20_aspect : signalStates;
	signal H20_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne43_state : nodeStates := FREE;
	signal ne43_lock : objectLock := RELEASED;
	signal ne41_state : nodeStates := FREE;
	signal ne41_lock : objectLock := RELEASED;
	signal ne1_state : nodeStates := FREE;
	signal ne1_lock : objectLock := RELEASED;
	signal T01_aspect : signalStates;
	signal T01_lock : objectLock := RELEASED;
	signal T09_aspect : signalStates;
	signal T09_lock : objectLock := RELEASED;
	signal Sw18_position : singleSwitchStates := NORMAL;
	signal Sw19_position : singleSwitchStates := NORMAL;
	signal Sw18_lock : objectLock := RELEASED;
	signal Sw19_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_T08 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	H20_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_H20)(2 to 3))));
	H20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_H20)(0 to 1))));
	--Ocupation level 2
	ne43_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne43)(2 to 3))));
	ne43_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne43)(0 to 1))));
	ne41_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne41)(2 to 3))));
	ne41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne41)(0 to 1))));
	ne1_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne1)(2 to 3))));
	ne1_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne1)(0 to 1))));
	T01_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(2 to 3))));
	T01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(0 to 1))));
	T09_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T09)(2 to 3))));
	T09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T09)(0 to 1))));
	Sw18_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw18_state)(2 to 3))));
	Sw19_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw19_state)(2 to 3))));
	Sw18_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw18_state)(0 to 1))));
	Sw19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw19_state)(0 to 1))));
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
				if ((Sw18_position = NORMAL and Sw19_position = REVERSE and Sw19_position = NORMAL) or (Sw18_position = NORMAL and Sw19_position = REVERSE and Sw19_position = NORMAL)) then
					if (Sw18_position = NORMAL and Sw19_position = REVERSE and Sw19_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw18_position = NORMAL and Sw19_position = REVERSE and Sw19_position = NORMAL) then
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

	process(path,H20_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (H20_aspect = RED) then
					aspectStateOut <= DOUBLE_YELLOW;
				end if;
				if (H20_aspect = DOUBLE_YELLOW) then
					aspectStateOut <= YELLOW;
				end if;
				if (H20_aspect = YELLOW) then
					aspectStateOut <= GREEN;
				end if;
				if (H20_aspect = GREEN) then
					aspectStateOut <= GREEN;
				end if;
			when 2 =>
				if (H20_aspect = RED) then
					aspectStateOut <= DOUBLE_YELLOW;
				end if;
				if (H20_aspect = DOUBLE_YELLOW) then
					aspectStateOut <= YELLOW;
				end if;
				if (H20_aspect = YELLOW) then
					aspectStateOut <= GREEN;
				end if;
				if (H20_aspect = GREEN) then
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