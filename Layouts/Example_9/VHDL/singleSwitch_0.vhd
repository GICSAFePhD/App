--  singleSwitch_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity singleSwitch_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R8_command : in routeCommands := RELEASE;
			R10_command : in routeCommands := RELEASE;
			R19_command : in routeCommands := RELEASE;
			R23_command : in routeCommands := RELEASE;
			R24_command : in routeCommands := RELEASE;
			R25_command : in routeCommands := RELEASE;
			R26_command : in routeCommands := RELEASE;
			R1_command : in routeCommands := RELEASE;
			R18_command : in routeCommands := RELEASE;
			R3_command : in routeCommands := RELEASE;
			R5_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end entity singleSwitch_0;
architecture Behavioral of singleSwitch_0 is
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
	signal positionStateIn : singleSwitchStates := NORMAL;
	signal positionStateOut : singleSwitchStates := NORMAL;
	signal correspondenceState : singleSwitchStates := NORMAL;
begin
	clock_in(0) <= clock;
	-- Assign the last 2 bits of indication to lockState
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	-- Assign the first 2 bits of indication to positionState
	positionStateIn <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	-- Update command based on the values of positionStateOut and lockStateOut
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(singleSwitchStates'pos(positionStateOut), 2)));
	-- Update correspondence based on the values of correspondenceState and lockStateOut
	correspondence <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(singleSwitchStates'pos(correspondenceState), 2)));
	gen : for i in 0 to 29 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(timeout,R8_command,R10_command,R19_command,R23_command,R24_command,R25_command,R26_command,R1_command,R18_command,R3_command,R5_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R8_command = RELEASE and R10_command = RELEASE and R19_command = RELEASE and R23_command = RELEASE and R24_command = RELEASE and R25_command = RELEASE and R26_command = RELEASE and R1_command = RELEASE and R18_command = RELEASE and R3_command = RELEASE and R5_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R8_command = RESERVE or R10_command = RESERVE or R19_command = RESERVE or R23_command = RESERVE or R24_command = RESERVE or R25_command = RESERVE or R26_command = RESERVE or R1_command = RESERVE or R18_command = RESERVE or R3_command = RESERVE or R5_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R8_command = LOCK or R10_command = LOCK or R19_command = LOCK or R23_command = LOCK or R24_command = LOCK or R25_command = LOCK or R26_command = LOCK or R1_command = LOCK or R18_command = LOCK or R3_command = LOCK or R5_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,R8_command,R10_command,R19_command,R23_command,R24_command,R25_command,R26_command,R1_command,R18_command,R3_command,R5_command)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				positionStateOut <= positionStateIn;
				lockStateOut <= RELEASED;
			when RESERVE =>
				if ((R23_command = RESERVE or R24_command = RESERVE or R1_command = RESERVE or R18_command = RESERVE) and (R8_command = RELEASE and R10_command = RELEASE and R19_command = RELEASE and R25_command = RELEASE and R26_command = RELEASE and R3_command = RELEASE and R5_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R23_command = RELEASE and R24_command = RELEASE and R1_command = RELEASE and R18_command = RELEASE) and (R8_command = RESERVE or R10_command = RESERVE or R19_command = RESERVE or R25_command = RESERVE or R26_command = RESERVE or R3_command = RESERVE or R5_command = RESERVE)) then
					positionStateOut <= REVERSE;
				end if;
				lockStateOut <= RESERVED;
			when LOCK =>
				if ((R23_command = LOCK or R24_command = LOCK or R1_command = LOCK or R18_command = LOCK) and (R8_command = RELEASE and R10_command = RELEASE and R19_command = RELEASE and R25_command = RELEASE and R26_command = RELEASE and R3_command = RELEASE and R5_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R23_command = RELEASE and R24_command = RELEASE and R1_command = RELEASE and R18_command = RELEASE) and (R8_command = LOCK or R10_command = LOCK or R19_command = LOCK or R25_command = LOCK or R26_command = LOCK or R3_command = LOCK or R5_command = LOCK)) then
					positionStateOut <= REVERSE;
				end if;
				lockStateOut <= LOCKED;
			when others =>
				positionStateOut <= positionStateIn;
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
		if (positionStateOut = NORMAL and positionStateIn = NORMAL) then
			correspondenceState <= NORMAL;
			restart <= '1';
		end if;
		if (positionStateOut = REVERSE and positionStateIn = REVERSE) then
			correspondenceState <= REVERSE;
			restart <= '1';
		end if;
		if (positionStateOut /= positionStateIn) then
			correspondenceState <= TRANSITION;
			restart <= '0';
		end if;
	end process;
end Behavioral;