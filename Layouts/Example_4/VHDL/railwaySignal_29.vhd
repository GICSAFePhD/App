--  railwaySignal_29.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity railwaySignal_29 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R51_command : in routeCommands;
			Lc01_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne404 : in std_logic;
			correspondence_C76 : out signalStates;
			lock_C76 : out objectLock;
			--Ocupation level 1
			ocupation_ne61 : in std_logic;
			ocupation_ne99 : in std_logic;
			ocupation_ne98 : in std_logic;
			correspondence_X51 : in signalStates;
			D05_state : in singleSwitchStates;
			D08_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne996 : in std_logic;
			correspondence_S129 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end entity railwaySignal_29;
architecture Behavioral of railwaySignal_29 is
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
				if (R51_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R51_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R51_command = LOCK) then
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
				lock_C76 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_C76 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_C76 <= LOCKED;
			when others =>
				lock_C76 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE | LOCK =>
				if ((D05_state = REVERSE and D08_state = NORMAL and Lc01_state = DOWN)) then
					if (D05_state = REVERSE and D08_state = NORMAL and Lc01_state = DOWN) then
						path <= 1;
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
				if (ocupation_ne61 = '0' or ocupation_ne99 = '0' or ocupation_ne98 = '0') then
					aspectState <= RED;
				else
					if (correspondence_X51 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_X51 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_X51 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_X51 = GREEN) then
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
					correspondence_C76 <= RED;
				end if;
				if(indication.msb = '1' and indication.lsb = '1') then
					correspondence_C76 <= GREEN;
				end if;
				if(indication.msb = '0' and indication.lsb = '1') then
					correspondence_C76 <= DOUBLE_YELLOW;
				end if;
				if(indication.msb = '1' and indication.lsb = '0') then
					correspondence_C76 <= YELLOW;
				end if;
			else
				if (commandAux.msb = '0' and commandAux.lsb = '0' and indication.msb = '0' and indication.lsb = '0') then
					correspondence_C76 <= RED;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '1' and indication.msb = '1' and indication.lsb = '1') then
					correspondence_C76 <= GREEN;
					restart <= '1';
				end if;
				if (commandAux.msb = '0' and commandAux.lsb = '1' and indication.msb = '0' and indication.lsb = '1') then
					correspondence_C76 <= DOUBLE_YELLOW;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '0' and indication.msb = '1' and indication.lsb = '0') then
					correspondence_C76 <= YELLOW;
					restart <= '1';
				end if;
				if ((commandAux.msb /= indication.msb) or (commandAux.lsb /= indication.lsb)) then
					correspondence_C76 <= RED;
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