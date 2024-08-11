--  railwaySignal_63.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_63 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R28_command : in routeCommands;
			R68_command : in routeCommands;
			--Ocupation level 0
			track_ne132 : in hex_char;
			correspondence_J47 : out hex_char;
			--Ocupation level 1
			track_ne912 : in hex_char;
			correspondence_J45 : in hex_char;
			D20_state : in hex_char;
			--Ocupation level 2
			track_ne101 : in hex_char;
			correspondence_J43 : in hex_char;
			D09_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_63;
architecture Behavioral of railwaySignal_63 is
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
	signal ne912_state : nodeStates := FREE;
	signal ne912_lock : objectLock := RELEASED;
	signal J45_aspect : signalStates;
	signal J45_lock : objectLock := RELEASED;
	signal D20_position : singleSwitchStates := NORMAL;
	signal D20_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne101_state : nodeStates := FREE;
	signal ne101_lock : objectLock := RELEASED;
	signal J43_aspect : signalStates;
	signal J43_lock : objectLock := RELEASED;
	signal D09_position : singleSwitchStates := NORMAL;
	signal D09_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_J47 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne912_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne912)(2 to 3))));
	ne912_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne912)(0 to 1))));
	J45_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J45)(2 to 3))));
	J45_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J45)(0 to 1))));
	D20_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D20_state)(2 to 3))));
	D20_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D20_state)(0 to 1))));
	--Ocupation level 2
	ne101_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne101)(2 to 3))));
	ne101_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne101)(0 to 1))));
	J43_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J43)(2 to 3))));
	J43_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J43)(0 to 1))));
	D09_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(D09_state)(2 to 3))));
	D09_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(D09_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R28_command,R68_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R28_command = RELEASE and R68_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R28_command = RESERVE or R68_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R28_command = LOCK or R68_command = LOCK) then
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

	process(commandState,D20_position,D09_position)
	begin
		case commandState is

				if ((D20_position = NORMAL and D09_position = NORMAL)) then
					if (D20_position = NORMAL and D09_position = NORMAL) then
						path <= 1;
					end if;
				else
					path <= 0;
				end if;

				path <= 2;

				path <= 0;

				path <= 0;
		end case;
	end process;

	process(path,ne912_state,J45_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne912_state = OCCUPIED or ne912_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J45_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J45_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J45_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J45_aspect = GREEN) then
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