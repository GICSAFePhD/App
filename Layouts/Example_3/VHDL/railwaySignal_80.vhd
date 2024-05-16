--  railwaySignal_80.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity railwaySignal_80 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R58_command : in routeCommands;
			R59_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne110 : in std_logic;
			correspondence_S102 : out signalStates;
			lock_S102 : out objectLock;
			--Ocupation level 1
			ocupation_ne32 : in std_logic;
			ocupation_ne29 : in std_logic;
			correspondence_S115 : in signalStates;
			correspondence_B101 : in signalStates;
			Sw09_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne82 : in std_logic;
			ocupation_ne41 : in std_logic;
			ocupation_ne83 : in std_logic;
			ocupation_ne84 : in std_logic;
			correspondence_C95 : in signalStates;
			correspondence_P58 : in signalStates;
			correspondence_T13 : in signalStates;
			correspondence_B96 : in signalStates;
			Sw04_state : in singleSwitchStates;
			Sw05_state : in doubleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end entity railwaySignal_80;
architecture Behavioral of railwaySignal_80 is
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
	signal aspectState : signalStates;
	signal commandAux : signal_type;
	signal path : integer := 0;
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
				if (R58_command = RELEASE and R59_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R58_command = RESERVE or R59_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R58_command = LOCK or R59_command = LOCK) then
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
				lock_S102 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_S102 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_S102 <= LOCKED;
			when others =>
				lock_S102 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE | LOCK =>
				if ((Sw09_state = NORMAL and Sw04_state = NORMAL) or (Sw09_state = NORMAL and Sw04_state = REVERSE and Sw05_state = REVERSE_NORMAL) or (Sw09_state = NORMAL and Sw04_state = REVERSE and Sw05_state = DOUBLE_REVERSE) or (Sw09_state = REVERSE)) then
					if (Sw09_state = NORMAL and Sw04_state = NORMAL) then
						path <= 1;
					end if;
					if (Sw09_state = NORMAL and Sw04_state = REVERSE and Sw05_state = REVERSE_NORMAL) then
						path <= 2;
					end if;
					if (Sw09_state = NORMAL and Sw04_state = REVERSE and Sw05_state = DOUBLE_REVERSE) then
						path <= 3;
					end if;
					if (Sw09_state = REVERSE) then
						path <= 4;
					end if;
				else
					path <= 0;
				end if;
			when RESERVE =>
				path <= 0;
			when others =>
				path <= 0;
		end case;
	end process;

	process(clock)
	begin
		case path is
			when 0 =>
				aspectState <= RED;
			when 1 =>
				if (ocupation_ne32 = '0') then
					aspectState <= RED;
				else
					if (correspondence_S115 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_S115 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_S115 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_S115 = GREEN) then
						aspectState <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ocupation_ne32 = '0') then
					aspectState <= RED;
				else
					if (correspondence_S115 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_S115 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_S115 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_S115 = GREEN) then
						aspectState <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ocupation_ne32 = '0') then
					aspectState <= RED;
				else
					if (correspondence_S115 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_S115 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_S115 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_S115 = GREEN) then
						aspectState <= GREEN;
					end if;
				end if;
			when 4 =>
				if (ocupation_ne29 = '0') then
					aspectState <= RED;
				else
					if (correspondence_B101 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_B101 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_B101 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_B101 = GREEN) then
						aspectState <= GREEN;
					end if;
				end if;
			when others =>
				aspectState <= RED;
		end case;
	end process;

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if(reset = '1' or (Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0')) then
				restart <= '1';
				if(indication.msb = '0' and indication.lsb = '0') then
					correspondence_S102 <= RED;
				end if;
				if(indication.msb = '1' and indication.lsb = '1') then
					correspondence_S102 <= GREEN;
				end if;
				if(indication.msb = '0' and indication.lsb = '1') then
					correspondence_S102 <= DOUBLE_YELLOW;
				end if;
				if(indication.msb = '1' and indication.lsb = '0') then
					correspondence_S102 <= YELLOW;
				end if;
			else
				if (commandAux.msb = '0' and commandAux.lsb = '0' and indication.msb = '0' and indication.lsb = '0') then
					correspondence_S102 <= RED;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '1' and indication.msb = '1' and indication.lsb = '1') then
					correspondence_S102 <= GREEN;
					restart <= '1';
				end if;
				if (commandAux.msb = '0' and commandAux.lsb = '1' and indication.msb = '0' and indication.lsb = '1') then
					correspondence_S102 <= DOUBLE_YELLOW;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '0' and indication.msb = '1' and indication.lsb = '0') then
					correspondence_S102 <= YELLOW;
					restart <= '1';
				end if;
				if ((commandAux.msb /= indication.msb) or (commandAux.lsb /= indication.lsb)) then
					correspondence_S102 <= RED;
					restart <= '0';
				end if;
			end if;
		end if;
	end process;

	process(aspectState)
	begin
		case aspectState is
			when RED =>
				commandAux.msb <= '0';
				commandAux.lsb <= '0';
			when DOUBLE_YELLOW =>
				commandAux.msb <= '0';
				commandAux.lsb <= '1';
			when YELLOW =>
				commandAux.msb <= '1';
				commandAux.lsb <= '0';
			when GREEN =>
				commandAux.msb <= '1';
				commandAux.lsb <= '1';
			when others =>
				commandAux.msb <= '0';
				commandAux.lsb <= '0';
		end case;
	end process;
	command <= commandAux;
end Behavioral;