--  railwaySignal_8.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R16_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne40 : in std_logic;
			correspondence_J25 : out signalStates;
			lock_J25 : out objectLock;
			correspondence_S36 : in signalStates;
			--Ocupation level 2
			ocupation_ne49 : in std_logic;
			ocupation_ne48 : in std_logic;
			ocupation_ne50 : in std_logic;
			ocupation_ne46 : in std_logic;
			correspondence_J09 : in signalStates;
			correspondence_J05 : in signalStates;
			correspondence_J07 : in signalStates;
			Sw27_state : in singleSwitchStates;
			Sw29_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end entity railwaySignal_8;
architecture Behavioral of railwaySignal_8 is
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
				if (R16_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R16_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R16_command = LOCK) then
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
				lock_J25 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_J25 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_J25 <= LOCKED;
			when others =>
				lock_J25 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE | LOCK =>
				if ((Sw27_state = NORMAL and Sw27_state = REVERSE and Sw29_state = NORMAL and Sw27_state = REVERSE and Sw29_state = REVERSE) or (Sw27_state = NORMAL and Sw27_state = REVERSE and Sw29_state = NORMAL and Sw27_state = REVERSE and Sw29_state = REVERSE) or (Sw27_state = NORMAL and Sw27_state = REVERSE and Sw29_state = NORMAL and Sw27_state = REVERSE and Sw29_state = REVERSE)) then
					if (Sw27_state = NORMAL and Sw27_state = REVERSE and Sw29_state = NORMAL and Sw27_state = REVERSE and Sw29_state = REVERSE) then
						path <= 1;
					end if;
					if (Sw27_state = NORMAL and Sw27_state = REVERSE and Sw29_state = NORMAL and Sw27_state = REVERSE and Sw29_state = REVERSE) then
						path <= 2;
					end if;
					if (Sw27_state = NORMAL and Sw27_state = REVERSE and Sw29_state = NORMAL and Sw27_state = REVERSE and Sw29_state = REVERSE) then
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
				if (correspondence_S36 = RED) then
					aspectState <= DOUBLE_YELLOW;
				end if;
				if (correspondence_S36 = DOUBLE_YELLOW) then
					aspectState <= YELLOW;
				end if;
				if (correspondence_S36 = YELLOW) then
					aspectState <= GREEN;
				end if;
				if (correspondence_S36 = GREEN) then
					aspectState <= GREEN;
				end if;
			when 2 =>
				if (correspondence_S36 = RED) then
					aspectState <= DOUBLE_YELLOW;
				end if;
				if (correspondence_S36 = DOUBLE_YELLOW) then
					aspectState <= YELLOW;
				end if;
				if (correspondence_S36 = YELLOW) then
					aspectState <= GREEN;
				end if;
				if (correspondence_S36 = GREEN) then
					aspectState <= GREEN;
				end if;
			when 3 =>
				if (correspondence_S36 = RED) then
					aspectState <= DOUBLE_YELLOW;
				end if;
				if (correspondence_S36 = DOUBLE_YELLOW) then
					aspectState <= YELLOW;
				end if;
				if (correspondence_S36 = YELLOW) then
					aspectState <= GREEN;
				end if;
				if (correspondence_S36 = GREEN) then
					aspectState <= GREEN;
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
					correspondence_J25 <= RED;
				end if;
				if(indication.msb = '1' and indication.lsb = '1') then
					correspondence_J25 <= GREEN;
				end if;
				if(indication.msb = '0' and indication.lsb = '1') then
					correspondence_J25 <= DOUBLE_YELLOW;
				end if;
				if(indication.msb = '1' and indication.lsb = '0') then
					correspondence_J25 <= YELLOW;
				end if;
			else
				if (commandAux.msb = '0' and commandAux.lsb = '0' and indication.msb = '0' and indication.lsb = '0') then
					correspondence_J25 <= RED;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '1' and indication.msb = '1' and indication.lsb = '1') then
					correspondence_J25 <= GREEN;
					restart <= '1';
				end if;
				if (commandAux.msb = '0' and commandAux.lsb = '1' and indication.msb = '0' and indication.lsb = '1') then
					correspondence_J25 <= DOUBLE_YELLOW;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '0' and indication.msb = '1' and indication.lsb = '0') then
					correspondence_J25 <= YELLOW;
					restart <= '1';
				end if;
				if ((commandAux.msb /= indication.msb) or (commandAux.lsb /= indication.lsb)) then
					correspondence_J25 <= RED;
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