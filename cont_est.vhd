library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cont_est is
  port (
    en : in std_logic; -- vem do divisor de frequencia
    clk : in std_logic; --100MHz da placa
    rst : in std_logic; --reset assíncrono
    sel : out std_logic_vector(1 downto 0)
  );
end entity;

architecture simples of cont_est is
  signal estado : unsigned(1 downto 0) := "00";

begin

   process(clk, rst)
    begin
        if rst = '1' then
            estado <= "00";
        elsif rising_edge(clk) then
	  if en = '1' then
                estado <= estado + 1;
          end if;
        end if;
    end process;

   sel <= std_logic_vector(estado);

end architecture;