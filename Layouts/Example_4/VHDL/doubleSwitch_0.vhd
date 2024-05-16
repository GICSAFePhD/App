--  doubleSwitch_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity doubleSwitch_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R69_command : in routeCommands;
			R70_command : in routeCommands;
			R71_command : in routeCommands;
			R72_command : in routeCommands;
			R73_command : in routeCommands;
			R74_command : in routeCommands;
			indication : in dSwitch_type;
			command : out dSwitch_type;
			correspondence_D12 : out doubleSwitchStates;
			lock_D12 : out objectLock
		);
	end entity doubleSwitch_0;
architecture Behavioral of doubleSwitch_0 is
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
	signal commandAux : dSwitch_type;
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
				if (R6_command = RELEASE and R7_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R71_command = RELEASE and R72_command = RELEASE and R73_command = RELEASE and R74_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R6_command = RESERVE or R7_command = RESERVE or R69_command = RESERVE or R70_command = RESERVE or R71_command = RESERVE or R72_command = RESERVE or R73_command = RESERVE or R74_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R6_command = LOCK or R7_command = LOCK or R69_command = LOCK or R70_command = LOCK or R71_command = LOCK or R72_command = LOCK or R73_command = LOCK or R74_command = LOCK) then
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
				lock_D12 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_D12 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_D12 <= LOCKED;
			when others =>
				lock_D12 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				commandAux.msb <= indication.msb;
				commandAux.lsb <= indication.lsb;
			when RESERVE =>
				if ((R7_command = RESERVE or R74_command = RESERVE) and (R69_command = RELEASE and R71_command = RELEASE) and (R6_command = RELEASE and R72_command = RELEASE) and (R70_command = RELEASE and R73_command = RELEASE)) then
					commandAux.msb <= '0';
					commandAux.lsb <= '0';
				end if;
				if ((R7_command = RELEASE and R74_command = RELEASE) and (R69_command = RESERVE or R71_command = RESERVE) and (R6_command = RELEASE and R72_command = RELEASE) and (R70_command = RELEASE and R73_command = RELEASE)) then
					commandAux.msb <= '0';
					commandAux.lsb <= '1';
				end if;
				if ((R7_command = RELEASE and R74_command = RELEASE) and (R69_command = RELEASE and R71_command = RELEASE) and (R6_command = RESERVE or R72_command = RESERVE) and (R70_command = RELEASE and R73_command = RELEASE)) then
					commandAux.msb <= '1';
					commandAux.lsb <= '0';
				end if;
				if ((R7_command = RELEASE and R74_command = RELEASE) and (R69_command = RELEASE and R71_command = RELEASE) and (R6_command = RELEASE and R72_command = RELEASE) and (R70_command = RESERVE or R73_command = RESERVE)) then
					commandAux.msb <= '1';
					commandAux.lsb <= '1';
				end if;
			when LOCK =>
				if ((R7_command = LOCK or R74_command = LOCK) and (R69_command = RELEASE and R71_command = RELEASE) and (R6_command = RELEASE and R72_command = RELEASE) and (R70_command = RELEASE and R73_command = RELEASE)) then
					commandAux.msb <= '0';
					commandAux.lsb <= '0';
				end if;
				if ((R7_command = RELEASE and R74_command = RELEASE) and (R69_command = LOCK or R71_command = LOCK) and (R6_command = RELEASE and R72_command = RELEASE) and (R70_command = RELEASE and R73_command = RELEASE)) then
					commandAux.msb <= '0';
					commandAux.lsb <= '1';
				end if;
				if ((R7_command = RELEASE and R74_command = RELEASE) and (R69_command = RELEASE and R71_command = RELEASE) and (R6_command = LOCK or R72_command = LOCK) and (R70_command = RELEASE and R73_command = RELEASE)) then
					commandAux.msb <= '1';
					commandAux.lsb <= '0';
				end if;
				if ((R7_command = RELEASE and R74_command = RELEASE) and (R69_command = RELEASE and R71_command = RELEASE) and (R6_command = RELEASE and R72_command = RELEASE) and (R70_command = LOCK or R73_command = LOCK)) then
					commandAux.msb <= '1';
					commandAux.lsb <= '1';
				end if;
			when others =>
				commandAux.msb <= indication.msb;
				commandAux.lsb <= indication.lsb;
		end case;
	end process;

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if(reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
				restart <= '1';
				if(indication.msb = '0' and indication.lsb = '0') then
					correspondence_D12 <= DOUBLE_NORMAL;
				end if;
				if(indication.msb = '1' and indication.lsb = '1') then
					correspondence_D12 <= DOUBLE_REVERSE;
				end if;
				if(indication.msb = '0' and indication.lsb = '1') then
					correspondence_D12 <= NORMAL_REVERSE;
				end if;
				if(indication.msb = '1' and indication.lsb = '0') then
					correspondence_D12 <= REVERSE_NORMAL;
				end if;
			else
				if (commandAux.msb = '0' and commandAux.lsb = '0' and indication.msb = '0' and indication.lsb = '0') then
					correspondence_D12 <= DOUBLE_NORMAL;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '1' and indication.msb = '1' and indication.lsb = '1') then
					correspondence_D12 <= DOUBLE_REVERSE;
					restart <= '1';
				end if;
				if (commandAux.msb = '0' and commandAux.lsb = '1' and indication.msb = '0' and indication.lsb = '1') then
					correspondence_D12 <= NORMAL_REVERSE;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '0' and indication.msb = '1' and indication.lsb = '0') then
					correspondence_D12 <= REVERSE_NORMAL;
					restart <= '1';
				end if;
				if ((commandAux.msb /= indication.msb) or (commandAux.lsb /= indication.lsb)) then
					correspondence_D12 <= TRANSITION;
					restart <= '0';
				end if;
			end if;
		end if;
	end process;
	command <= commandAux;
end Behavioral;