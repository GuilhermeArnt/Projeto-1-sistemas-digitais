library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity iteracao_mult is

  port (
    prod_c_in : in  std_logic_vector(3 downto 0); -- Parte mais significativa (4 bits superiores)
    prod_d_in : in  std_logic_vector(3 downto 0); -- Parte menos significativa (4 bits inferiores)
    BA_in     : in  std_logic;                    -- Bit Auxiliar de entrada
    mcando    : in  std_logic_vector(3 downto 0); -- Multiplicando

    prod_c_out: out std_logic_vector(3 downto 0); -- Parte mais significativa de saída
    prod_d_out: out std_logic_vector(3 downto 0); -- Parte menos significativa de saída
    BA_out    : out std_logic                     -- Bit Auxiliar de saída
  );
end entity;

architecture simples of iteracao_mult is
  signal op : std_logic_vector(1 downto 0);
  signal prod_c_s : signed(4 downto 0);
  signal mcando_s : signed(4 downto 0);
  signal res_op : signed(4 downto 0);

  signal vetor_concat : STD_LOGIC_VECTOR(9 downto 0); -- para concatenar tudo
  signal vetor_desloc : STD_LOGIC_VECTOR(9 downto 0); -- para deslocar tudo de uma vez

  begin 
    -- decidindo a operação a ser feita na iteração
    op <= prod_d_in(0) & BA_in;

    -- conversão para tipo signed para permitir a iteração com sinal
    prod_c_s <= signed(prod_c_in(3) & prod_c_in);
    mcando_s <= signed(mcando(3) & mcando);

    --realizando a operação conforme operando
    res_op <= prod_c_s + mcando_s when op = "01" else
              prod_c_s - mcando_s when op = "10" else
              prod_c_s;

    --juntando tudo em um unico vetor
    vetor_concat <= std_logic_vector(res_op) & prod_d_in & BA_in;

    --deslocando à direita
    vetor_desloc <= vetor_concat(9) & vetor_concat(9 downto 1);

    -- valores resultantes da iteração (a serem utilizados para a resposta final ou para a próxima iteração)
    prod_c_out <= vetor_desloc(8 downto 5); -- 4 bits mais significativos do resultado da iteração
    prod_d_out <= vetor_desloc(4 downto 1); -- 4 bits menos significativos do resultado da iteração
    BA_out     <= vetor_desloc(0);          -- Novo Bit Auxiliar


end architecture;

