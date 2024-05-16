--  singleSwitch_8.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R27_command : in routeCommands;
			R68_command : in routeCommands;
			R69_command : in routeCommands;
			R70_command : in routeCommands;
			R71_command : in routeCommands;
			R73_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D23 : out singleSwitchStates;
			lock_D23 : out objectLock
		);
	end entity singleSwitch_8;
architecture Behavioral of singleSwitch_8 is
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
				if (R27_command = RELEASE and R68_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R71_command = RELEASE and R73_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R27_command = RESERVE or R68_command = RESERVE or R69_command = RESERVE or R70_command = RESERVE or R71_command = RESERVE or R73_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R27_command = LOCK or R68_command = LOCK or R69_command = LOCK or R70_command = LOCK or R71_command = LOCK or R73_command = LOCK) then
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
				lock_D23 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_D23 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_D23 <= LOCKED;
			when others =>
				lock_D23 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				commandAux <= indication;
			when RESERVE =>
				if ((R27_command = RESERVE or R68_command = RESERVE) and (R69_command = RELEASE and R70_command = RELEASE and R71_command = RELEASE and R73_command = RELEASE)) then
					commandAux <= '0';
				end if;
				if ((R27_command = RELEASE and R68_command = RELEASE) and (R69_command = RESERVE or R70_command = RESERVE or R71_command = RESERVE or R73_command = RESERVE)) then
					commandAux <= '1';
				end if;
			when LOCK =>
				if ((R27_command = LOCK or R68_command = LOCK) and (R69_command = RELEASE and R70_command = RELEASE and R71_command = RELEASE and R73_command = RELEASE)) then
					commandAux <= '0';
				end if;
				if ((R27_command = RELEASE and R68_command = RELEASE) and (R69_command = LOCK or R70_command = LOCK or R71_command = LOCK or R73_command = LOCK)) then
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
					correspondence_D23 <= NORMAL;
				else
					correspondence_D23 <= REVERSE;
				end if;
			else
				if (commandAux = '0' and indication = '0') then
					correspondence_D23 <= NORMAL;
					restart <= '1';
				end if;
				if (commandAux = '1' and indication = '1') then
					correspondence_D23 <= REVERSE;
					restart <= '1';
				end if;
				if (commandAux /= indication) then
					correspondence_D23 <= TRANSITION;
					restart <= '0';
				end if;
			end if;
		end if;
	end process;
	command <= commandAux;
end Behavioral;