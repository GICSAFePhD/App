--  railwaySignal_20.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_20 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne41 : in hex_char;
			correspondence_S37 : out hex_char;
			--Ocupation level 1
			track_ne7 : in hex_char;
			track_ne42 : in hex_char;
			correspondence_J20 : in hex_char;
			correspondence_B36 : in hex_char;
			Sw08_state : in hex_char;
			correspondence_C29 : in hex_char;
			correspondence_T09 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_20;
architecture Behavioral of railwaySignal_20 is
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
	signal C29_aspect : signalStates;
	signal C29_lock : objectLock := RELEASED;
	signal T09_aspect : signalStates;
	signal T09_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S37 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
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
	C29_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C29)(2 to 3))));
	C29_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C29)(0 to 1))));
	T09_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T09)(2 to 3))));
	T09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T09)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R21_command,R22_command,R4_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R21_command = RELEASE and R22_command = RELEASE and R4_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R21_command = RESERVE or R22_command = RESERVE or R4_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R21_command = LOCK or R22_command = LOCK or R4_command = LOCK) then
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

	process(commandState,Sw08_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw08_position = NORMAL) or (Sw08_position = REVERSE)) then
					if (Sw08_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw08_position = REVERSE) then
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

	process(path,ne7_state,ne42_state,J20_aspect,B36_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne7_state = OCCUPIED or ne7_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J20_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J20_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J20_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J20_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne42_state = OCCUPIED or ne42_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (B36_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (B36_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (B36_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (B36_aspect = GREEN) then
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