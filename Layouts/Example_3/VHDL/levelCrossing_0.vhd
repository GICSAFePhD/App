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
			track_ne95 : in hex_char;
			track_ne9 : in hex_char;
			track_ne59 : in hex_char;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			R41_command : in routeCommands;
			R44_command : in routeCommands;
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
	signal ne95_state : nodeStates := FREE;
	signal ne9_state : nodeStates := FREE;
	signal ne59_state : nodeStates := FREE;
begin
	clock_in(0) <= clock;
	-- Assign the last 2 bits of indication to lockState
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	-- Assign the first 2 bits of indication to positionState
	positionStateIn <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	-- Assign the last 2 bits of track_x to x_state
	ne95_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne95)(2 to 3))));
	ne9_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne9)(2 to 3))));
	ne59_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne59)(2 to 3))));
	-- Update command based on the values of positionStateOut and lockStateOut
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(levelCrossingStates'pos(positionStateOut), 2)));
	-- Update correspondence based on the values of correspondenceState and lockStateOut
	correspondence <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(levelCrossingStates'pos(correspondenceState), 2)));
	gen : for i in 0 to 29 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(timeout,R25_command,R26_command,R41_command,R44_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R25_command = RELEASE and R26_command = RELEASE and R41_command = RELEASE and R44_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R25_command = RESERVE or R26_command = RESERVE or R41_command = RESERVE or R44_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R25_command = LOCK or R26_command = LOCK or R41_command = LOCK or R44_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,ne95_state,ne9_state,ne59_state)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				if ((ne95_state = OCCUPIED or ne9_state = OCCUPIED or ne59_state = OCCUPIED) and timeout = '0') then
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