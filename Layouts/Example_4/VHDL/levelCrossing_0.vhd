--  levelCrossing_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity levelCrossing_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne98 : in hex_char;
			track_ne996 : in hex_char;
			track_ne99 : in hex_char;
			R30_command : in routeCommands;
			R31_command : in routeCommands;
			R34_command : in routeCommands;
			R51_command : in routeCommands;
			R64_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end entity levelCrossing_0;
architecture Behavioral of levelCrossing_0 is
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
	signal positionStateIn : levelCrossingStates := UP;
	signal positionStateOut : levelCrossingStates := UP;
	signal correspondenceState : levelCrossingStates := UP;
	signal ne98_state : nodeStates := FREE;
	signal ne996_state : nodeStates := FREE;
	signal ne99_state : nodeStates := FREE;
begin
	clock_in(0) <= clock;
	-- Assign the last 2 bits of indication to lockState
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	-- Assign the first 2 bits of indication to positionState
	positionStateIn <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	-- Assign the last 2 bits of track_x to x_state
	ne98_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne98)(2 to 3))));
	ne996_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne996)(2 to 3))));
	ne99_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne99)(2 to 3))));
	-- Update command based on the values of positionStateOut and lockStateOut
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(levelCrossingStates'pos(positionStateOut), 2)));
	-- Update correspondence based on the values of correspondenceState and lockStateOut
	correspondence <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(levelCrossingStates'pos(correspondenceState), 2)));
	gen : for i in 0 to 29 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(timeout,R30_command,R31_command,R34_command,R51_command,R64_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R30_command = RELEASE and R31_command = RELEASE and R34_command = RELEASE and R51_command = RELEASE and R64_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R30_command = RESERVE or R31_command = RESERVE or R34_command = RESERVE or R51_command = RESERVE or R64_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R30_command = LOCK or R31_command = LOCK or R34_command = LOCK or R51_command = LOCK or R64_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,ne98_state,ne996_state,ne99_state)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				if ((ne98_state = OCCUPIED or ne996_state = OCCUPIED or ne99_state = OCCUPIED) and timeout = '0') then
					positionStateOut <= DOWN;
				else
					positionStateOut <= positionStateIn;
				end if;
				lockStateOut <= RELEASED;
			when RESERVE => -- DONT CHANGE
				positionStateOut <= DOWN;
				lockStateOut <= RESERVED;
			when LOCK => -- DONT CHANGE
				positionStateOut <= DOWN;
				lockStateOut <= LOCKED;
			when others =>
				positionStateOut <= DOWN;
				lockStateOut <= LOCKED;
		end case;
	end process;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "0010100110111001001001110000000") then
			timeout <= '1';
		end if;
		if (restart = '1') then
			timeout <= '0';
		end if;
	end process;

	process(timeout,positionStateOut,positionStateIn)
	begin
		if (positionStateOut = DOWN and positionStateIn = DOWN) then
			correspondenceState <= DOWN;
			restart <= '1';
		end if;
		if (positionStateOut = UP and positionStateIn = UP) then
			correspondenceState <= UP;
			restart <= '1';
		end if;
		if (positionStateOut /= positionStateIn) then
			correspondenceState <= TRANSITION;
			restart <= '0';
		end if;
	end process;
end Behavioral;