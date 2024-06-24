--  railwaySignal_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			R11_command : in routeCommands;
			--Ocupation level 0
			track_ne8 : in hex_char;
			correspondence_S32 : out hex_char;
			--Ocupation level 1
			track_ne22 : in hex_char;
			track_ne24 : in hex_char;
			track_ne12 : in hex_char;
			correspondence_J11 : in hex_char;
			correspondence_C25 : in hex_char;
			Sw12_state : in hex_char;
			Sw13_state : in hex_char;
			--Ocupation level 2
			track_ne2 : in hex_char;
			correspondence_L09 : in hex_char;
			correspondence_L08 : in hex_char;
			Sw06_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_5;
architecture Behavioral of railwaySignal_5 is
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
	signal ne22_state : nodeStates := FREE;
	signal ne22_lock : objectLock := RELEASED;
	signal ne24_state : nodeStates := FREE;
	signal ne24_lock : objectLock := RELEASED;
	signal ne12_state : nodeStates := FREE;
	signal ne12_lock : objectLock := RELEASED;
	signal J11_aspect : signalStates;
	signal J11_lock : objectLock := RELEASED;
	signal C25_aspect : signalStates;
	signal C25_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw13_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal Sw13_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne2_state : nodeStates := FREE;
	signal ne2_lock : objectLock := RELEASED;
	signal L09_aspect : signalStates;
	signal L09_lock : objectLock := RELEASED;
	signal L08_aspect : signalStates;
	signal L08_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S32 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne22_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne22)(2 to 3))));
	ne22_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne22)(0 to 1))));
	ne24_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne24)(2 to 3))));
	ne24_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne24)(0 to 1))));
	ne12_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne12)(2 to 3))));
	ne12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne12)(0 to 1))));
	J11_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J11)(2 to 3))));
	J11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J11)(0 to 1))));
	C25_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C25)(2 to 3))));
	C25_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C25)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw13_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw13_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	Sw13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw13_state)(0 to 1))));
	--Ocupation level 2
	ne2_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne2)(2 to 3))));
	ne2_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne2)(0 to 1))));
	L09_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L09)(2 to 3))));
	L09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L09)(0 to 1))));
	L08_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L08)(2 to 3))));
	L08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L08)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R18_command,R19_command,R11_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R18_command = RELEASE and R19_command = RELEASE and R11_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R18_command = RESERVE or R19_command = RESERVE or R11_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R18_command = LOCK or R19_command = LOCK or R11_command = LOCK) then
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
				if ((Sw12_position = NORMAL) or (Sw12_position = REVERSE and Sw13_position = REVERSE and Sw06_position = NORMAL)) then
					if (Sw12_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw12_position = REVERSE and Sw13_position = REVERSE and Sw06_position = NORMAL) then
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

	process(path,ne22_state,ne24_state,ne12_state,J11_aspect,C25_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne22_state = OCCUPIED or ne22_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J11_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J11_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J11_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J11_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne24_state = OCCUPIED or ne24_lock = LOCKED or ne12_state = OCCUPIED or ne12_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (C25_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (C25_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (C25_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (C25_aspect = GREEN) then
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