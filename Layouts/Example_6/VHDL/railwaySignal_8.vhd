--  railwaySignal_8.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			R15_command : in routeCommands;
			--Ocupation level 0
			track_ne5 : in hex_char;
			correspondence_S33 : out hex_char;
			--Ocupation level 1
			track_ne10 : in hex_char;
			track_ne11 : in hex_char;
			correspondence_T05 : in hex_char;
			correspondence_J13 : in hex_char;
			Sw05_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_8;
architecture Behavioral of railwaySignal_8 is
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
	signal ne10_state : nodeStates := FREE;
	signal ne10_lock : objectLock := RELEASED;
	signal ne11_state : nodeStates := FREE;
	signal ne11_lock : objectLock := RELEASED;
	signal T05_aspect : signalStates;
	signal T05_lock : objectLock := RELEASED;
	signal J13_aspect : signalStates;
	signal J13_lock : objectLock := RELEASED;
	signal Sw05_position : singleSwitchStates := NORMAL;
	signal Sw05_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S33 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne10_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne10)(2 to 3))));
	ne10_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne10)(0 to 1))));
	ne11_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne11)(2 to 3))));
	ne11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne11)(0 to 1))));
	T05_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(2 to 3))));
	T05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T05)(0 to 1))));
	J13_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J13)(2 to 3))));
	J13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J13)(0 to 1))));
	Sw05_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw05_state)(2 to 3))));
	Sw05_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw05_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R18_command,R19_command,R15_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R18_command = RELEASE and R19_command = RELEASE and R15_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R18_command = RESERVE or R19_command = RESERVE or R15_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R18_command = LOCK or R19_command = LOCK or R15_command = LOCK) then
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

	process(commandState,Sw05_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw05_position = REVERSE) or (Sw05_position = NORMAL)) then
					if (Sw05_position = REVERSE) then
						path <= 1;
					end if;
					if (Sw05_position = NORMAL) then
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

	process(path,ne10_state,ne11_state,T05_aspect,J13_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne10_state = OCCUPIED or ne10_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T05_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T05_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T05_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T05_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne11_state = OCCUPIED or ne11_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J13_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J13_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J13_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J13_aspect = GREEN) then
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