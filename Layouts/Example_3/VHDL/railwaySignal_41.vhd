--  railwaySignal_41.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_41 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R52_command : in routeCommands;
			R68_command : in routeCommands;
			--Ocupation level 0
			track_ne83 : in hex_char;
			correspondence_C95 : out hex_char;
			--Ocupation level 1
			track_ne30 : in hex_char;
			correspondence_S122 : in hex_char;
			Sw08_state : in hex_char;
			--Ocupation level 2
			track_ne87 : in hex_char;
			track_ne86 : in hex_char;
			track_ne91 : in hex_char;
			track_ne89 : in hex_char;
			track_ne90 : in hex_char;
			correspondence_T19 : in hex_char;
			correspondence_T15 : in hex_char;
			correspondence_T21 : in hex_char;
			Sw12_state : in hex_char;
			Sw11_state : in hex_char;
			Sw13_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_41;
architecture Behavioral of railwaySignal_41 is
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
	signal ne30_state : nodeStates := FREE;
	signal ne30_lock : objectLock := RELEASED;
	signal S122_aspect : signalStates;
	signal S122_lock : objectLock := RELEASED;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw08_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne87_state : nodeStates := FREE;
	signal ne87_lock : objectLock := RELEASED;
	signal ne86_state : nodeStates := FREE;
	signal ne86_lock : objectLock := RELEASED;
	signal ne91_state : nodeStates := FREE;
	signal ne91_lock : objectLock := RELEASED;
	signal ne89_state : nodeStates := FREE;
	signal ne89_lock : objectLock := RELEASED;
	signal ne90_state : nodeStates := FREE;
	signal ne90_lock : objectLock := RELEASED;
	signal T19_aspect : signalStates;
	signal T19_lock : objectLock := RELEASED;
	signal T15_aspect : signalStates;
	signal T15_lock : objectLock := RELEASED;
	signal T21_aspect : signalStates;
	signal T21_lock : objectLock := RELEASED;
	signal Sw12_position : singleSwitchStates := NORMAL;
	signal Sw11_position : singleSwitchStates := NORMAL;
	signal Sw13_position : singleSwitchStates := NORMAL;
	signal Sw12_lock : objectLock := RELEASED;
	signal Sw11_lock : objectLock := RELEASED;
	signal Sw13_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_C95 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne30_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne30)(2 to 3))));
	ne30_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne30)(0 to 1))));
	S122_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S122)(2 to 3))));
	S122_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S122)(0 to 1))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	--Ocupation level 2
	ne87_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne87)(2 to 3))));
	ne87_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne87)(0 to 1))));
	ne86_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne86)(2 to 3))));
	ne86_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne86)(0 to 1))));
	ne91_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne91)(2 to 3))));
	ne91_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne91)(0 to 1))));
	ne89_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne89)(2 to 3))));
	ne89_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne89)(0 to 1))));
	ne90_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne90)(2 to 3))));
	ne90_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne90)(0 to 1))));
	T19_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T19)(2 to 3))));
	T19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T19)(0 to 1))));
	T15_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T15)(2 to 3))));
	T15_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T15)(0 to 1))));
	T21_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T21)(2 to 3))));
	T21_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T21)(0 to 1))));
	Sw12_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw12_state)(2 to 3))));
	Sw11_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw11_state)(2 to 3))));
	Sw13_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw13_state)(2 to 3))));
	Sw12_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw12_state)(0 to 1))));
	Sw11_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw11_state)(0 to 1))));
	Sw13_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw13_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R52_command,R68_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R52_command = RELEASE and R68_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R52_command = RESERVE or R68_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R52_command = LOCK or R68_command = LOCK) then
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

	process(commandState,Sw08_position,Sw12_position,Sw13_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw08_position = NORMAL and Sw12_position = NORMAL) or (Sw08_position = NORMAL and Sw11_position = REVERSE and Sw12_position = REVERSE and Sw13_position = NORMAL) or (Sw08_position = NORMAL and Sw12_position = REVERSE and Sw13_position = REVERSE)) then
					if (Sw08_position = NORMAL and Sw12_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw08_position = NORMAL and Sw11_position = REVERSE and Sw12_position = REVERSE and Sw13_position = NORMAL) then
						path <= 2;
					end if;
					if (Sw08_position = NORMAL and Sw12_position = REVERSE and Sw13_position = REVERSE) then
						path <= 3;
					end if;
				else
					path <= 0;
				end if;
			when RESERVE =>
				path <= 4;
			when LOCK =>
				path <= 0;
			when others =>
				path <= 0;
		end case;
	end process;

	process(path,ne30_state,S122_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne30_state = OCCUPIED or ne30_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S122_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S122_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S122_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S122_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne30_state = OCCUPIED or ne30_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S122_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S122_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S122_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S122_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne30_state = OCCUPIED or ne30_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S122_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S122_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S122_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S122_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 4 =>
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