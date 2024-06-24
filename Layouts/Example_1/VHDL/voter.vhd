--  voter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity voter is
		generic(
			N_TRACKCIRCUITS : natural := 11;
			N_ROUTES : natural := 21;
			N_SIGNALS : natural := 23;
			N_LEVELCROSSINGS : natural := 2;
			N_SINGLESWITCHES : natural := 5;
			N : natural := 62
		);
		port(
			clock : in std_logic;
			processing_A : in std_logic;
			processing_B : in std_logic;
			processing_C : in std_logic;
			processed_V : buffer std_logic;
			tracks_A: in hex_array(N_TRACKCIRCUITS-1 downto 0);
			tracks_B: in hex_array(N_TRACKCIRCUITS-1 downto 0);
			tracks_C: in hex_array(N_TRACKCIRCUITS-1 downto 0);
			tracks_V: buffer hex_array(N_TRACKCIRCUITS-1 downto 0);
			signals_A : in hex_array(N_SIGNALS-1 downto 0);
			signals_B : in hex_array(N_SIGNALS-1 downto 0);
			signals_C : in hex_array(N_SIGNALS-1 downto 0);
			signals_V : buffer hex_array(N_SIGNALS-1 downto 0);
			routes_A : in hex_array(N_ROUTES-1 downto 0);
			routes_B : in hex_array(N_ROUTES-1 downto 0);
			routes_C : in hex_array(N_ROUTES-1 downto 0);
			routes_V : buffer hex_array(N_ROUTES-1 downto 0);
			levelCrossings_A : in hex_array(N_LEVELCROSSINGS-1 downto 0);
			levelCrossings_B : in hex_array(N_LEVELCROSSINGS-1 downto 0);
			levelCrossings_C : in hex_array(N_LEVELCROSSINGS-1 downto 0);
			levelCrossings_V : buffer hex_array(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches_A : in hex_array(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_B : in hex_array(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_C : in hex_array(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_V : buffer hex_array(N_SINGLESWITCHES-1 downto 0);
			reset : in std_logic
		);
	end entity voter;
architecture Behavioral of voter is
	function two_out_of_three_hex(input1, input2, input3: hex_char) return hex_char is
	begin
		if (input1 = input2) then
			return input1;
		elsif (input1 = input3) then
			return input1;
		elsif (input2 = input3) then
			return input2;
		else
			return 'F';  -- Return 'F' to indicate the default case;
		end if;
	end function;
	function two_out_of_three(input1, input2, input3: std_logic) return std_logic is
	begin
		if (input1 = input2) then
			return input1;
		elsif (input1 = input3) then
			return input1;
		elsif (input2 = input3) then
			return input2;
		else
			return '0';  -- Return '0' to indicate the default case;
		end if;
	end function;
	signal default_case_flag : std_logic;
begin
	process(clock, reset)
	begin
		if reset = '1' then
			processed_V <= '0';
			default_case_flag <= '0';
		elsif rising_edge(clock) then
			default_case_flag <= '0';  -- Reset the flag
			for i in 0 to N_TRACKCIRCUITS-1 loop
				tracks_V(i) <= two_out_of_three_hex(tracks_A(i), tracks_B(i), tracks_C(i));
				if tracks_V(i) = 'F' then
					default_case_flag <= '1';
				end if;
			end loop;
			for i in 0 to N_SIGNALS-1 loop
				signals_V(i) <= two_out_of_three_hex(signals_A(i), signals_B(i), signals_C(i));
				if signals_V(i) = 'F' then
					default_case_flag <= '1';
				end if;
			end loop;
			for i in 0 to N_ROUTES-1 loop
				routes_V(i) <= two_out_of_three_hex(routes_A(i), routes_B(i), routes_C(i));
				if routes_V(i) = 'F' then
					default_case_flag <= '1';
				end if;
			end loop;
			for i in 0 to N_LEVELCROSSINGS-1 loop
				levelCrossings_V(i) <= two_out_of_three_hex(levelCrossings_A(i), levelCrossings_B(i), levelCrossings_C(i));
				if levelCrossings_V(i) = 'F' then
					default_case_flag <= '1';
				end if;
			end loop;
			for i in 0 to N_SINGLESWITCHES-1 loop
				singleSwitches_V(i) <= two_out_of_three_hex(singleSwitches_A(i), singleSwitches_B(i), singleSwitches_C(i));
				if singleSwitches_V(i) = 'F' then
					default_case_flag <= '1';
				end if;
			end loop;
			if default_case_flag = '1' then
				processed_V <= '0';
			else
				processed_V <= two_out_of_three(processing_A, processing_B, processing_C);
			end if;
		end if;
	end process;
end Behavioral;