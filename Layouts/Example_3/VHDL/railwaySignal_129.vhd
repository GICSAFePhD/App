--  railwaySignal_129.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity railwaySignal_129 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R65_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne77 : in std_logic;
			correspondence_P74 : out signalStates;
			lock_P74 : out objectLock;
			--Ocupation level 1
			ocupation_ne52 : in std_logic;
			correspondence_S86 : in signalStates;
			Sw03_state : in scissorCrossingStates;
			--Ocupation level 2
			ocupation_ne14 : in std_logic;
			ocupation_ne95 : in std_logic;
			ocupation_ne11 : in std_logic;
			ocupation_ne59 : in std_logic;
			correspondence_J49 : in signalStates;
			correspondence_T07 : in signalStates;
			s69W03_state : in singleSwitchStates;
			s69W04_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end entity railwaySignal_129;
architecture Behavioral of railwaySignal_129 is
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
				if (R65_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R65_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R65_command = LOCK) then
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
				lock_P74 <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_P74 <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_P74 <= LOCKED;
			when others =>
				lock_P74 <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE | LOCK =>
				if ((Sw03_state = REVERSE and s69W03_state = REVERSE and s69W04_state = REVERSE) or (Sw03_state = REVERSE and s69W04_state = NORMAL)) then
					if (Sw03_state = REVERSE and s69W03_state = REVERSE and s69W04_state = REVERSE) then
						path <= 1;
					end if;
					if (Sw03_state = REVERSE and s69W04_state = NORMAL) then
						path <= 2;
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
				if (ocupation_ne52 = '0') then
					aspectState <= RED;
				else
					if (correspondence_S86 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_S86 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_S86 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_S86 = GREEN) then
						aspectState <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ocupation_ne52 = '0') then
					aspectState <= RED;
				else
					if (correspondence_S86 = RED) then
						aspectState <= DOUBLE_YELLOW;
					end if;
					if (correspondence_S86 = DOUBLE_YELLOW) then
						aspectState <= YELLOW;
					end if;
					if (correspondence_S86 = YELLOW) then
						aspectState <= GREEN;
					end if;
					if (correspondence_S86 = GREEN) then
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
					correspondence_P74 <= RED;
				end if;
				if(indication.msb = '1' and indication.lsb = '1') then
					correspondence_P74 <= GREEN;
				end if;
				if(indication.msb = '0' and indication.lsb = '1') then
					correspondence_P74 <= DOUBLE_YELLOW;
				end if;
				if(indication.msb = '1' and indication.lsb = '0') then
					correspondence_P74 <= YELLOW;
				end if;
			else
				if (commandAux.msb = '0' and commandAux.lsb = '0' and indication.msb = '0' and indication.lsb = '0') then
					correspondence_P74 <= RED;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '1' and indication.msb = '1' and indication.lsb = '1') then
					correspondence_P74 <= GREEN;
					restart <= '1';
				end if;
				if (commandAux.msb = '0' and commandAux.lsb = '1' and indication.msb = '0' and indication.lsb = '1') then
					correspondence_P74 <= DOUBLE_YELLOW;
					restart <= '1';
				end if;
				if (commandAux.msb = '1' and commandAux.lsb = '0' and indication.msb = '1' and indication.lsb = '0') then
					correspondence_P74 <= YELLOW;
					restart <= '1';
				end if;
				if ((commandAux.msb /= indication.msb) or (commandAux.lsb /= indication.lsb)) then
					correspondence_P74 <= RED;
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