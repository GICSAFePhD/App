--  splitter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity splitter is
		generic(
			N : natural := 56;
			N_SIGNALS : natural := 16;
			N_LEVELCROSSINGS : natural := 4;
			N_SINGLESWITCHES : natural := 2;
			N_ROUTES : natural := 13;
			N_TRACKCIRCUITS : natural := 5
		);
		port(
			clock : in std_logic;
			packet :  in std_logic_vector(N-1 downto 0);
			processing :  in std_logic;
			processed :  out std_logic;
			ocupation :  out std_logic_vector(N_TRACKCIRCUITS-1 downto 0);
			signals :  out signals_type;
			routes : out std_logic_vector(N_ROUTES-1 downto 0);
			levelCrossings : out std_logic_vector(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches : out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			reset : in std_logic
		);
	end entity splitter;
architecture Behavioral of splitter is
	Signal tc_s : std_logic_vector(5-1 downto 0);
	Signal sig_s_i,sig_s_o : signals_type;
	Signal rt_s_i,rt_s_o : std_logic_vector(13-1 downto 0);
	Signal lc_s_i,lc_s_o : std_logic_vector(4-1 downto 0);
	Signal ssw_s_i,ssw_s_o : std_logic_vector(2-1 downto 0);
begin
	process(clock,reset)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				ocupation <= "00000";
				signals.lsb <= "0000000000000000";
				signals.msb <= "0000000000000000";
				routes <= "0000000000000";
				levelCrossings <= "0000";
				singleSwitches <= "00";
				processed <= '0';
			else
				processed <= processing;
				if processing = '1' then
					ocupation(0) <= packet(55);
					ocupation(1) <= packet(54);
					ocupation(2) <= packet(53);
					ocupation(3) <= packet(52);
					ocupation(4) <= packet(51);
					routes(0) <= packet(50);
					routes(1) <= packet(49);
					routes(2) <= packet(48);
					routes(3) <= packet(47);
					routes(4) <= packet(46);
					routes(5) <= packet(45);
					routes(6) <= packet(44);
					routes(7) <= packet(43);
					routes(8) <= packet(42);
					routes(9) <= packet(41);
					routes(10) <= packet(40);
					routes(11) <= packet(39);
					routes(12) <= packet(38);
					signals.msb(0) <= packet(37);
					signals.lsb(0) <= packet(36);
					signals.msb(1) <= packet(35);
					signals.lsb(1) <= packet(34);
					signals.msb(2) <= packet(33);
					signals.lsb(2) <= packet(32);
					signals.msb(3) <= packet(31);
					signals.lsb(3) <= packet(30);
					signals.msb(4) <= packet(29);
					signals.lsb(4) <= packet(28);
					signals.msb(5) <= packet(27);
					signals.lsb(5) <= packet(26);
					signals.msb(6) <= packet(25);
					signals.lsb(6) <= packet(24);
					signals.msb(7) <= packet(23);
					signals.lsb(7) <= packet(22);
					signals.msb(8) <= packet(21);
					signals.lsb(8) <= packet(20);
					signals.msb(9) <= packet(19);
					signals.lsb(9) <= packet(18);
					signals.msb(10) <= packet(17);
					signals.lsb(10) <= packet(16);
					signals.msb(11) <= packet(15);
					signals.lsb(11) <= packet(14);
					signals.msb(12) <= packet(13);
					signals.lsb(12) <= packet(12);
					signals.msb(13) <= packet(11);
					signals.lsb(13) <= packet(10);
					signals.msb(14) <= packet(9);
					signals.lsb(14) <= packet(8);
					signals.msb(15) <= packet(7);
					signals.lsb(15) <= packet(6);
					levelCrossings(0) <= packet(5);
					levelCrossings(1) <= packet(4);
					levelCrossings(2) <= packet(3);
					levelCrossings(3) <= packet(2);
					singleSwitches(0) <= packet(1);
					singleSwitches(1) <= packet(0);
				end if;
			end if;
		end if;
	end process;
end Behavioral;