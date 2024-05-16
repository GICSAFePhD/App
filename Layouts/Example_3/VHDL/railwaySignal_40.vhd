--  railwaySignal_40.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity railwaySignal_40 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R64_command : in routeCommands;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne78 : in std_logic;
			correspondence_S110 : out signalStates;
			lock_S110 : out objectLock;
			--Ocupation level 1
			ocupation_ne17 : in std_logic;
			ocupation_ne79 : in std_logic;
			ocupation_ne77 : in std_logic;
			ocupation_ne21 : in std_logic;
			correspondence_C82 : in signalStates;
			correspondence_B133 : in signalStates;
			correspondence_P72 : in signalStates;
			Sw06_state : in singleSwitchStates;
			Sw07_state : in doubleSwitchStates;
			--Ocupation level 2
			ocupation_ne95 : in std_logic;
			ocupation_ne59 : in std_logic;
			ocupation_ne52 : in std_logic;
			correspondence_X51 : in signalStates;
			correspondence_S86 : in signalStates;
			correspondence_S144 : in signalStates;
			s69W03_state : in singleSwitchStates;
			Sw03_state : in scissorCrossingStates;
			indication : in signal_type;
			command : out signal_type
		);
	end entity railwaySignal_40;
architecture Behavioral of railwaySignal_40 is
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
				if (R64_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R64_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R64_command = LOCK or R65_command = LOCK or R66_command = LOCK) then
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
				lock_S110 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_S110 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_S110 <= LOCKED;
			when others =>
				lock_S110 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE | LOCK =>
				if ((Sw06_state = NORMAL and s69W03_state = NORMAL) or (Sw06_state = REVERSE and Sw07_state = DOUBLE_REVERSE and Sw03_state = REVERSE) or (Sw06_state = REVERSE and Sw07_state = REVERSE_NORMAL)) then
					if (Sw06_state = NORMAL and s69W03_state = NORMAL) then
						path <= 1;
					end if;
					if (Sw06_state = REVERSE and Sw07_state = DOUBLE_REVERSE and Sw03_state = REVERSE) then
						path <= 2;
					end if;
					if (Sw06_state = REVERSE and Sw07_state = REVERSE_NORMAL) then
						path <= 3;
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
				if (ocupation_ne17 = '0') then
					aspectState <= RED;
				else
					if (correspondence_C82 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_C82 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_C82 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_C82 = GREEN) then
						aspectState <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ocupation_ne79 = '0' or ocupation_ne77 = '0') then
					aspectState <= RED;
				else
					if (correspondence_B133 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_B133 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_B133 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_B133 = GREEN) then
						aspectState <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ocupation_ne79 = '0' or ocupation_ne21 = '0') then
					aspectState <= RED;
				else
					if (correspondence_P72 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_P72 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_P72 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_P72 = GREEN) then
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
					correspondence_S110 <= RED;
				end if;
				if(indication.msb = '1' and indication.lsb = '1') then
					correspondence_S110 <= GREEN;
				end if;
				if(indication.msb = '0' and indication.lsb = '1') then
					correspondence_S110 <= DOUBLE_YELLOW;
				end if;
				if(indication.msb = '1' and indication.lsb = '0') then
					correspondence_S110 <= YELLOW;
				end if;
			else
				if (commandAux.msb = '0' and commandAux.lsb = '0' and indication.msb = '0' and indication.lsb = '0') then
					correspondence_S110 <= RED;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '1' and indication.msb = '1' and indication.lsb = '1') then
					correspondence_S110 <= GREEN;
					restart <= '1';
				end if;
				if (commandAux.msb = '0' and commandAux.lsb = '1' and indication.msb = '0' and indication.lsb = '1') then
					correspondence_S110 <= DOUBLE_YELLOW;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '0' and indication.msb = '1' and indication.lsb = '0') then
					correspondence_S110 <= YELLOW;
					restart <= '1';
				end if;
				if ((commandAux.msb /= indication.msb) or (commandAux.lsb /= indication.lsb)) then
					correspondence_S110 <= RED;
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