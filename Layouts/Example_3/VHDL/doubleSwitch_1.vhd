--  doubleSwitch_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity doubleSwitch_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R36_command : in routeCommands;
			R37_command : in routeCommands;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			R82_command : in routeCommands;
			R83_command : in routeCommands;
			R89_command : in routeCommands;
			R90_command : in routeCommands;
			indication : in dSwitch_type;
			command : out dSwitch_type;
			correspondence_Sw07 : out doubleSwitchStates;
			lock_Sw07 : out objectLock
		);
	end entity doubleSwitch_1;
architecture Behavioral of doubleSwitch_1 is
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
				if (R36_command = RELEASE and R37_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R82_command = RELEASE and R83_command = RELEASE and R89_command = RELEASE and R90_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R36_command = RESERVE or R37_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE or R82_command = RESERVE or R83_command = RESERVE or R89_command = RESERVE or R90_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R36_command = LOCK or R37_command = LOCK or R65_command = LOCK or R66_command = LOCK or R82_command = LOCK or R83_command = LOCK or R89_command = LOCK or R90_command = LOCK) then
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
				lock_Sw07 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_Sw07 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_Sw07 <= LOCKED;
			when others =>
				lock_Sw07 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				commandAux.msb <= indication.msb;
				commandAux.lsb <= indication.lsb;
			when RESERVE =>
				if ((R37_command = RESERVE or R83_command = RESERVE) and (R65_command = RELEASE and R89_command = RELEASE) and (R36_command = RELEASE and R66_command = RELEASE) and (R82_command = RELEASE and R90_command = RELEASE)) then
					commandAux.msb <= '0';
					commandAux.lsb <= '0';
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = RESERVE or R89_command = RESERVE) and (R36_command = RELEASE and R66_command = RELEASE) and (R82_command = RELEASE and R90_command = RELEASE)) then
					commandAux.msb <= '0';
					commandAux.lsb <= '1';
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = RELEASE and R89_command = RELEASE) and (R36_command = RESERVE or R66_command = RESERVE) and (R82_command = RELEASE and R90_command = RELEASE)) then
					commandAux.msb <= '1';
					commandAux.lsb <= '0';
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = RELEASE and R89_command = RELEASE) and (R36_command = RELEASE and R66_command = RELEASE) and (R82_command = RESERVE or R90_command = RESERVE)) then
					commandAux.msb <= '1';
					commandAux.lsb <= '1';
				end if;
			when LOCK =>
				if ((R37_command = LOCK or R83_command = LOCK) and (R65_command = RELEASE and R89_command = RELEASE) and (R36_command = RELEASE and R66_command = RELEASE) and (R82_command = RELEASE and R90_command = RELEASE)) then
					commandAux.msb <= '0';
					commandAux.lsb <= '0';
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = LOCK or R89_command = LOCK) and (R36_command = RELEASE and R66_command = RELEASE) and (R82_command = RELEASE and R90_command = RELEASE)) then
					commandAux.msb <= '0';
					commandAux.lsb <= '1';
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = RELEASE and R89_command = RELEASE) and (R36_command = LOCK or R66_command = LOCK) and (R82_command = RELEASE and R90_command = RELEASE)) then
					commandAux.msb <= '1';
					commandAux.lsb <= '0';
				end if;
				if ((R37_command = RELEASE and R83_command = RELEASE) and (R65_command = RELEASE and R89_command = RELEASE) and (R36_command = RELEASE and R66_command = RELEASE) and (R82_command = LOCK or R90_command = LOCK)) then
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
					correspondence_Sw07 <= DOUBLE_NORMAL;
				end if;
				if(indication.msb = '1' and indication.lsb = '1') then
					correspondence_Sw07 <= DOUBLE_REVERSE;
				end if;
				if(indication.msb = '0' and indication.lsb = '1') then
					correspondence_Sw07 <= NORMAL_REVERSE;
				end if;
				if(indication.msb = '1' and indication.lsb = '0') then
					correspondence_Sw07 <= REVERSE_NORMAL;
				end if;
			else
				if (commandAux.msb = '0' and commandAux.lsb = '0' and indication.msb = '0' and indication.lsb = '0') then
					correspondence_Sw07 <= DOUBLE_NORMAL;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '1' and indication.msb = '1' and indication.lsb = '1') then
					correspondence_Sw07 <= DOUBLE_REVERSE;
					restart <= '1';
				end if;
				if (commandAux.msb = '0' and commandAux.lsb = '1' and indication.msb = '0' and indication.lsb = '1') then
					correspondence_Sw07 <= NORMAL_REVERSE;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '0' and indication.msb = '1' and indication.lsb = '0') then
					correspondence_Sw07 <= REVERSE_NORMAL;
					restart <= '1';
				end if;
				if ((commandAux.msb /= indication.msb) or (commandAux.lsb /= indication.lsb)) then
					correspondence_Sw07 <= TRANSITION;
					restart <= '0';
				end if;
			end if;
		end if;
	end process;
	command <= commandAux;
end Behavioral;