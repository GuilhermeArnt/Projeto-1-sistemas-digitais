library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decod is
  port (
    sel : in std_logic_vector(1 downto 0);
    m_an : out std_logic_vector(3 downto 0)
  );
end entity;

architecture simples of decod is
begin
  -- o display funciona acendendo com zero no dígito
  -- sequencia de letras nos bits A3,A2,A1,A0

  m_an <= "1110" when sel="00" else --Mostrar dígito 1 do display
          "1101" when sel="01" else --Mostrar dígito 2 do display
          "1011" when sel="10" else --Mostrar dígito 3 do display
          "0111" when sel="11" else --Mostrar dígito 4 do display (idealmente nunca vai ter nada)
          "1111"; -- Não mostrar nada caso não esteja em nenhum deles

end architecture;