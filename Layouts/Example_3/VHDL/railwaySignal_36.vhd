--  railwaySignal_36.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_36 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R29_command : in routeCommands;
			R28_command : in routeCommands;
			R46_command : in routeCommands;
			--Ocupation level 0
			track_ne67 : in hex_char;
			correspondence_P64 : out hex_char;
			--Ocupation level 1
			track_ne70 : in hex_char;
			correspondence_L32 : in hex_char;
			--Ocupation level 2
			track_ne104 : in hex_char;
			track_ne21 : in hex_char;
			correspondence_P73 : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_36;
architecture Behavioral of railwaySignal_36 is
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
	signal ne70_state : nodeStates := FREE;
	signal ne70_lock : objectLock := RELEASED;
	signal L32_aspect : signalStates;
	signal L32_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne104_state : nodeStates := FREE;
	signal ne104_lock : objectLock := RELEASED;
	signal ne21_state : nodeStates := FREE;
	signal ne21_lock : objectLock := RELEASED;
	signal P73_aspect : signalStates;
	signal P73_lock : objectLock := RELEASED;
	signal Sw03_position : scissorCrossingStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_P64 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne70_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne70)(2 to 3))));
	ne70_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne70)(0 to 1))));
	L32_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L32)(2 to 3))));
	L32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L32)(0 to 1))));
	--Ocupation level 2
	ne104_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne104)(2 to 3))));
	ne104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne104)(0 to 1))));
	ne21_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne21)(2 to 3))));
	ne21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne21)(0 to 1))));
	P73_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P73)(2 to 3))));
	P73_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P73)(0 to 1))));
	Sw03_position <= scissorCrossingStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R29_command,R28_command,R46_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R29_command = RELEASE and R28_command = RELEASE and R46_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R29_command = RESERVE or R28_command = RESERVE or R46_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R29_command = LOCK or R28_command = LOCK or R46_command = LOCK) then
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

	process(commandState,Sw03_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw03_position = NORMAL)) then
					if (Sw03_position = NORMAL) then
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

	process(path,ne70_state,L32_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne70_state = OCCUPIED or ne70_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (L32_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (L32_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (L32_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (L32_aspect = GREEN) then
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