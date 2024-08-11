--  railwaySignal_18.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_18 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			R27_command : in routeCommands;
			R49_command : in routeCommands;
			--Ocupation level 0
			track_ne26 : in hex_char;
			correspondence_L27 : out hex_char;
			--Ocupation level 1
			track_ne65 : in hex_char;
			correspondence_L30 : in hex_char;
			--Ocupation level 2
			track_ne102 : in hex_char;
			correspondence_C104 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_18;
architecture Behavioral of railwaySignal_18 is
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
	signal ne65_state : nodeStates := FREE;
	signal ne65_lock : objectLock := RELEASED;
	signal L30_aspect : signalStates;
	signal L30_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne102_state : nodeStates := FREE;
	signal ne102_lock : objectLock := RELEASED;
	signal C104_aspect : signalStates;
	signal C104_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_L27 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne65_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne65)(2 to 3))));
	ne65_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne65)(0 to 1))));
	L30_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L30)(2 to 3))));
	L30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L30)(0 to 1))));
	--Ocupation level 2
	ne102_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne102)(2 to 3))));
	ne102_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne102)(0 to 1))));
	C104_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_C104)(2 to 3))));
	C104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_C104)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R11_command,R27_command,R49_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R11_command = RELEASE and R27_command = RELEASE and R49_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R11_command = RESERVE or R27_command = RESERVE or R49_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R11_command = LOCK or R27_command = LOCK or R49_command = LOCK) then
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

	process(path,ne65_state,L30_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne65_state = OCCUPIED or ne65_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (L30_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (L30_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (L30_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (L30_aspect = GREEN) then
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