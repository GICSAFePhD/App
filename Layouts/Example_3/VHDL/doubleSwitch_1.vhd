--  doubleSwitch_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity doubleSwitch_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R36_command : in routeCommands := RELEASE;
			R37_command : in routeCommands := RELEASE;
			R65_command : in routeCommands := RELEASE;
			R66_command : in routeCommands := RELEASE;
			R82_command : in routeCommands := RELEASE;
			R83_command : in routeCommands := RELEASE;
			R89_command : in routeCommands := RELEASE;
			R90_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end entity doubleSwitch_1;
architecture Behavioral of doubleSwitch_1 is
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
	signal positionStateIn : doubleSwitchStates := DOUBLE_NORMAL;
	signal positionStateOut : doubleSwitchStates := DOUBLE_NORMAL;
	signal correspondenceState : doubleSwitchStates := DOUBLE_NORMAL;
begin
	clock_in(0) <= clock;
	-- Assign the last 2 bits of indication to lockState
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	-- Assign the first 2 bits of indication to positionState
	positionStateIn <= doubleSwitchStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	-- Update command based on the values of positionStateOut and lockStateOut
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(doubleSwitchStates'pos(positionStateOut), 2)));
	-- Update correspondence based on the values of correspondenceState and lockStateOut
	correspondence <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(doubleSwitchStates'pos(correspondenceState), 2)));
	gen : for i in 0 to 29 generate
		 inst: flipFlop port map(clock_in(i), restart, Q(i));
		clock_in(i+1) <= Q(i);
	end generate;

	process(timeout,R36_command,R37_command,R65_command,R66_command,R82_command,R83_command,R89_command,R90_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R36_command = RELEASE and R37_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R82_command = RELEASE and R83_command = RELEASE and R89_command = RELEASE and R90_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R36_command = RESERVE or R37_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE or R82_command = RESERVE or R83_command = RESERVE or R89_command = RESERVE or R90_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R36_command = LOCK or R37_command = LOCK or R65_command = LOCK or R66_command = LOCK or R82_command = LOCK or R83_command = LOCK or R89_command = LOCK or R90_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,R36_command,R37_command,R65_command,R66_command,R82_command,R83_command,R89_command,R90_command)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				positionStateOut <= positionStateIn;
				lockStateOut <= RELEASED;
			when RESERVE =>
				if ((R37_command = RESERVE or R83_command = RESERVE) and (R65_command = RELEASE and R89_command = RELEASE and R82_command = RELEASE and R90_command = RELEASE and R36_command = RELEASE and R66_command = RELEASE)) then
					positionStateOut <= DOUBLE_NORMAL;
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = RESERVE or R89_command = RESERVE) and (R82_command = RELEASE and R90_command = RELEASE) and (R36_command = RELEASE and R66_command = RELEASE)) then
					positionStateOut <= DOUBLE_REVERSE;
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = RELEASE and R89_command = RELEASE) and (R82_command = RESERVE or R90_command = RESERVE) and (R36_command = RELEASE and R66_command = RELEASE)) then
					positionStateOut <= REVERSE_NORMAL;
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = RELEASE and R89_command = RELEASE) and (R82_command = RELEASE and R90_command = RELEASE) and (R36_command = RESERVE or R66_command = RESERVE)) then
					positionStateOut <= NORMAL_REVERSE;
				end if;
				lockStateOut <= RESERVED;
			when LOCK =>
				if ((R37_command = LOCK or R83_command = LOCK) and (R65_command = RELEASE and R89_command = RELEASE and R82_command = RELEASE and R90_command = RELEASE and R36_command = RELEASE and R66_command = RELEASE)) then
					positionStateOut <= DOUBLE_NORMAL;
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = LOCK or R89_command = LOCK) and (R82_command = RELEASE and R90_command = RELEASE) and (R36_command = RELEASE and R66_command = RELEASE)) then
					positionStateOut <= DOUBLE_REVERSE;
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = RELEASE and R89_command = RELEASE) and (R82_command = LOCK or R90_command = LOCK) and (R36_command = RELEASE and R66_command = RELEASE)) then
					positionStateOut <= REVERSE_NORMAL;
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = RELEASE and R89_command = RELEASE) and (R82_command = RELEASE and R90_command = RELEASE) and (R36_command = LOCK or R66_command = LOCK)) then
					positionStateOut <= NORMAL_REVERSE;
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
		if (positionStateOut = DOUBLE_NORMAL and positionStateIn = DOUBLE_NORMAL) then
			correspondenceState <= DOUBLE_NORMAL;
			restart <= '1';
		end if;
		if (positionStateOut = DOUBLE_REVERSE and positionStateIn = DOUBLE_REVERSE) then
			correspondenceState <= DOUBLE_REVERSE;
			restart <= '1';
		end if;
		if (positionStateOut = REVERSE_NORMAL and positionStateIn = REVERSE_NORMAL) then
			correspondenceState <= REVERSE_NORMAL;
			restart <= '1';
		end if;
		if (positionStateOut = NORMAL_REVERSE and positionStateIn = NORMAL_REVERSE) then
			correspondenceState <= NORMAL_REVERSE;
			restart <= '1';
		end if;
		if (positionStateOut /= positionStateIn) then
			correspondenceState <= TRANSITION;
			restart <= '0';
		end if;
	end process;
end Behavioral;