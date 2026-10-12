library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexador is
    port (
        sel      : in  std_logic_vector(1 downto 0); -- Sinal do contador (00, 01, 10, 11)
        prod_u   : in  std_logic_vector(3 downto 0); -- Dígito das Unidades
        prod_d   : in  std_logic_vector(3 downto 0); -- Dígito das Dezenas
        prod_sig   : in  std_logic_vector(3 downto 0); -- Dígito das Centenas
        dig_prod : out std_logic_vector(3 downto 0)  -- Dígito selecionado para o 7 seg
    );
end multiplexador;

architecture simples of multiplexador is
begin

    -- Seleção combinacional do dígito ativo
    with sel select
        dig_prod <= prod_u when "00",
                    prod_d when "01",
                    prod_sig when "10",
                    "1010" when "11",
                    "0000" when others;

end simples;