--  singleSwitch_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw05 : out singleSwitchStates;
			lock_Sw05 : out objectLock
		);
	end entity singleSwitch_3;
architecture Behavioral of singleSwitch_3 is
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
				if (R3_command = RELEASE and R6_command = RELEASE and R18_command = RELEASE and R19_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R3_command = RESERVE or R6_command = RESERVE or R18_command = RESERVE or R19_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R3_command = LOCK or R6_command = LOCK or R18_command = LOCK or R19_command = LOCK) then
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
				lock_Sw05 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_Sw05 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_Sw05 <= LOCKED;
			when others =>
				lock_Sw05 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				commandAux <= indication;
			when RESERVE =>
				if ((R6_command = RESERVE or R19_command = RESERVE) and (R3_command = RELEASE and R18_command = RELEASE)) then
					commandAux <= '0';
				end if;
				if ((R6_command = RELEASE and R19_command = RELEASE) and (R3_command = RESERVE or R18_command = RESERVE)) then
					commandAux <= '1';
				end if;
			when LOCK =>
				if ((R6_command = LOCK or R19_command = LOCK) and (R3_command = RELEASE and R18_command = RELEASE)) then
					commandAux <= '0';
				end if;
				if ((R6_command = RELEASE and R19_command = RELEASE) and (R3_command = LOCK or R18_command = LOCK)) then
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
					correspondence_Sw05 <= NORMAL;
				else
					correspondence_Sw05 <= REVERSE;
				end if;
			else
				if (commandAux = '0' and indication = '0') then
					correspondence_Sw05 <= NORMAL;
					restart <= '1';
				end if;
				if (commandAux = '1' and indication = '1') then
					correspondence_Sw05 <= REVERSE;
					restart <= '1';
				end if;
				if (commandAux /= indication) then
					correspondence_Sw05 <= TRANSITION;
					restart <= '0';
				end if;
			end if;
		end if;
	end process;
	command <= commandAux;
end Behavioral;