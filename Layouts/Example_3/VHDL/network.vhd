--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 248;
			N_SIGNALS : natural := 82;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 14;
			N_DOUBLEWITCHES : natural := 8;
			N_TRACKCIRCUITS : natural := 53
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			ocupation : in std_logic_vector(N_TRACKCIRCUITS-1 downto 0);
			signals_i : in signals_type;
			signals_o : out signals_type;
			levelCrossings_i : in std_logic;
			levelCrossings_o : out std_logic;
			singleSwitches_i : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_o : out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			doubleSwitches_i : in dSwitches_type;
			doubleSwitches_o : out dSwitches_type;
			reset : in std_logic
		);
	end entity network;
architecture Behavioral of network is
	component levelCrossing is
		port(
			clock : in std_logic;
			indication : in std_logic;
			command_in : in std_logic;
			command_out : out std_logic;
			correspondence : out std_logic
		);
	end component levelCrossing;
	component singleSwitch is
		port(
			clock : in std_logic;
			indication : in std_logic;
			command_in : in std_logic;
			command_out : out std_logic;
			correspondence : out std_logic
		);
	end component singleSwitch;
	component doubleSwitch is
		port(
			clock : in std_logic;
			indication : in dSwitch_type;
			command_in : in dSwitch_type;
			command_out : out dSwitch_type;
			correspondence : out dSwitch_type
		);
	end component doubleSwitch;
	component railwaySignal is
		port(
			clock : in std_logic;
			indication : in signal_type;
			command_in : in signal_type;
			command_out : out signal_type;
			correspondence : out signal_type
		);
	end component railwaySignal;
	component node is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			out_test : out std_logic
		);
	end component node;
