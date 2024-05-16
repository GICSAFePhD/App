--  singleSwitch_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			R7_command : in routeCommands;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R27_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw27 : out singleSwitchStates;
			lock_Sw27 : out objectLock
		);
	end entity singleSwitch_1;
architecture Behavioral of singleSwitch_1 is
	component flipFlop is
		port(
			clock : in std_logic;
			reset : in std_logic;
			Q : out std_logic
		);
	end component flipFlop;
	signal restart : std_logic := '0';
	signal Q : std_logic_vector(27 downto 0) := (others => '0');
	signal commandState : routeCommands;
	signal commandAux : std_logic;
begin
	gen : for i in 0 to 26 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;
	Q(0) <= clock;

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R4_command = RELEASE and R7_command = RELEASE and R20_command = RELEASE and R21_command = RELEASE and R22_command = RELEASE and R27_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R4_command = RESERVE or R7_command = RESERVE or R20_command = RESERVE or R21_command = RESERVE or R22_command = RESERVE or R27_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R4_command = LOCK or R7_command = LOCK or R20_command = LOCK or R21_command = LOCK or R22_command = LOCK or R27_command = LOCK) then
						commandState <= LOCK;
					end if;
				end if;
			end if;
		end if;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				lock_Sw27 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_Sw27 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_Sw27 <= LOCKED;
			when others =>
				lock_Sw27 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				commandAux <= indication;
			when RESERVE =>
				if ((R7_command = RESERVE or R20_command = RESERVE) and (R4_command = RELEASE and R21_command = RELEASE and R22_command = RELEASE and R27_command = RELEASE)) then
					commandAux <= '0';
				end if;
				if ((R7_command = RELEASE and R20_command = RELEASE) and (R4_command = RESERVE or R21_command = RESERVE or R22_command = RESERVE or R27_command = RESERVE)) then
					commandAux <= '1';
				end if;
			when LOCK =>
				if ((R7_command = LOCK or R20_command = LOCK) and (R4_command = RELEASE and R21_command = RELEASE and R22_command = RELEASE and R27_command = RELEASE)) then
					commandAux <= '0';
				end if;
				if ((R7_command = RELEASE and R20_command = RELEASE) and (R4_command = LOCK or R21_command = LOCK or R22_command = LOCK or R27_command = LOCK)) then
					commandAux <= '1';
				end if;
			when others =>
				commandAux <= indication;
		end case;
	end process;

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if( reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
				restart <= '1';
				if(indication = '0') then
					correspondence_Sw27 <= NORMAL;
				else
					correspondence_Sw27 <= REVERSE;
				end if;
			else
				if (commandAux = '0' and indication = '0') then
					correspondence_Sw27 <= NORMAL;
					restart <= '1';
				end if;
				if (commandAux = '1' and indication = '1') then
					correspondence_Sw27 <= REVERSE;
					restart <= '1';
				end if;
				if (commandAux /= indication) then
					correspondence_Sw27 <= TRANSITION;
					restart <= '0';
				end if;
			end if;
		end if;
	end process;
	command <= commandAux;
end Behavioral;