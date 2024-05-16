--  splitter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity splitter is
		generic(
			N : natural := 45;
			N_SIGNALS : natural := 12;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 3;
			N_ROUTES : natural := 10;
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
			levelCrossings : out std_logic;
			singleSwitches : out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			reset : in std_logic
		);
	end entity splitter;
architecture Behavioral of splitter is
	Signal tc_s : std_logic_vector(7-1 downto 0) := (others => '0');
	Signal sig_s_i,sig_s_o : signals_type := (msb => (others => '0'), lsb => (others => '0'));
	Signal rt_s_i,rt_s_o : std_logic_vector(10-1 downto 0);
	Signal lc_s_i,lc_s_o : std_logic := '0';
	Signal ssw_s_i,ssw_s_o : std_logic_vector(3-1 downto 0) := (others => '0');
begin
	process(clock,reset)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				ocupation <= "0000000";
				signals.lsb <= "000000000000";
				signals.msb <= "000000000000";
				routes <= "0000000000";
				levelCrossings <= '0';
				singleSwitches <= "000";
				processed <= '0';
			else
				processed <= processing;
				if processing = '1' then
					ocupation(0) <= packet(44);
					ocupation(1) <= packet(43);
					ocupation(2) <= packet(42);
					ocupation(3) <= packet(41);
					ocupation(4) <= packet(40);
					ocupation(5) <= packet(39);
					ocupation(6) <= packet(38);
					routes(0) <= packet(37);
					routes(1) <= packet(36);
					routes(2) <= packet(35);
					routes(3) <= packet(34);
					routes(4) <= packet(33);
					routes(5) <= packet(32);
					routes(6) <= packet(31);
					routes(7) <= packet(30);
					routes(8) <= packet(29);
					routes(9) <= packet(28);
					signals.msb(0) <= packet(27);
					signals.lsb(0) <= packet(26);
					signals.msb(1) <= packet(25);
					signals.lsb(1) <= packet(24);
					signals.msb(2) <= packet(23);
					signals.lsb(2) <= packet(22);
					signals.msb(3) <= packet(21);
					signals.lsb(3) <= packet(20);
					signals.msb(4) <= packet(19);
					signals.lsb(4) <= packet(18);
					signals.msb(5) <= packet(17);
					signals.lsb(5) <= packet(16);
					signals.msb(6) <= packet(15);
					signals.lsb(6) <= packet(14);
					signals.msb(7) <= packet(13);
					signals.lsb(7) <= packet(12);
					signals.msb(8) <= packet(11);
					signals.lsb(8) <= packet(10);
					signals.msb(9) <= packet(9);
					signals.lsb(9) <= packet(8);
					signals.msb(10) <= packet(7);
					signals.lsb(10) <= packet(6);
					signals.msb(11) <= packet(5);
					signals.lsb(11) <= packet(4);
					levelCrossings <= packet(3);
					singleSwitches(0) <= packet(2);
					singleSwitches(1) <= packet(1);
					singleSwitches(2) <= packet(0);
				end if;
			end if;
		end if;
	end process;
end Behavioral;