begin
	levelCrossing_0 : levelCrossing port map(clock => clock, indication => levelCrossings_i, command_in => '0' , command_out  => levelCrossings_o, correspondence => OPEN);
	singleSwitch_0 : singleSwitch port map(clock => clock, indication => singleSwitches_i(0), command_in => '0' , command_out => singleSwitches_o(0), correspondence => OPEN);
	singleSwitch_1 : singleSwitch port map(clock => clock, indication => singleSwitches_i(1), command_in => '0' , command_out => singleSwitches_o(1), correspondence => OPEN);
	singleSwitch_2 : singleSwitch port map(clock => clock, indication => singleSwitches_i(2), command_in => '0' , command_out => singleSwitches_o(2), correspondence => OPEN);
	singleSwitch_3 : singleSwitch port map(clock => clock, indication => singleSwitches_i(3), command_in => '0' , command_out => singleSwitches_o(3), correspondence => OPEN);
	singleSwitch_4 : singleSwitch port map(clock => clock, indication => singleSwitches_i(4), command_in => '0' , command_out => singleSwitches_o(4), correspondence => OPEN);
	singleSwitch_5 : singleSwitch port map(clock => clock, indication => singleSwitches_i(5), command_in => '0' , command_out => singleSwitches_o(5), correspondence => OPEN);
	singleSwitch_6 : singleSwitch port map(clock => clock, indication => singleSwitches_i(6), command_in => '0' , command_out => singleSwitches_o(6), correspondence => OPEN);
	singleSwitch_7 : singleSwitch port map(clock => clock, indication => singleSwitches_i(7), command_in => '0' , command_out => singleSwitches_o(7), correspondence => OPEN);
	singleSwitch_8 : singleSwitch port map(clock => clock, indication => singleSwitches_i(8), command_in => '0' , command_out => singleSwitches_o(8), correspondence => OPEN);
	singleSwitch_9 : singleSwitch port map(clock => clock, indication => singleSwitches_i(9), command_in => '0' , command_out => singleSwitches_o(9), correspondence => OPEN);
	singleSwitch_10 : singleSwitch port map(clock => clock, indication => singleSwitches_i(10), command_in => '0' , command_out => singleSwitches_o(10), correspondence => OPEN);
	singleSwitch_11 : singleSwitch port map(clock => clock, indication => singleSwitches_i(11), command_in => '0' , command_out => singleSwitches_o(11), correspondence => OPEN);
	singleSwitch_12 : singleSwitch port map(clock => clock, indication => singleSwitches_i(12), command_in => '0' , command_out => singleSwitches_o(12), correspondence => OPEN);
	singleSwitch_13 : singleSwitch port map(clock => clock, indication => singleSwitches_i(13), command_in => '0' , command_out => singleSwitches_o(13), correspondence => OPEN);
	doubleSwitch_0 : doubleSwitch port map(clock => clock, indication.msb => doubleSwitches_i.msb(0), indication.lsb => doubleSwitches_i.lsb(0), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => doubleSwitches_o.msb(0) , command_out.lsb => doubleSwitches_o.lsb(0)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	doubleSwitch_1 : doubleSwitch port map(clock => clock, indication.msb => doubleSwitches_i.msb(1), indication.lsb => doubleSwitches_i.lsb(1), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => doubleSwitches_o.msb(1) , command_out.lsb => doubleSwitches_o.lsb(1)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	doubleSwitch_2 : doubleSwitch port map(clock => clock, indication.msb => doubleSwitches_i.msb(2), indication.lsb => doubleSwitches_i.lsb(2), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => doubleSwitches_o.msb(2) , command_out.lsb => doubleSwitches_o.lsb(2)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	doubleSwitch_3 : doubleSwitch port map(clock => clock, indication.msb => doubleSwitches_i.msb(3), indication.lsb => doubleSwitches_i.lsb(3), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => doubleSwitches_o.msb(3) , command_out.lsb => doubleSwitches_o.lsb(3)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	doubleSwitch_4 : doubleSwitch port map(clock => clock, indication.msb => doubleSwitches_i.msb(4), indication.lsb => doubleSwitches_i.lsb(4), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => doubleSwitches_o.msb(4) , command_out.lsb => doubleSwitches_o.lsb(4)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	doubleSwitch_5 : doubleSwitch port map(clock => clock, indication.msb => doubleSwitches_i.msb(5), indication.lsb => doubleSwitches_i.lsb(5), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => doubleSwitches_o.msb(5) , command_out.lsb => doubleSwitches_o.lsb(5)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	doubleSwitch_6 : doubleSwitch port map(clock => clock, indication.msb => doubleSwitches_i.msb(6), indication.lsb => doubleSwitches_i.lsb(6), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => doubleSwitches_o.msb(6) , command_out.lsb => doubleSwitches_o.lsb(6)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	doubleSwitch_7 : doubleSwitch port map(clock => clock, indication.msb => doubleSwitches_i.msb(7), indication.lsb => doubleSwitches_i.lsb(7), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => doubleSwitches_o.msb(7) , command_out.lsb => doubleSwitches_o.lsb(7)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_0 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(0), indication.lsb => signals_i.lsb(0), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(0) , command_out.lsb => signals_o.lsb(0)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_1 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(1), indication.lsb => signals_i.lsb(1), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(1) , command_out.lsb => signals_o.lsb(1)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_2 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(2), indication.lsb => signals_i.lsb(2), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(2) , command_out.lsb => signals_o.lsb(2)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_3 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(3), indication.lsb => signals_i.lsb(3), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(3) , command_out.lsb => signals_o.lsb(3)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_4 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(4), indication.lsb => signals_i.lsb(4), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(4) , command_out.lsb => signals_o.lsb(4)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_5 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(5), indication.lsb => signals_i.lsb(5), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(5) , command_out.lsb => signals_o.lsb(5)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_6 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(6), indication.lsb => signals_i.lsb(6), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(6) , command_out.lsb => signals_o.lsb(6)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_7 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(7), indication.lsb => signals_i.lsb(7), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(7) , command_out.lsb => signals_o.lsb(7)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_8 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(8), indication.lsb => signals_i.lsb(8), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(8) , command_out.lsb => signals_o.lsb(8)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_9 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(9), indication.lsb => signals_i.lsb(9), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(9) , command_out.lsb => signals_o.lsb(9)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_10 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(10), indication.lsb => signals_i.lsb(10), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(10) , command_out.lsb => signals_o.lsb(10)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_11 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(11), indication.lsb => signals_i.lsb(11), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(11) , command_out.lsb => signals_o.lsb(11)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_12 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(12), indication.lsb => signals_i.lsb(12), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(12) , command_out.lsb => signals_o.lsb(12)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_13 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(13), indication.lsb => signals_i.lsb(13), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(13) , command_out.lsb => signals_o.lsb(13)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_14 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(14), indication.lsb => signals_i.lsb(14), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(14) , command_out.lsb => signals_o.lsb(14)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_15 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(15), indication.lsb => signals_i.lsb(15), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(15) , command_out.lsb => signals_o.lsb(15)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_16 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(16), indication.lsb => signals_i.lsb(16), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(16) , command_out.lsb => signals_o.lsb(16)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_17 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(17), indication.lsb => signals_i.lsb(17), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(17) , command_out.lsb => signals_o.lsb(17)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_18 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(18), indication.lsb => signals_i.lsb(18), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(18) , command_out.lsb => signals_o.lsb(18)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_19 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(19), indication.lsb => signals_i.lsb(19), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(19) , command_out.lsb => signals_o.lsb(19)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_20 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(20), indication.lsb => signals_i.lsb(20), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(20) , command_out.lsb => signals_o.lsb(20)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_21 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(21), indication.lsb => signals_i.lsb(21), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(21) , command_out.lsb => signals_o.lsb(21)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_22 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(22), indication.lsb => signals_i.lsb(22), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(22) , command_out.lsb => signals_o.lsb(22)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_23 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(23), indication.lsb => signals_i.lsb(23), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(23) , command_out.lsb => signals_o.lsb(23)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_24 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(24), indication.lsb => signals_i.lsb(24), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(24) , command_out.lsb => signals_o.lsb(24)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_25 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(25), indication.lsb => signals_i.lsb(25), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(25) , command_out.lsb => signals_o.lsb(25)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_26 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(26), indication.lsb => signals_i.lsb(26), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(26) , command_out.lsb => signals_o.lsb(26)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_27 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(27), indication.lsb => signals_i.lsb(27), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(27) , command_out.lsb => signals_o.lsb(27)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_28 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(28), indication.lsb => signals_i.lsb(28), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(28) , command_out.lsb => signals_o.lsb(28)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_29 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(29), indication.lsb => signals_i.lsb(29), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(29) , command_out.lsb => signals_o.lsb(29)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_30 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(30), indication.lsb => signals_i.lsb(30), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(30) , command_out.lsb => signals_o.lsb(30)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_31 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(31), indication.lsb => signals_i.lsb(31), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(31) , command_out.lsb => signals_o.lsb(31)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_32 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(32), indication.lsb => signals_i.lsb(32), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(32) , command_out.lsb => signals_o.lsb(32)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_33 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(33), indication.lsb => signals_i.lsb(33), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(33) , command_out.lsb => signals_o.lsb(33)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_34 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(34), indication.lsb => signals_i.lsb(34), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(34) , command_out.lsb => signals_o.lsb(34)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_35 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(35), indication.lsb => signals_i.lsb(35), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(35) , command_out.lsb => signals_o.lsb(35)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_36 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(36), indication.lsb => signals_i.lsb(36), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(36) , command_out.lsb => signals_o.lsb(36)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_37 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(37), indication.lsb => signals_i.lsb(37), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(37) , command_out.lsb => signals_o.lsb(37)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_38 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(38), indication.lsb => signals_i.lsb(38), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(38) , command_out.lsb => signals_o.lsb(38)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_39 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(39), indication.lsb => signals_i.lsb(39), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(39) , command_out.lsb => signals_o.lsb(39)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_40 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(40), indication.lsb => signals_i.lsb(40), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(40) , command_out.lsb => signals_o.lsb(40)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_41 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(41), indication.lsb => signals_i.lsb(41), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(41) , command_out.lsb => signals_o.lsb(41)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_42 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(42), indication.lsb => signals_i.lsb(42), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(42) , command_out.lsb => signals_o.lsb(42)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_43 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(43), indication.lsb => signals_i.lsb(43), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(43) , command_out.lsb => signals_o.lsb(43)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_44 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(44), indication.lsb => signals_i.lsb(44), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(44) , command_out.lsb => signals_o.lsb(44)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_45 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(45), indication.lsb => signals_i.lsb(45), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(45) , command_out.lsb => signals_o.lsb(45)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_46 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(46), indication.lsb => signals_i.lsb(46), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(46) , command_out.lsb => signals_o.lsb(46)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_47 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(47), indication.lsb => signals_i.lsb(47), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(47) , command_out.lsb => signals_o.lsb(47)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_48 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(48), indication.lsb => signals_i.lsb(48), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(48) , command_out.lsb => signals_o.lsb(48)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_49 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(49), indication.lsb => signals_i.lsb(49), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(49) , command_out.lsb => signals_o.lsb(49)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_50 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(50), indication.lsb => signals_i.lsb(50), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(50) , command_out.lsb => signals_o.lsb(50)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_51 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(51), indication.lsb => signals_i.lsb(51), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(51) , command_out.lsb => signals_o.lsb(51)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_52 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(52), indication.lsb => signals_i.lsb(52), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(52) , command_out.lsb => signals_o.lsb(52)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_53 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(53), indication.lsb => signals_i.lsb(53), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(53) , command_out.lsb => signals_o.lsb(53)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_54 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(54), indication.lsb => signals_i.lsb(54), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(54) , command_out.lsb => signals_o.lsb(54)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_55 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(55), indication.lsb => signals_i.lsb(55), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(55) , command_out.lsb => signals_o.lsb(55)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_56 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(56), indication.lsb => signals_i.lsb(56), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(56) , command_out.lsb => signals_o.lsb(56)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_57 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(57), indication.lsb => signals_i.lsb(57), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(57) , command_out.lsb => signals_o.lsb(57)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_58 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(58), indication.lsb => signals_i.lsb(58), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(58) , command_out.lsb => signals_o.lsb(58)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_59 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(59), indication.lsb => signals_i.lsb(59), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(59) , command_out.lsb => signals_o.lsb(59)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_60 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(60), indication.lsb => signals_i.lsb(60), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(60) , command_out.lsb => signals_o.lsb(60)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_61 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(61), indication.lsb => signals_i.lsb(61), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(61) , command_out.lsb => signals_o.lsb(61)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_62 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(62), indication.lsb => signals_i.lsb(62), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(62) , command_out.lsb => signals_o.lsb(62)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_63 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(63), indication.lsb => signals_i.lsb(63), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(63) , command_out.lsb => signals_o.lsb(63)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_64 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(64), indication.lsb => signals_i.lsb(64), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(64) , command_out.lsb => signals_o.lsb(64)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_65 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(65), indication.lsb => signals_i.lsb(65), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(65) , command_out.lsb => signals_o.lsb(65)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_66 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(66), indication.lsb => signals_i.lsb(66), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(66) , command_out.lsb => signals_o.lsb(66)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_67 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(67), indication.lsb => signals_i.lsb(67), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(67) , command_out.lsb => signals_o.lsb(67)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_68 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(68), indication.lsb => signals_i.lsb(68), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(68) , command_out.lsb => signals_o.lsb(68)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_69 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(69), indication.lsb => signals_i.lsb(69), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(69) , command_out.lsb => signals_o.lsb(69)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_70 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(70), indication.lsb => signals_i.lsb(70), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(70) , command_out.lsb => signals_o.lsb(70)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_71 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(71), indication.lsb => signals_i.lsb(71), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(71) , command_out.lsb => signals_o.lsb(71)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_72 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(72), indication.lsb => signals_i.lsb(72), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(72) , command_out.lsb => signals_o.lsb(72)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_73 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(73), indication.lsb => signals_i.lsb(73), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(73) , command_out.lsb => signals_o.lsb(73)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_74 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(74), indication.lsb => signals_i.lsb(74), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(74) , command_out.lsb => signals_o.lsb(74)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_75 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(75), indication.lsb => signals_i.lsb(75), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(75) , command_out.lsb => signals_o.lsb(75)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_76 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(76), indication.lsb => signals_i.lsb(76), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(76) , command_out.lsb => signals_o.lsb(76)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_77 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(77), indication.lsb => signals_i.lsb(77), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(77) , command_out.lsb => signals_o.lsb(77)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_78 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(78), indication.lsb => signals_i.lsb(78), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(78) , command_out.lsb => signals_o.lsb(78)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_79 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(79), indication.lsb => signals_i.lsb(79), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(79) , command_out.lsb => signals_o.lsb(79)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_80 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(80), indication.lsb => signals_i.lsb(80), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(80) , command_out.lsb => signals_o.lsb(80)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	railwaySignal_81 : railwaySignal port map(clock => clock, indication.msb => signals_i.msb(81), indication.lsb => signals_i.lsb(81), command_in.msb => '0',command_in.lsb => '0' , command_out.msb => signals_o.msb(81) , command_out.lsb => signals_o.lsb(81)  , correspondence.msb => OPEN , correspondence.lsb => OPEN);
	node_0 : node port map(clock => clock, ocupation => ocupation(0), out_test => OPEN);
	node_1 : node port map(clock => clock, ocupation => ocupation(1), out_test => OPEN);
	node_2 : node port map(clock => clock, ocupation => ocupation(2), out_test => OPEN);
	node_3 : node port map(clock => clock, ocupation => ocupation(3), out_test => OPEN);
	node_4 : node port map(clock => clock, ocupation => ocupation(4), out_test => OPEN);
	node_5 : node port map(clock => clock, ocupation => ocupation(5), out_test => OPEN);
	node_6 : node port map(clock => clock, ocupation => ocupation(6), out_test => OPEN);
	node_7 : node port map(clock => clock, ocupation => ocupation(7), out_test => OPEN);
	node_8 : node port map(clock => clock, ocupation => ocupation(8), out_test => OPEN);
	node_9 : node port map(clock => clock, ocupation => ocupation(9), out_test => OPEN);
	node_10 : node port map(clock => clock, ocupation => ocupation(10), out_test => OPEN);
	node_11 : node port map(clock => clock, ocupation => ocupation(11), out_test => OPEN);
	node_12 : node port map(clock => clock, ocupation => ocupation(12), out_test => OPEN);
	node_13 : node port map(clock => clock, ocupation => ocupation(13), out_test => OPEN);
	node_14 : node port map(clock => clock, ocupation => ocupation(14), out_test => OPEN);
	node_15 : node port map(clock => clock, ocupation => ocupation(15), out_test => OPEN);
	node_16 : node port map(clock => clock, ocupation => ocupation(16), out_test => OPEN);
	node_17 : node port map(clock => clock, ocupation => ocupation(17), out_test => OPEN);
	node_18 : node port map(clock => clock, ocupation => ocupation(18), out_test => OPEN);
	node_19 : node port map(clock => clock, ocupation => ocupation(19), out_test => OPEN);
	node_20 : node port map(clock => clock, ocupation => ocupation(20), out_test => OPEN);
	node_21 : node port map(clock => clock, ocupation => ocupation(21), out_test => OPEN);
	node_22 : node port map(clock => clock, ocupation => ocupation(22), out_test => OPEN);
	node_23 : node port map(clock => clock, ocupation => ocupation(23), out_test => OPEN);
	node_24 : node port map(clock => clock, ocupation => ocupation(24), out_test => OPEN);
	node_25 : node port map(clock => clock, ocupation => ocupation(25), out_test => OPEN);
	node_26 : node port map(clock => clock, ocupation => ocupation(26), out_test => OPEN);
	node_27 : node port map(clock => clock, ocupation => ocupation(27), out_test => OPEN);
	node_28 : node port map(clock => clock, ocupation => ocupation(28), out_test => OPEN);
	node_29 : node port map(clock => clock, ocupation => ocupation(29), out_test => OPEN);
	node_30 : node port map(clock => clock, ocupation => ocupation(30), out_test => OPEN);
	node_31 : node port map(clock => clock, ocupation => ocupation(31), out_test => OPEN);
	node_32 : node port map(clock => clock, ocupation => ocupation(32), out_test => OPEN);
	node_33 : node port map(clock => clock, ocupation => ocupation(33), out_test => OPEN);
	node_34 : node port map(clock => clock, ocupation => ocupation(34), out_test => OPEN);
	node_35 : node port map(clock => clock, ocupation => ocupation(35), out_test => OPEN);
	node_36 : node port map(clock => clock, ocupation => ocupation(36), out_test => OPEN);
	node_37 : node port map(clock => clock, ocupation => ocupation(37), out_test => OPEN);
	node_38 : node port map(clock => clock, ocupation => ocupation(38), out_test => OPEN);
	node_39 : node port map(clock => clock, ocupation => ocupation(39), out_test => OPEN);
	node_40 : node port map(clock => clock, ocupation => ocupation(40), out_test => OPEN);
	node_41 : node port map(clock => clock, ocupation => ocupation(41), out_test => OPEN);
	node_42 : node port map(clock => clock, ocupation => ocupation(42), out_test => OPEN);
	node_43 : node port map(clock => clock, ocupation => ocupation(43), out_test => OPEN);
	node_44 : node port map(clock => clock, ocupation => ocupation(44), out_test => OPEN);
	node_45 : node port map(clock => clock, ocupation => ocupation(45), out_test => OPEN);
	node_46 : node port map(clock => clock, ocupation => ocupation(46), out_test => OPEN);
	node_47 : node port map(clock => clock, ocupation => ocupation(47), out_test => OPEN);
	node_48 : node port map(clock => clock, ocupation => ocupation(48), out_test => OPEN);
	node_49 : node port map(clock => clock, ocupation => ocupation(49), out_test => OPEN);
	node_50 : node port map(clock => clock, ocupation => ocupation(50), out_test => OPEN);
	node_51 : node port map(clock => clock, ocupation => ocupation(51), out_test => OPEN);
	node_52 : node port map(clock => clock, ocupation => ocupation(52), out_test => OPEN);
end Behavioral;