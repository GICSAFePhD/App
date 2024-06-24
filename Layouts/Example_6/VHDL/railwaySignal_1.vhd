--  railwaySignal_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			--Ocupation level 0
			track_ne1 : in hex_char;
			correspondence_S22 : out hex_char;
			--Ocupation level 1
			track_ne3 : in hex_char;
			track_ne2 : in hex_char;
			track_ne7 : in hex_char;
			track_ne6 : in hex_char;
			correspondence_S27 : in hex_char;
			correspondence_J19 : in hex_char;
			correspondence_T03 : in hex_char;
			Sw01_state : in hex_char;
			Sw03_state : in hex_char;
			--Ocupation level 2
			track_ne4 : in hex_char;
			track_ne5 : in hex_char;
			track_ne41 : in hex_char;
			correspondence_S33 : in hex_char;
			correspondence_T01 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw02_state : in hex_char;
			Sw08_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end entity railwaySignal_1;
architecture Behavioral of railwaySignal_1 is
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
	signal ne3_state : nodeStates := FREE;
	signal ne3_lock : objectLock := RELEASED;
	signal ne2_state : nodeStates := FREE;
	signal ne2_lock : objectLock := RELEASED;
	signal ne7_state : nodeStates := FREE;
	signal ne7_lock : objectLock := RELEASED;
	signal ne6_state : nodeStates := FREE;
	signal ne6_lock : objectLock := RELEASED;
	signal S27_aspect : signalStates;
	signal S27_lock : objectLock := RELEASED;
	signal J19_aspect : signalStates;
	signal J19_lock : objectLock := RELEASED;
	signal T03_aspect : signalStates;
	signal T03_lock : objectLock := RELEASED;
	signal Sw01_position : singleSwitchStates := NORMAL;
	signal Sw03_position : singleSwitchStates := NORMAL;
	signal Sw01_lock : objectLock := RELEASED;
	signal Sw03_lock : objectLock := RELEASED;
	--Ocupation level 2
	signal ne4_state : nodeStates := FREE;
	signal ne4_lock : objectLock := RELEASED;
	signal ne5_state : nodeStates := FREE;
	signal ne5_lock : objectLock := RELEASED;
	signal ne41_state : nodeStates := FREE;
	signal ne41_lock : objectLock := RELEASED;
	signal S33_aspect : signalStates;
	signal S33_lock : objectLock := RELEASED;
	signal T01_aspect : signalStates;
	signal T01_lock : objectLock := RELEASED;
	signal T07_aspect : signalStates;
	signal T07_lock : objectLock := RELEASED;
	signal Sw02_position : singleSwitchStates := NORMAL;
	signal Sw08_position : singleSwitchStates := NORMAL;
	signal Sw02_lock : objectLock := RELEASED;
	signal Sw08_lock : objectLock := RELEASED;
