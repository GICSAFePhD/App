--  detector.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity detector is
		port(
			Clock : in std_logic;
			r_data : in std_logic_vector(8-1 downto 0);
			r_available : in std_logic;
			led_rgb_1 : out std_logic_vector(3-1 downto 0);
			led_rgb_2 : out std_logic_vector(3-1 downto 0);
			packet : out hex_array(62-1 downto 0);
			processing : in std_logic;
			processed : out std_logic;
			N : in integer;
			wr_uart : out std_logic;
			w_data : out std_logic_vector(8-1 downto 0);
			reset : in std_logic
		);
	end entity detector;
architecture Behavioral of detector is
	type states_t is (idle,reading,final,error);
	signal state : states_t := idle;
	constant tag_start : std_logic_vector(8-1 downto 0) := "00111100"; -- r_data = '<'
	constant tag_end : std_logic_vector(8-1 downto 0) := "00111110"; -- r_data = '>'
	-- Lookup table for ASCII to hex_char conversion
	constant ascii_to_hex : ascii_array := (
		48 => '0', 49 => '1', 50 => '2', 51 => '3', 52 => '4', 53 => '5', 54 => '6', 55 => '7',
		56 => '8', 57 => '9', 65 => 'A', 66 => 'B', 67 => 'C', 68 => 'D', 69 => 'E', 70 => 'F',
		others => '0' -- default value
	);
begin
	detection : process(clock,reset)
		 variable counter : integer range 0 to 93 := 0;
	begin
		if (reset = '1') then
			packet <= (others => '0');
			processed <= '0';
			led_rgb_1 <= "000";
			led_rgb_2 <= "000";
		elsif(rising_edge(clock)) then
			case(state) is
				when idle =>
					packet <= (others => '0');
					processed <= '0';
					led_rgb_1 <= "000";
					led_rgb_2 <= "000";
					if (r_available = '1') then
						if (r_data = tag_start) then
							counter := 1;
							state <= reading;
						end if;
					end if;
				when reading =>
					led_rgb_1 <= "100";
					led_rgb_2 <= "100";
					processed <= '0';
					if (r_available = '1') then
						if (r_data = tag_end) then
							if (counter = 63) then
								state <= final;
							else
								state <= error;
							end if;
						end if;
						if counter < 64 then
							packet(counter-1) <= ascii_to_hex(to_integer(unsigned(r_data)));
							counter := counter + 1;
						else
							counter := 0;
							state <= error;
						end if;
					end if;
				when final =>
					led_rgb_1 <= "010";
					led_rgb_2 <= "010";
					processed <= '1';
					if (r_available = '1') then
						if (r_data = tag_start) then
							counter := 1;
							state <= reading;
						end if;
					end if;
				when error =>
					led_rgb_1 <= "001";
					led_rgb_2 <= "001";
					if (r_available = '1') then
						if (r_data = tag_start) then
							counter := 1;
							state <= reading;
						end if;
					end if;
				when others =>
					led_rgb_1 <= "001";
					led_rgb_2 <= "001";
					if (r_available = '1') then
						if (r_data = tag_start) then
							counter := 1;
							state <= reading;
						end if;
					end if;
			end case;
		end if;
	end process;
	w_data <= r_data;
	wr_uart <= r_available;
end Behavioral;