--  railwaySignal_16.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_16 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R28_command : in routeCommands;
			R51_command : in routeCommands;
			--Ocupation level 0
			track_ne24 : in hex_char;
			correspondence_P63 : out hex_char;
			--Ocupation level 1
			track_ne64 : in hex_char;
			track_ne103 : in hex_char;
			track_ne67 : in hex_char;
			correspondence_P64 : in hex_char;
			--Ocupation level 2
			track_ne70 : in hex_char;
			correspondence_L32 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_16;
architecture Behavioral of railwaySignal_16 is
	component flipFlop is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			Q : out std_logic := '0'
		);
	end component flipFlop;
	signal restart : std_logic := '1';
	signal Q : std_logic_vector(30 downto 0) := (others => '0');
	signal clock_in : std_logic_vector(30 downto 0) := (others => '0');
	signal timeout : std_logic := '0';
	signal commandState : routeCommands := RELEASE;
	signal lockStateIn : objectLock := RELEASED;
	signal lockStateOut : objectLock := RELEASED;
	signal aspectStateIn : signalStates := RED;
	signal aspectStateOut : signalStates := RED;
	signal correspondenceState : signalStates := RED;
	signal path : integer := 0;
	--Ocupation level 1
	signal ne64_state : nodeStates := FREE;
	signal ne64_lock : objectLock := RELEASED;
	signal ne103_state : nodeStates := FREE;
	signal ne103_lock : objectLock := RELEASED;
	signal ne67_state : nodeStates := FREE;
	signal ne67_lock : objectLock := RELEASED;
	signal P64_aspect : signalStates;
	signal P64_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne70_state : nodeStates := FREE;
	signal ne70_lock : objectLock := RELEASED;
	signal L32_aspect : signalStates;
	signal L32_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_P63 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne64_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne64)(2 to 3))));
	ne64_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne64)(0 to 1))));
	ne103_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne103)(2 to 3))));
	ne103_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne103)(0 to 1))));
	ne67_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne67)(2 to 3))));
	ne67_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne67)(0 to 1))));
	P64_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_P64)(2 to 3))));
	P64_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_P64)(0 to 1))));
	--Ocupation level 2
	ne70_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne70)(2 to 3))));
	ne70_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne70)(0 to 1))));
	L32_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_L32)(2 to 3))));
	L32_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_L32)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R28_command,R51_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R28_command = RELEASE and R51_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R28_command = RESERVE or R51_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R28_command = LOCK or R51_command = LOCK) then
				commandState <= LOCK;
			end if;
		end if;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				lockStateOut <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lockStateOut <= RESERVED;
			when LOCK => -- DONT CHANGE
				lockStateOut <= LOCKED;
			when others =>
				lockStateOut <= LOCKED;
		end case;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE =>
				path <= 1;
			when RESERVE =>
				path <= 2;
			when LOCK =>
				path <= 0;
			when others =>
				path <= 0;
		end case;
	end process;

	process(path,ne64_state,ne103_state,ne67_state,P64_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne64_state = OCCUPIED or ne64_lock = LOCKED or ne103_state = OCCUPIED or ne103_lock = LOCKED or ne67_state = OCCUPIED or ne67_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (P64_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (P64_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (P64_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (P64_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				aspectStateOut <= GREEN;
			when others =>
				aspectStateOut <= RED;
		end case;
	end process;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "010100110111001001001110000000") then
			timeout <= '1';
		end if;
		if (restart = '1') then
			timeout <= '0';
		end if;
	end process;

	process(timeout,aspectStateOut,aspectStateIn)
	begin
		if(aspectStateOut = RED and aspectStateIn = RED) then
			correspondenceState <= RED;
			restart <= '1';
		end if;
		if(aspectStateOut = GREEN and aspectStateIn = GREEN) then
			correspondenceState <= GREEN;
			restart <= '1';
		end if;
		if(aspectStateOut = DOUBLE_YELLOW and aspectStateIn = DOUBLE_YELLOW) then
			correspondenceState <= DOUBLE_YELLOW;
			restart <= '1';
		end if;
		if(aspectStateOut = YELLOW and aspectStateIn = YELLOW) then
			correspondenceState <= YELLOW;
			restart <= '1';
		end if;
	end process;
end Behavioral;