--  doubleSwitch_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity doubleSwitch_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R5_command : in routeCommands := RELEASE;
			R6_command : in routeCommands := RELEASE;
			R69_command : in routeCommands := RELEASE;
			R70_command : in routeCommands := RELEASE;
			R77_command : in routeCommands := RELEASE;
			R78_command : in routeCommands := RELEASE;
			R79_command : in routeCommands := RELEASE;
			R80_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end entity doubleSwitch_0;
architecture Behavioral of doubleSwitch_0 is
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

	process(timeout,R5_command,R6_command,R69_command,R70_command,R77_command,R78_command,R79_command,R80_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R5_command = RELEASE and R6_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R77_command = RELEASE and R78_command = RELEASE and R79_command = RELEASE and R80_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R5_command = RESERVE or R6_command = RESERVE or R69_command = RESERVE or R70_command = RESERVE or R77_command = RESERVE or R78_command = RESERVE or R79_command = RESERVE or R80_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R5_command = LOCK or R6_command = LOCK or R69_command = LOCK or R70_command = LOCK or R77_command = LOCK or R78_command = LOCK or R79_command = LOCK or R80_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,R5_command,R6_command,R69_command,R70_command,R77_command,R78_command,R79_command,R80_command)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				positionStateOut <= positionStateIn;
				lockStateOut <= RELEASED;
			when RESERVE =>
				if ((R78_command = RESERVE or R79_command = RESERVE) and (R5_command = RELEASE and R70_command = RELEASE and R6_command = RELEASE and R80_command = RELEASE and R69_command = RELEASE and R77_command = RELEASE)) then
					positionStateOut <= DOUBLE_NORMAL;
				end if;
				if ((R78_command = RELEASE and R79_command = RELEASE) and (R5_command = RESERVE or R70_command = RESERVE) and (R6_command = RELEASE and R80_command = RELEASE) and (R69_command = RELEASE and R77_command = RELEASE)) then
					positionStateOut <= DOUBLE_REVERSE;
				end if;
				if ((R78_command = RELEASE and R79_command = RELEASE) and (R5_command = RELEASE and R70_command = RELEASE) and (R6_command = RESERVE or R80_command = RESERVE) and (R69_command = RELEASE and R77_command = RELEASE)) then
					positionStateOut <= REVERSE_NORMAL;
				end if;
				if ((R78_command = RELEASE and R79_command = RELEASE) and (R5_command = RELEASE and R70_command = RELEASE) and (R6_command = RELEASE and R80_command = RELEASE) and (R69_command = RESERVE or R77_command = RESERVE)) then
					positionStateOut <= NORMAL_REVERSE;
				end if;
				lockStateOut <= RESERVED;
			when LOCK =>
				if ((R78_command = LOCK or R79_command = LOCK) and (R5_command = RELEASE and R70_command = RELEASE and R6_command = RELEASE and R80_command = RELEASE and R69_command = RELEASE and R77_command = RELEASE)) then
					positionStateOut <= DOUBLE_NORMAL;
				end if;
				if ((R78_command = RELEASE and R79_command = RELEASE) and (R5_command = LOCK or R70_command = LOCK) and (R6_command = RELEASE and R80_command = RELEASE) and (R69_command = RELEASE and R77_command = RELEASE)) then
					positionStateOut <= DOUBLE_REVERSE;
				end if;
				if ((R78_command = RELEASE and R79_command = RELEASE) and (R5_command = RELEASE and R70_command = RELEASE) and (R6_command = LOCK or R80_command = LOCK) and (R69_command = RELEASE and R77_command = RELEASE)) then
					positionStateOut <= REVERSE_NORMAL;
				end if;
				if ((R78_command = RELEASE and R79_command = RELEASE) and (R5_command = RELEASE and R70_command = RELEASE) and (R6_command = RELEASE and R80_command = RELEASE) and (R69_command = LOCK or R77_command = LOCK)) then
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