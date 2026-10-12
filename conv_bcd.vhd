library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conv_bcd is
  port (
    prod : in std_logic_vector(7 downto 0);
    prod_u : out std_logic_vector(3 downto 0); --Digito da unidade
    prod_d : out std_logic_vector(3 downto 0); --Digito da dezena
    prod_sig : out std_logic_vector(3 downto 0)--Combinação para mostrar o sinal do número no 3 dígito do mostrador
  );
end entity;

architecture simples of conv_bcd is
  signal prod_num : signed(7 downto 0);
  signal prod_num_abs : integer range 0 to 64;
  signal prod_u_num : integer range 0 to 9;
  signal prod_d_num : integer range 0 to 9;

begin
  prod_num <= signed(prod);
  
  -- Definindo o sinal
  prod_sig <= "1011" when prod_num<0 else "1010";

  prod_num_abs <= to_integer(abs(prod_num));

  -- Definindo as unidade e dezena
  prod_d_num <= prod_num_abs/10;
  prod_u_num <= prod_num_abs rem 10;

  prod_d <= std_logic_vector(to_unsigned(prod_d_num, 4));
  prod_u <= std_logic_vector(to_unsigned(prod_u_num, 4));
end architecture;