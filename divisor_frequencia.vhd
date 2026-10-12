library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divisor_frequencia is
    port (
        clk      : in  std_logic; -- Clock da placa Nexys3 (100 MHz)
        rst      : in  std_logic; -- Reset síncrono/assíncrono
        en_count : out std_logic  -- Sinal de habilitação para o contador
    );
end divisor_frequencia;

architecture Behavioral of divisor_frequencia is
    -- Para reduzir 100 MHz para ~500 Hz (período de 2 ms):
    -- 100.000.000 / 500 = 200.000 pulsos de clock
    constant LIMITE : integer := 200000 - 1;
    signal contador : integer range 0 to LIMITE := 0;
begin

    process(clk, rst)
    begin
        if rst = '1' then
            contador <= 0;
            en_count <= '0';
        elsif rising_edge(clk) then
            if contador = LIMITE then
                contador <= 0;
                en_count <= '1'; -- Gera o pulso por 1 ciclo de clock
            else
                contador <= contador + 1;
                en_count <= '0';
            end if;
        end if;
    end process;

end Behavioral;