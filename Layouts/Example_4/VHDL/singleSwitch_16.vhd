--  singleSwitch_16.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity singleSwitch_16 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R13_command : in routeCommands := RELEASE;
			R48_command : in routeCommands := RELEASE;
			R49_command : in routeCommands := RELEASE;
			R50_command : in routeCommands := RELEASE;
			R52_command : in routeCommands := RELEASE;
			R53_command : in routeCommands := RELEASE;
			R54_command : in routeCommands := RELEASE;
			R81_command : in routeCommands := RELEASE;
			R82_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end entity singleSwitch_16;
architecture Behavioral of singleSwitch_16 is
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

	process(timeout,R13_command,R48_command,R49_command,R50_command,R52_command,R53_command,R54_command,R81_command,R82_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R13_command = RELEASE and R48_command = RELEASE and R49_command = RELEASE and R50_command = RELEASE and R52_command = RELEASE and R53_command = RELEASE and R54_command = RELEASE and R81_command = RELEASE and R82_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R13_command = RESERVE or R48_command = RESERVE or R49_command = RESERVE or R50_command = RESERVE or R52_command = RESERVE or R53_command = RESERVE or R54_command = RESERVE or R81_command = RESERVE or R82_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R13_command = LOCK or R48_command = LOCK or R49_command = LOCK or R50_command = LOCK or R52_command = LOCK or R53_command = LOCK or R54_command = LOCK or R81_command = LOCK or R82_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,R13_command,R48_command,R49_command,R50_command,R52_command,R53_command,R54_command,R81_command,R82_command)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				positionStateOut <= positionStateIn;
				lockStateOut <= RELEASED;
			when RESERVE =>
				if ((R48_command = RESERVE or R49_command = RESERVE or R53_command = RESERVE or R81_command = RESERVE or R82_command = RESERVE) and (R13_command = RELEASE and R50_command = RELEASE and R52_command = RELEASE and R54_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R48_command = RELEASE and R49_command = RELEASE and R53_command = RELEASE and R81_command = RELEASE and R82_command = RELEASE) and (R13_command = RESERVE or R50_command = RESERVE or R52_command = RESERVE or R54_command = RESERVE)) then
					positionStateOut <= REVERSE;
				end if;
				lockStateOut <= RESERVED;
			when LOCK =>
				if ((R48_command = LOCK or R49_command = LOCK or R53_command = LOCK or R81_command = LOCK or R82_command = LOCK) and (R13_command = RELEASE and R50_command = RELEASE and R52_command = RELEASE and R54_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R48_command = RELEASE and R49_command = RELEASE and R53_command = RELEASE and R81_command = RELEASE and R82_command = RELEASE) and (R13_command = LOCK or R50_command = LOCK or R52_command = LOCK or R54_command = LOCK)) then
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