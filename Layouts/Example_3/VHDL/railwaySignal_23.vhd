--  railwaySignal_23.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_23 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R74_command : in routeCommands;
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			R52_command : in routeCommands;
			R53_command : in routeCommands;
			--Ocupation level 0
			track_ne30 : in hex_char;
			correspondence_S122 : out hex_char;
			--Ocupation level 1
			track_ne89 : in hex_char;
			track_ne91 : in hex_char;
			track_ne87 : in hex_char;
			track_ne86 : in hex_char;
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
	end entity railwaySignal_23;
architecture Behavioral of railwaySignal_23 is
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
	signal ne89_state : nodeStates := FREE;
	signal ne89_lock : objectLock := RELEASED;
	signal ne91_state : nodeStates := FREE;
	signal ne91_lock : objectLock := RELEASED;
	signal ne87_state : nodeStates := FREE;
	signal ne87_lock : objectLock := RELEASED;
	signal ne86_state : nodeStates := FREE;
	signal ne86_lock : objectLock := RELEASED;
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
	correspondence_S122 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne89_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne89)(2 to 3))));
	ne89_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne89)(0 to 1))));
	ne91_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne91)(2 to 3))));
	ne91_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne91)(0 to 1))));
	ne87_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne87)(2 to 3))));
	ne87_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne87)(0 to 1))));
	ne86_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne86)(2 to 3))));
	ne86_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne86)(0 to 1))));
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

	process(timeout,R74_command,R75_command,R76_command,R52_command,R53_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R74_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE and R52_command = RELEASE and R53_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R74_command = RESERVE or R75_command = RESERVE or R76_command = RESERVE or R52_command = RESERVE or R53_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R74_command = LOCK or R75_command = LOCK or R76_command = LOCK or R52_command = LOCK or R53_command = LOCK) then
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

	process(commandState,Sw12_position,Sw13_position)
	begin
		case commandState is
			when RELEASE =>
				if ((Sw12_position = NORMAL) or (Sw11_position = REVERSE and Sw12_position = REVERSE and Sw13_position = NORMAL) or (Sw12_position = REVERSE and Sw13_position = REVERSE)) then
					if (Sw12_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw11_position = REVERSE and Sw12_position = REVERSE and Sw13_position = NORMAL) then
						path <= 2;
					end if;
					if (Sw12_position = REVERSE and Sw13_position = REVERSE) then
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

	process(path,ne89_state,ne91_state,ne87_state,ne86_state,ne90_state,T19_aspect,T15_aspect,T21_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne89_state = OCCUPIED or ne89_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T19_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T19_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T19_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T19_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne91_state = OCCUPIED or ne91_lock = LOCKED or ne87_state = OCCUPIED or ne87_lock = LOCKED or ne86_state = OCCUPIED or ne86_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T15_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T15_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T15_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T15_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne91_state = OCCUPIED or ne91_lock = LOCKED or ne90_state = OCCUPIED or ne90_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T21_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T21_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T21_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T21_aspect = GREEN) then
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