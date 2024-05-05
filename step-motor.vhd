library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StepMotorDriver is
    Port ( clk : in  STD_LOGIC;
           clk_2 : in STD_LOGIC;
           reset : in  STD_LOGIC;
           step : out  STD_LOGIC_VECTOR(3 downto 0); -- Dört adet çıkış
           direction_input : in STD_LOGIC);
end StepMotorDriver;

architecture Behavioral of StepMotorDriver is
    constant period_clk_1 : integer := 50000000; -- 0.1 saniyede bir adım atılacak şekilde ayarlayabilirsiniz (50 MHz)
    constant period_clk_2 : integer := 100000000; -- İkinci saat sinyalinin periyodu (100 MHz)
    type State_Type is (Step1, Step2, Step3, Step4); -- Dört adet adım durumu
    signal state : State_Type := Step1; -- Başlangıç durumu
    signal counter_clk_1 : integer range 0 to period_clk_1 - 1 := 0;
    signal counter_clk_2 : integer range 0 to period_clk_2 - 1 := 0;
    signal reverse_sequence : boolean := false; -- Adım sırasını tersine çevirme kontrolü
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                counter_clk_1 <= 0;
                counter_clk_2 <= 0;
                state <= Step1; -- Reset durumunda ilk adıma dön
            else
                counter_clk_1 <= counter_clk_1 + 1;
                if counter_clk_1 = period_clk_1 - 1 then
                    counter_clk_1 <= 0;
                    counter_clk_2 <= counter_clk_2 + 1;
                    if counter_clk_2 = period_clk_2 - 1 then
                        counter_clk_2 <= 0;
                        if reverse_sequence then -- Eğer ters sıra aktifse
                            case state is
                                when Step1 =>
                                    step <= "1000"; -- 1000: 4. adım (ters sıra)
                                    state <= Step4;
                                when Step2 =>
                                    step <= "0100"; -- 0100: 3. adım (ters sıra)
                                    state <= Step3;
                                when Step3 =>
                                    step <= "0010"; -- 0010: 2. adım (ters sıra)
                                    state <= Step2;
                                when Step4 =>
                                    step <= "0001"; -- 0001: 1. adım (ters sıra)
                                    state <= Step1; -- Bir sonraki adıma geç
                            end case;
                        else -- Ters sıra devre dışıysa, normal sırayı kullan
                            case state is
                                when Step1 =>
                                    step <= "0001"; -- 0001: 1. adım
                                    state <= Step2;
                                when Step2 =>
                                    step <= "0010"; -- 0010: 2. adım
                                    state <= Step3;
                                when Step3 =>
                                    step <= "0100"; -- 0100: 3. adım
                                    state <= Step4;
                                when Step4 =>
                                    step <= "1000"; -- 1000: 4. adım
                                    state <= Step1; -- Bir sonraki adıma geç
                            end case;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Yön kontrolü
    reverse_sequence <= direction_input; -- Giriş sinyaline göre ters sırayı kontrol et

end Behavioral;
