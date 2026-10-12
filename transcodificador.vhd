library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trans_cod is
  port (
    dig_prod : in std_logic_vector(3 downto 0);
    m_ca : out std_logic_vector(7 downto 0)
  );
end entity;

architecture simples of trans_cod is
  signal prod_num: integer range 0 to 11;
begin
  prod_num <= to_integer(unsigned(dig_prod));

  -- o display funciona acendendo com zero no segmento
  -- sequencia de letras nos bits A,B,C,D,E,F,G,Dot

  m_ca <= "00000011" when prod_num=0 else --Mostrar dígito 0
          "10011111" when prod_num=1 else --Mostrar dígito 1  
          "00100101" when prod_num=2 else --Mostrar dígito 2
          "00001101" when prod_num=3 else --Mostrar dígito 3
          "10011001" when prod_num=4 else --Mostrar dígito 4
          "01001001" when prod_num=5 else --Mostrar dígito 5
          "01000001" when prod_num=6 else --Mostrar dígito 6
          "00011111" when prod_num=7 else --Mostrar dígito 7
          "00000001" when prod_num=8 else --Mostrar dígito 8
          "00001001" when prod_num=9 else --Mostrar dígito 9
          "11111101" when prod_num=11 else --Mostrar apenas traço central (sinal negativo)
          "11111111"; --Mostrar nada (sem dígito)

end architecture;