--  singleSwitch_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity singleSwitch_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R36_command : in routeCommands := RELEASE;
			R63_command : in routeCommands := RELEASE;
			R64_command : in routeCommands := RELEASE;
			R65_command : in routeCommands := RELEASE;
			R66_command : in routeCommands := RELEASE;
			R89_command : in routeCommands := RELEASE;
			R43_command : in routeCommands := RELEASE;
			R14_command : in routeCommands := RELEASE;
			R33_command : in routeCommands := RELEASE;
			R91_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end entity singleSwitch_3;
architecture Behavioral of singleSwitch_3 is
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

	process(timeout,R36_command,R63_command,R64_command,R65_command,R66_command,R89_command,R43_command,R14_command,R33_command,R91_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R36_command = RELEASE and R63_command = RELEASE and R64_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R89_command = RELEASE and R43_command = RELEASE and R14_command = RELEASE and R33_command = RELEASE and R91_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R36_command = RESERVE or R63_command = RESERVE or R64_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE or R89_command = RESERVE or R43_command = RESERVE or R14_command = RESERVE or R33_command = RESERVE or R91_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R36_command = LOCK or R63_command = LOCK or R64_command = LOCK or R65_command = LOCK or R66_command = LOCK or R89_command = LOCK or R43_command = LOCK or R14_command = LOCK or R33_command = LOCK or R91_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,R36_command,R63_command,R64_command,R65_command,R66_command,R89_command,R43_command,R14_command,R33_command,R91_command)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				positionStateOut <= positionStateIn;
				lockStateOut <= RELEASED;
			when RESERVE =>
				if ((R63_command = RESERVE or R64_command = RESERVE or R43_command = RESERVE or R33_command = RESERVE) and (R36_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R89_command = RELEASE and R14_command = RELEASE and R91_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R63_command = RELEASE and R64_command = RELEASE and R43_command = RELEASE and R33_command = RELEASE) and (R36_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE or R89_command = RESERVE or R14_command = RESERVE or R91_command = RESERVE)) then
					positionStateOut <= REVERSE;
				end if;
				lockStateOut <= RESERVED;
			when LOCK =>
				if ((R63_command = LOCK or R64_command = LOCK or R43_command = LOCK or R33_command = LOCK) and (R36_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R89_command = RELEASE and R14_command = RELEASE and R91_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R63_command = RELEASE and R64_command = RELEASE and R43_command = RELEASE and R33_command = RELEASE) and (R36_command = LOCK or R65_command = LOCK or R66_command = LOCK or R89_command = LOCK or R14_command = LOCK or R91_command = LOCK)) then
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