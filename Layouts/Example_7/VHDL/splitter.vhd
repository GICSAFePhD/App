--  splitter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity splitter is
		generic(
			N : natural := 47;
			N_SIGNALS : natural := 13;
			N_SINGLESWITCHES : natural := 3;
			N_ROUTES : natural := 11;
			N_TRACKCIRCUITS : natural := 7
		);
		port(
			clock : in std_logic;
			packet :  in std_logic_vector(N-1 downto 0);
			processing :  in std_logic;
			processed :  out std_logic;
			ocupation :  out std_logic_vector(N_TRACKCIRCUITS-1 downto 0);
			signals :  out signals_type;
			routes : out std_logic_vector(N_ROUTES-1 downto 0);
			singleSwitches : out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			reset : in std_logic
		);
	end entity splitter;
architecture Behavioral of splitter is
	Signal tc_s : std_logic_vector(7-1 downto 0);
	Signal sig_s_i,sig_s_o : signals_type;
	Signal rt_s_i,rt_s_o : std_logic_vector(11-1 downto 0);
	Signal ssw_s_i,ssw_s_o : std_logic_vector(3-1 downto 0);
begin
	process(clock,reset)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				ocupation <= "0000000";
				signals.lsb <= "0000000000000";
				signals.msb <= "0000000000000";
				routes <= "00000000000";
				singleSwitches <= "000";
				processed <= '0';
			else
				processed <= processing;
				if processing = '1' then
					ocupation(0) <= packet(46);
					ocupation(1) <= packet(45);
					ocupation(2) <= packet(44);
					ocupation(3) <= packet(43);
					ocupation(4) <= packet(42);
					ocupation(5) <= packet(41);
					ocupation(6) <= packet(40);
					routes(0) <= packet(39);
					routes(1) <= packet(38);
					routes(2) <= packet(37);
					routes(3) <= packet(36);
					routes(4) <= packet(35);
					routes(5) <= packet(34);
					routes(6) <= packet(33);
					routes(7) <= packet(32);
					routes(8) <= packet(31);
					routes(9) <= packet(30);
					routes(10) <= packet(29);
					signals.msb(0) <= packet(28);
					signals.lsb(0) <= packet(27);
					signals.msb(1) <= packet(26);
					signals.lsb(1) <= packet(25);
					signals.msb(2) <= packet(24);
					signals.lsb(2) <= packet(23);
					signals.msb(3) <= packet(22);
					signals.lsb(3) <= packet(21);
					signals.msb(4) <= packet(20);
					signals.lsb(4) <= packet(19);
					signals.msb(5) <= packet(18);
					signals.lsb(5) <= packet(17);
					signals.msb(6) <= packet(16);
					signals.lsb(6) <= packet(15);
					signals.msb(7) <= packet(14);
					signals.lsb(7) <= packet(13);
					signals.msb(8) <= packet(12);
					signals.lsb(8) <= packet(11);
					signals.msb(9) <= packet(10);
					signals.lsb(9) <= packet(9);
					signals.msb(10) <= packet(8);
					signals.lsb(10) <= packet(7);
					signals.msb(11) <= packet(6);
					signals.lsb(11) <= packet(5);
					signals.msb(12) <= packet(4);
					signals.lsb(12) <= packet(3);
					singleSwitches(0) <= packet(2);
					singleSwitches(1) <= packet(1);
					singleSwitches(2) <= packet(0);
				end if;
			end if;
		end if;
	end process;
end Behavioral;