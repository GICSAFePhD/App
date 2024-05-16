--  detector.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	entity detector is
		port(
			Clock : in std_logic;
			r_data : in std_logic_vector(8-1 downto 0);
			r_available : in std_logic;
			led_rgb_1 : out std_logic_vector(3-1 downto 0);
			led_rgb_2 : out std_logic_vector(3-1 downto 0);
			packet : out std_logic_vector(316-1 downto 0);
			processing : in std_logic;
			processed : out std_logic;
			N : in integer;
			wr_uart : out std_logic;
			w_data : out std_logic_vector(8-1 downto 0);
			reset : in std_logic
		);
	end entity detector;
architecture Behavioral of detector is
	type states_t is (start,reading,final,error);
	signal state, next_state : states_t;
	shared variable counter : integer range 0 to 474 := 0;
	signal packet_aux : std_logic_vector(316-1 downto 0);
	signal new_data : std_logic;
	signal length_ok,tags_ok : std_logic;
	signal tags_start,tags_end : std_logic;
	constant tag_start : std_logic_vector(8-1 downto 0) := "00111100"; -- r_data = '<'
	constant tag_end : std_logic_vector(8-1 downto 0) := "00111110"; -- r_data = '>'
	constant char_0 : std_logic_vector(8-1 downto 0) := "00110000"; -- r_data = '0'
	constant char_1 : std_logic_vector(8-1 downto 0) := "00110001"; -- r_data = '1' 
begin
	states_transition : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				state <= start;
			else
				if processing = '1' then
					state <= start;
				else
					state <= next_state;
				end if;
			end if;
		end if;
	end process;
	increase_counter : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				counter := 0;
			else
				if r_available = '1' then
					if state = reading then
						if counter < 318 then
							counter := counter + 1;
						end if;
					end if;
				end if;
				if counter > 316 and counter < 318 then
					counter := counter + 1;
				end if;
				if state = final or state = error then
					counter := 0;
				end if;
			end if;
		end if;
	end process;
	packing : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				packet_aux <= (others => '0');
				new_data <= '0';
			else
				if state = reading then
					if r_available = '1' then
						if counter < 317 then
							if r_data = char_0 then
								packet_aux(316-counter) <= '0';
							end if;
							if r_data = char_1 then
								packet_aux(316-counter) <= '1';
							end if;
						end if;
						new_data <= '1';
					else
						new_data <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;
	states : process(clock,state)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				next_state <= start;
				tags_start <= '0';
				tags_end <= '0';
			else
				next_state <= state;
				-- LED4 = RGB2 | LED5 => RGB1
				-- BGR -> 001 = R | 010 = G | 100 = B
				case(state) is
					when start =>
						tags_start <= '0';
						if r_data = tag_start then -- r_data = '<'
							tags_start <= '1';
							tags_end <= '0';
							next_state <= reading;
						end if;
					when reading =>
						if counter = 318 then -- 316 (it fits 316)
							if r_data = tag_end then --  r_data = '>'
								tags_end <= '1';
								next_state <= final;
							else
								tags_end <= '0';
								next_state <= error;
							end if;
						else
							tags_end <= '0';
						end if;
					when final =>
						if processing = '1' then
							next_state <= start;
						end if;
					when error =>
						tags_start <= '0';
						tags_end <= '0';
						next_state <= start;
					when others => null;
				end case;
			end if;
		end if;
	end process;
	packet_ready : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				processed <= '0';
			else
				if state = final then
					processed <= length_ok and tags_ok;
				else
					processed <= '0';
				end if;
			end if;
		end if;
	end process;
	tag_analyzer : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				tags_ok <= '0';
				led_rgb_1 <= "001"; -- red
			else
				tags_ok <= tags_start and tags_end;
				if tags_ok = '1' then
					led_rgb_1 <= "010"; -- green
				else
					led_rgb_1 <= "001"; -- red
				end if;
				if state = reading then
					led_rgb_1 <= "001"; -- red
				end if;
			end if;
		end if;
	end process;
	length_analyzer : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				length_ok <= '0';
				led_rgb_2 <= "001"; -- red
			else
				if N = 318 then
					length_ok <= '1';
					led_rgb_2 <= "010"; -- green
				else
					length_ok <= '0';
					led_rgb_2 <= "001"; -- red
				end if;
				if state = reading then
					led_rgb_2 <= "001"; -- red
				end if;   
			end if;
		end if;
	end process;
	packet_valid : process(clock)
	begin
		if (clock = '1' and Clock'event) then
			if reset = '1' then
				packet <= (others => '0');
			else
				if state = final and length_ok = '1' and tags_ok = '1' then
					packet <= packet_aux;
				end if;
			end if;
		end if;
	end process;
	w_data <= r_data;
	wr_uart <= r_available;
end Behavioral;