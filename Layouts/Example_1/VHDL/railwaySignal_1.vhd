--  railwaySignal_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity railwaySignal_1 is
		port(
			clock : in std_logic;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			Lc06_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne1 : in std_logic;
			correspondence_S22 : out signalStates;
			lock_S22 : out objectLock;
			--Ocupation level 1
			ocupation_ne8 : in std_logic;
			ocupation_ne9 : in std_logic;
			ocupation_ne14 : in std_logic;
			ocupation_ne15 : in std_logic;
			correspondence_S32 : in signalStates;
			correspondence_X15 : in signalStates;
			correspondence_T05 : in signalStates;
			Sw04_state : in singleSwitchStates;
			Sw07_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne22 : in std_logic;
			ocupation_ne12 : in std_logic;
			ocupation_ne24 : in std_logic;
			correspondence_J11 : in signalStates;
			correspondence_C25 : in signalStates;
			correspondence_T03 : in signalStates;
			Sw12_state : in singleSwitchStates;
			Sw13_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end entity railwaySignal_1;
architecture Behavioral of railwaySignal_1 is
	component flipFlop is
		port(
			clock : in std_logic;
			reset : in std_logic;
			Q : out std_logic
		);
	end component flipFlop;
	signal restart : std_logic := '0';
	signal Q : std_logic_vector(27 downto 0) := (others => '0');
	signal commandState : routeCommands := RELEASE;
	signal aspectState : signalStates := RED;
	signal commandAux : signal_type := (others => '0');
	signal path : integer := 0;
begin
	gen : for i in 0 to 26 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;
	Q(0) <= clock;

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R11_command = RELEASE and R12_command = RELEASE and R13_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R11_command = RESERVE or R12_command = RESERVE or R13_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R11_command = LOCK or R12_command = LOCK or R13_command = LOCK) then
					commandState <= LOCK;
				end if;
			end if;
		end if;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				lock_S22 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_S22 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_S22 <= LOCKED;
			when others =>
				lock_S22 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE | LOCK =>
				if ((Sw04_state = NORMAL and Sw12_state = NORMAL) or (Sw04_state = NORMAL and Sw12_state = REVERSE and Sw13_state = REVERSE) or (Sw04_state = REVERSE and Sw07_state = REVERSE and Lc06_state = DOWN) or (Sw04_state = REVERSE and Sw07_state = NORMAL)) then
					if (Sw04_state = NORMAL and Sw12_state = NORMAL) then
						path <= 1;
					end if;
					if (Sw04_state = NORMAL and Sw12_state = REVERSE and Sw13_state = REVERSE) then
						path <= 2;
					end if;
					if (Sw04_state = REVERSE and Sw07_state = REVERSE and Lc06_state = DOWN) then
						path <= 3;
					end if;
					if (Sw04_state = REVERSE and Sw07_state = NORMAL) then
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

	process(clock,correspondence_S32 , correspondence_X15 , correspondence_T05)
	begin
		case path is
			when 0 =>
				aspectState <= RED;
			when 1 =>
				if (ocupation_ne8 = '0') then
					aspectState <= RED;
				else
					if (correspondence_S32 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_S32 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_S32 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_S32 = GREEN) then
						aspectState <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ocupation_ne8 = '0') then
					aspectState <= RED;
				else
					if (correspondence_S32 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_S32 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_S32 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_S32 = GREEN) then
						aspectState <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ocupation_ne9 = '0' or ocupation_ne14 = '0') then
					aspectState <= RED;
				else
					if (correspondence_X15 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_X15 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_X15 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_X15 = GREEN) then
						aspectState <= GREEN;
					end if;
				end if;
			when 4 =>
				if (ocupation_ne9 = '0' or ocupation_ne15 = '0') then
					aspectState <= RED;
				else
					if (correspondence_T05 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_T05 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_T05 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_T05 = GREEN) then
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
			if(Q(0) = '0' and Q(1) = '0' and Q(2) = '0' and Q(3) = '0' and Q(4) = '0' and Q(5) = '0' and Q(6) = '1' and Q(7) = '1' and Q(8) = '0' and Q(9) = '1' and Q(10) = '1' and Q(11) = '1' and Q(12) = '0' and Q(13) = '0' and Q(14) = '0' and Q(15) = '0' and Q(16) = '0' and Q(17) = '1' and Q(18) = '1' and Q(19) = '0' and Q(20) = '1' and Q(21) = '0' and Q(22) = '0' and Q(23) = '0' and Q(24) = '0' and Q(25) = '1' and Q(26) = '0') then
				restart <= '1';
				if(indication.msb = '0' and indication.lsb = '0') then
					correspondence_S22 <= RED;
				end if;
				if(indication.msb = '1' and indication.lsb = '1') then
					correspondence_S22 <= GREEN;
				end if;
				if(indication.msb = '0' and indication.lsb = '1') then
					correspondence_S22 <= DOUBLE_YELLOW;
				end if;
				if(indication.msb = '1' and indication.lsb = '0') then
					correspondence_S22 <= YELLOW;
				end if;
			else
				if (commandAux.msb = '0' and commandAux.lsb = '0' and indication.msb = '0' and indication.lsb = '0') then
					correspondence_S22 <= RED;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '1' and indication.msb = '1' and indication.lsb = '1') then
					correspondence_S22 <= GREEN;
					restart <= '1';
				end if;
				if (commandAux.msb = '0' and commandAux.lsb = '1' and indication.msb = '0' and indication.lsb = '1') then
					correspondence_S22 <= DOUBLE_YELLOW;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '0' and indication.msb = '1' and indication.lsb = '0') then
					correspondence_S22 <= YELLOW;
					restart <= '1';
				end if;
				if ((commandAux.msb /= indication.msb) or (commandAux.lsb /= indication.lsb)) then
					correspondence_S22 <= RED;
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