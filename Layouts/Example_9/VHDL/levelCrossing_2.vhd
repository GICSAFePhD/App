--  levelCrossing_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity levelCrossing_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne50 : in hex_char;
			track_ne48 : in hex_char;
			track_ne53 : in hex_char;
			R5_command : in routeCommands;
			R11_command : in routeCommands;
			R26_command : in routeCommands;
			R22_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end entity levelCrossing_2;
architecture Behavioral of levelCrossing_2 is
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
	signal ne50_state : nodeStates := FREE;
	signal ne48_state : nodeStates := FREE;
	signal ne53_state : nodeStates := FREE;
begin
	clock_in(0) <= clock;
	-- Assign the last 2 bits of indication to lockState
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	-- Assign the first 2 bits of indication to positionState
	positionStateIn <= levelCrossingStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	-- Assign the last 2 bits of track_x to x_state
	ne50_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne50)(2 to 3))));
	ne48_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne48)(2 to 3))));
	ne53_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne53)(2 to 3))));
	-- Update command based on the values of positionStateOut and lockStateOut
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(levelCrossingStates'pos(positionStateOut), 2)));
	-- Update correspondence based on the values of correspondenceState and lockStateOut
	correspondence <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(levelCrossingStates'pos(correspondenceState), 2)));
	gen : for i in 0 to 29 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(timeout,R5_command,R11_command,R26_command,R22_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R5_command = RELEASE and R11_command = RELEASE and R26_command = RELEASE and R22_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R5_command = RESERVE or R11_command = RESERVE or R26_command = RESERVE or R22_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R5_command = LOCK or R11_command = LOCK or R26_command = LOCK or R22_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,ne50_state,ne48_state,ne53_state)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				if ((ne50_state = OCCUPIED or ne48_state = OCCUPIED or ne53_state = OCCUPIED) and timeout = '0') then
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
		if (reset = '1' or Q = "0011010000100111011100001011111") then
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