begin
	clock_in(0) <= clock;
	lockStateIn <= objectLock'val(to_integer(unsigned(hex_to_slv(indication)(0 to 1))));
	aspectStateIn <= signalStates'val(to_integer(unsigned(hex_to_slv(indication)(2 to 3))));
	command <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(aspectStateOut), 2)));
	correspondence_S22 <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lockStateOut), 2) & to_unsigned(signalStates'pos(correspondenceState), 2)));
	--Ocupation level 1
	ne3_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne3)(2 to 3))));
	ne3_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne3)(0 to 1))));
	ne2_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne2)(2 to 3))));
	ne2_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne2)(0 to 1))));
	ne7_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne7)(2 to 3))));
	ne7_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne7)(0 to 1))));
	ne6_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne6)(2 to 3))));
	ne6_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne6)(0 to 1))));
	S27_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S27)(2 to 3))));
	S27_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S27)(0 to 1))));
	J19_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_J19)(2 to 3))));
	J19_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_J19)(0 to 1))));
	T03_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T03)(2 to 3))));
	T03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T03)(0 to 1))));
	Sw01_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw01_state)(2 to 3))));
	Sw03_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw03_state)(2 to 3))));
	Sw01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw01_state)(0 to 1))));
	Sw03_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw03_state)(0 to 1))));
	--Ocupation level 2
	ne4_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne4)(2 to 3))));
	ne4_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne4)(0 to 1))));
	ne5_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne5)(2 to 3))));
	ne5_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne5)(0 to 1))));
	ne41_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_ne41)(2 to 3))));
	ne41_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(track_ne41)(0 to 1))));
	S33_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_S33)(2 to 3))));
	S33_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_S33)(0 to 1))));
	T01_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(2 to 3))));
	T01_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T01)(0 to 1))));
	T07_aspect <= signalStates'val(to_integer(unsigned(hex_to_slv(correspondence_T07)(2 to 3))));
	T07_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(correspondence_T07)(0 to 1))));
	Sw02_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw02_state)(2 to 3))));
	Sw08_position <= singleSwitchStates'val(to_integer(unsigned(hex_to_slv(Sw08_state)(2 to 3))));
	Sw02_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw02_state)(0 to 1))));
	Sw08_lock <= objectLock'val(to_integer(unsigned(hex_to_slv(Sw08_state)(0 to 1))));
	gen : for i in 0 to 29 generate
		inst: flipFlop port map(Q(i),restart,Q(i+1));
	end generate;

	process(timeout,R11_command,R12_command,R13_command)
	begin
		if (timeout = '1') then
			commandState <= RELEASE;
		else
			if (R11_command = RELEASE and R12_command = RELEASE and R13_command = RELEASE) then
				commandState <= RELEASE;
			end if;
			if (R11_command = RESERVE or R12_command = RESERVE or R13_command = RESERVE) then
				commandState <= RESERVE;
			end if;
			if (R11_command = LOCK or R12_command = LOCK or R13_command = LOCK) then
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
				if ((Sw01_position = NORMAL and Sw02_position = NORMAL) or (Sw01_position = NORMAL and Sw02_position = REVERSE) or (Sw01_position = REVERSE and Sw03_position = NORMAL and Sw08_position = NORMAL) or (Sw01_position = REVERSE and Sw03_position = REVERSE)) then
					if (Sw01_position = NORMAL and Sw02_position = NORMAL) then
						path <= 1;
					end if;
					if (Sw01_position = NORMAL and Sw02_position = REVERSE) then
						path <= 2;
					end if;
					if (Sw01_position = REVERSE and Sw03_position = NORMAL and Sw08_position = NORMAL) then
						path <= 3;
					end if;
					if (Sw01_position = REVERSE and Sw03_position = REVERSE) then
						path <= 4;
					end if;
				else
					path <= 0;
				end if;
			when RESERVE =>
				path <= 5;
			when LOCK =>
				path <= 0;
			when others =>
				path <= 0;
		end case;
	end process;

	process(path,ne3_state,ne2_state,ne7_state,ne6_state,S27_aspect,J19_aspect,T03_aspect)
	begin
		case path is
			when 0 =>
				aspectStateOut <= RED;
			when 1 =>
				if (ne3_state = OCCUPIED or ne3_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S27_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S27_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S27_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S27_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 2 =>
				if (ne3_state = OCCUPIED or ne3_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (S27_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (S27_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (S27_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (S27_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 3 =>
				if (ne2_state = OCCUPIED or ne2_lock = LOCKED or ne7_state = OCCUPIED or ne7_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (J19_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (J19_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (J19_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (J19_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 4 =>
				if (ne2_state = OCCUPIED or ne2_lock = LOCKED or ne6_state = OCCUPIED or ne6_lock = LOCKED) then
					aspectStateOut <= RED;
				else
					if (T03_aspect = RED) then
						aspectStateOut <= DOUBLE_YELLOW;
					end if;
					if (T03_aspect = DOUBLE_YELLOW) then
						aspectStateOut <= YELLOW;
					end if;
					if (T03_aspect = YELLOW) then
						aspectStateOut <= GREEN;
					end if;
					if (T03_aspect = GREEN) then
						aspectStateOut <= GREEN;
					end if;
				end if;
			when 5 =>
				aspectStateOut <= GREEN;
			when others =>
				aspectStateOut <= RED;
		end case;
	end process;

	process(clock,reset,Q,restart)
	begin
		if (reset = '1' or Q = "011010000100111011100001011111") then
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