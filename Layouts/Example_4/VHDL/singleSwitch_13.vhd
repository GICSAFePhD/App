--  singleSwitch_13.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity singleSwitch_13 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R85_command : in routeCommands := RELEASE;
			R86_command : in routeCommands := RELEASE;
			R87_command : in routeCommands := RELEASE;
			R89_command : in routeCommands := RELEASE;
			R45_command : in routeCommands := RELEASE;
			R31_command : in routeCommands := RELEASE;
			R11_command : in routeCommands := RELEASE;
			R42_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end entity singleSwitch_13;
architecture Behavioral of singleSwitch_13 is
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

	process(timeout,R85_command,R86_command,R87_command,R89_command,R45_command,R31_command,R11_command,R42_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R85_command = RELEASE and R86_command = RELEASE and R87_command = RELEASE and R89_command = RELEASE and R45_command = RELEASE and R31_command = RELEASE and R11_command = RELEASE and R42_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R85_command = RESERVE or R86_command = RESERVE or R87_command = RESERVE or R89_command = RESERVE or R45_command = RESERVE or R31_command = RESERVE or R11_command = RESERVE or R42_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R85_command = LOCK or R86_command = LOCK or R87_command = LOCK or R89_command = LOCK or R45_command = LOCK or R31_command = LOCK or R11_command = LOCK or R42_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(timeout,commandState,positionStateIn,R85_command,R86_command,R87_command,R89_command,R45_command,R31_command,R11_command,R42_command)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				positionStateOut <= positionStateIn;
				lockStateOut <= RELEASED;
			when RESERVE =>
				if ((R85_command = RESERVE or R86_command = RESERVE or R45_command = RESERVE or R11_command = RESERVE or R42_command = RESERVE) and (R87_command = RELEASE and R89_command = RELEASE and R31_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R85_command = RELEASE and R86_command = RELEASE and R45_command = RELEASE and R11_command = RELEASE and R42_command = RELEASE) and (R87_command = RESERVE or R89_command = RESERVE or R31_command = RESERVE)) then
					positionStateOut <= REVERSE;
				end if;
				lockStateOut <= RESERVED;
			when LOCK =>
				if ((R85_command = LOCK or R86_command = LOCK or R45_command = LOCK or R11_command = LOCK or R42_command = LOCK) and (R87_command = RELEASE and R89_command = RELEASE and R31_command = RELEASE)) then
					positionStateOut <= NORMAL;
				end if;
				if ((R85_command = RELEASE and R86_command = RELEASE and R45_command = RELEASE and R11_command = RELEASE and R42_command = RELEASE) and (R87_command = LOCK or R89_command = LOCK or R31_command = LOCK)) then
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