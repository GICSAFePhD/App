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
			R1_command : in routeCommands;
			Lc08_state : in hex_char;
			--Ocupation level 0
			track_ne13 : in hex_char;
			correspondence_T02 : out hex_char;
			correspondence_P20 : in hex_char;
			--Ocupation level 2
			track_ne2 : in hex_char;
			correspondence_L08 : in hex_char;
			Sw06_state : in hex_char;
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
	signal Lc08_position : levelCrossingStates := UP;
	signal Lc08_lock : objectLock := RELEASED;
	signal P20_aspect : signalStates;
	signal P20_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne2_state : nodeStates := FREE;
	signal ne2_lock : objectLock := RELEASED;
	signal L08_aspect : signalStates;
	signal L08_lock : objectLock := RELEASED;
	signal Sw06_position : singleSwitchStates := NORMAL;
	signal Sw06_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_T02 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	Lc08_position <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(Lc08_state)(2 to 3))));
	Lc08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Lc08_state)(0 to 1))));
	P20_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P20)(2 to 3))));
	P20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P20)(0 to 1))));
	--Ocupation level 2
	ne2_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne2)(2 to 3))));
	ne2_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne2)(0 to 1))));
	L08_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L08)(2 to 3))));
	L08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L08)(0 to 1))));
	Sw06_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw06_state)(2 to 3))));
	Sw06_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw06_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R1_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R1_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R1_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R1_command = LOCK) then
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
				if ((Sw06_position = REVERSE and Lc08_position = DOWN)) then
					if (Sw06_position = REVERSE and Lc08_position = DOWN) then
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

	process(path,P20_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (P20_aspect = RED) then
					aspectStateOut <= DOUBLE_YELLOW;
				end if;
				if (P20_aspect = DOUBLE_YELLOW) then
					aspectStateOut <= YELLOW;
				end if;
				if (P20_aspect = YELLOW) then
					aspectStateOut <= GREEN;
				end if;
				if (P20_aspect = GREEN) then
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