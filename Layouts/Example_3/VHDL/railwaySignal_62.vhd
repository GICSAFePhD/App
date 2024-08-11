--  railwaySignal_62.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_62 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R31_command : in routeCommands;
			R22_command : in routeCommands;
			--Ocupation level 0
			track_ne99 : in hex_char;
			correspondence_P68 : out hex_char;
			--Ocupation level 1
			track_ne97 : in hex_char;
			correspondence_L37 : in hex_char;
			--Ocupation level 2
			track_ne94 : in hex_char;
			correspondence_S135 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_62;
architecture Behavioral of railwaySignal_62 is
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
	signal ne97_state : nodeStates := FREE;
	signal ne97_lock : objectLock := RELEASED;
	signal L37_aspect : signalStates;
	signal L37_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne94_state : nodeStates := FREE;
	signal ne94_lock : objectLock := RELEASED;
	signal S135_aspect : signalStates;
	signal S135_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_P68 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne97_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne97)(2 to 3))));
	ne97_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne97)(0 to 1))));
	L37_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L37)(2 to 3))));
	L37_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L37)(0 to 1))));
	--Ocupation level 2
	ne94_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne94)(2 to 3))));
	ne94_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne94)(0 to 1))));
	S135_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S135)(2 to 3))));
	S135_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S135)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R31_command,R22_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R31_command = RELEASE and R22_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R31_command = RESERVE or R22_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R31_command = LOCK or R22_command = LOCK) then
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

	process(path,ne97_state,L37_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne97_state = OCCUPIED or ne97_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (L37_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (L37_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (L37_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (L37_aspect = GREEN) then
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