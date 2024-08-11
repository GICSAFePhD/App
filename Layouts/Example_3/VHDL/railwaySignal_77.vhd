--  railwaySignal_77.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_77 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R35_command : in routeCommands;
			R66_command : in routeCommands;
			R83_command : in routeCommands;
			--Ocupation level 0
			track_ne21 : in hex_char;
			correspondence_P72 : out hex_char;
			correspondence_S144 : in hex_char;
			--Ocupation level 2
			track_ne104 : in hex_char;
			correspondence_B143 : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_77;
architecture Behavioral of railwaySignal_77 is
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
	signal S144_aspect : signalStates;
	signal S144_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne104_state : nodeStates := FREE;
	signal ne104_lock : objectLock := RELEASED;
	signal B143_aspect : signalStates;
	signal B143_lock : objectLock := RELEASED;
	signal Sw03_position : scissorCrossingStates := NORMAL;
	signal Sw03_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_P72 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	S144_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S144)(2 to 3))));
	S144_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S144)(0 to 1))));
	--Ocupation level 2
	ne104_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne104)(2 to 3))));
	ne104_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne104)(0 to 1))));
	B143_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_B143)(2 to 3))));
	B143_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_B143)(0 to 1))));
	Sw03_position <= scissorCrossingStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R35_command,R66_command,R83_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R35_command = RELEASE and R66_command = RELEASE and R83_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R35_command = RESERVE or R66_command = RESERVE or R83_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R35_command = LOCK or R66_command = LOCK or R83_command = LOCK) then
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

	process(path,S144_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (S144_aspect = RED) then
					aspectStateOut <= DOUBLE_YELLOW;
				end if;
				if (S144_aspect = DOUBLE_YELLOW) then
					aspectStateOut <= YELLOW;
				end if;
				if (S144_aspect = YELLOW) then
					aspectStateOut <= GREEN;
				end if;
				if (S144_aspect = GREEN) then
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