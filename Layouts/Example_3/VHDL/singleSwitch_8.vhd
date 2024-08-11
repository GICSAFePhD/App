--  singleSwitch_8.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity singleSwitch_8 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R7_command : in routeCommands := RELEASE;
			R8_command : in routeCommands := RELEASE;
			R73_command : in routeCommands := RELEASE;
			R74_command : in routeCommands := RELEASE;
			R75_command : in routeCommands := RELEASE;
			R76_command : in routeCommands := RELEASE;
			R53_command : in routeCommands := RELEASE;
			R52_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end entity singleSwitch_8;
architecture Behavioral of singleSwitch_8 is
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

	process(timeout,R7_command,R8_command,R73_command,R74_command,R75_command,R76_command,R53_command,R52_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R7_command = RELEASE and R8_command = RELEASE and R73_command = RELEASE and R74_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE and R53_command = RELEASE and R52_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R7_command = RESERVE or R8_command = RESERVE or R73_command = RESERVE or R74_command = RESERVE or R75_command = RESERVE or R76_command = RESERVE or R53_command = RESERVE or R52_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R7_command = LOCK or R8_command = LOCK or R73_command = LOCK or R74_command = LOCK or R75_command = LOCK or R76_command = LOCK or R53_command = LOCK or R52_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,R7_command,R8_command,R73_command,R74_command,R75_command,R76_command,R53_command,R52_command)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				positionStateOut <= positionStateIn;
				lockStateOut <= RELEASED;
			when RESERVE =>
				if ((R7_command = RESERVE or R74_command = RESERVE or R53_command = RESERVE or R52_command = RESERVE) and (R8_command = RELEASE and R73_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R7_command = RELEASE and R74_command = RELEASE and R53_command = RELEASE and R52_command = RELEASE) and (R8_command = RESERVE or R73_command = RESERVE or R75_command = RESERVE or R76_command = RESERVE)) then
					positionStateOut <= REVERSE;
				end if;
				lockStateOut <= RESERVED;
			when LOCK =>
				if ((R7_command = LOCK or R74_command = LOCK or R53_command = LOCK or R52_command = LOCK) and (R8_command = RELEASE and R73_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R7_command = RELEASE and R74_command = RELEASE and R53_command = RELEASE and R52_command = RELEASE) and (R8_command = LOCK or R73_command = LOCK or R75_command = LOCK or R76_command = LOCK)) then
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