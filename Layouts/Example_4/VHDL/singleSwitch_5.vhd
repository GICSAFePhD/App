--  singleSwitch_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity singleSwitch_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R55_command : in routeCommands := RELEASE;
			R57_command : in routeCommands := RELEASE;
			R58_command : in routeCommands := RELEASE;
			R77_command : in routeCommands := RELEASE;
			R69_command : in routeCommands := RELEASE;
			R70_command : in routeCommands := RELEASE;
			R6_command : in routeCommands := RELEASE;
			R7_command : in routeCommands := RELEASE;
			R38_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end entity singleSwitch_5;
architecture Behavioral of singleSwitch_5 is
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

	process(timeout,R55_command,R57_command,R58_command,R77_command,R69_command,R70_command,R6_command,R7_command,R38_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R55_command = RELEASE and R57_command = RELEASE and R58_command = RELEASE and R77_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R6_command = RELEASE and R7_command = RELEASE and R38_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R55_command = RESERVE or R57_command = RESERVE or R58_command = RESERVE or R77_command = RESERVE or R69_command = RESERVE or R70_command = RESERVE or R6_command = RESERVE or R7_command = RESERVE or R38_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R55_command = LOCK or R57_command = LOCK or R58_command = LOCK or R77_command = LOCK or R69_command = LOCK or R70_command = LOCK or R6_command = LOCK or R7_command = LOCK or R38_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,R55_command,R57_command,R58_command,R77_command,R69_command,R70_command,R6_command,R7_command,R38_command)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				positionStateOut <= positionStateIn;
				lockStateOut <= RELEASED;
			when RESERVE =>
				if ((R55_command = RESERVE or R57_command = RESERVE or R70_command = RESERVE or R7_command = RESERVE or R38_command = RESERVE) and (R58_command = RELEASE and R77_command = RELEASE and R69_command = RELEASE and R6_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R55_command = RELEASE and R57_command = RELEASE and R70_command = RELEASE and R7_command = RELEASE and R38_command = RELEASE) and (R58_command = RESERVE or R77_command = RESERVE or R69_command = RESERVE or R6_command = RESERVE)) then
					positionStateOut <= REVERSE;
				end if;
				lockStateOut <= RESERVED;
			when LOCK =>
				if ((R55_command = LOCK or R57_command = LOCK or R70_command = LOCK or R7_command = LOCK or R38_command = LOCK) and (R58_command = RELEASE and R77_command = RELEASE and R69_command = RELEASE and R6_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R55_command = RELEASE and R57_command = RELEASE and R70_command = RELEASE and R7_command = RELEASE and R38_command = RELEASE) and (R58_command = LOCK or R77_command = LOCK or R69_command = LOCK or R6_command = LOCK)) then
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
		if (reset = '1' or Q = "0010100110111001001001110000000") then
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