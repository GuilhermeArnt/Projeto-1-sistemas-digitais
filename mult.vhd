library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult is
  port (
    mcador : in std_logic_vector(3 downto 0);
    mcando : in std_logic_vector(3 downto 0);
    prod : out std_logic_vector(7 downto 0)  
  );
end entity;

architecture simples of mult is

  component iteracao_mult is
    port (
      prod_c_in : in  std_logic_vector(3 downto 0); -- Parte mais significativa (4 bits superiores)
      prod_d_in : in  std_logic_vector(3 downto 0); -- Parte menos significativa (4 bits inferiores)
      BA_in     : in  std_logic;                    -- Bit Auxiliar de entrada
      mcando    : in  std_logic_vector(3 downto 0); -- Multiplicando

      prod_c_out: out std_logic_vector(3 downto 0); -- Parte mais significativa de saída
      prod_d_out: out std_logic_vector(3 downto 0); -- Parte menos significativa de saída
      BA_out    : out std_logic                     -- Bit Auxiliar de saída
    );
  end component;

  -- Sinais intermediários para interligar as 4 iterações
    -- Iteração 0 -> 1
    signal prod_c_0, prod_d_0 : STD_LOGIC_VECTOR(3 downto 0);
    signal BA_0 : STD_LOGIC;

    -- Iteração 1 -> 2
    signal prod_c_1, prod_d_1 : STD_LOGIC_VECTOR(3 downto 0);
    signal BA_1 : STD_LOGIC;

    -- Iteração 2 -> 3
    signal prod_c_2, prod_d_2 : STD_LOGIC_VECTOR(3 downto 0);
    signal BA_2 : STD_LOGIC;

    -- Iteração 3 -> 4 (Saída final)
    signal prod_c_3, prod_d_3 : STD_LOGIC_VECTOR(3 downto 0);
    signal BA_3 : STD_LOGIC;

  begin

  -- valores iniciais para a prmieira iteração
    prod_c_0 <= "0000";
    prod_d_0 <= mcador;
    BA_0 <= '0';

  -- iteração 1
  iter1: iteracao_mult port map(
    prod_c_in  => prod_c_0,
    prod_d_in  => prod_d_0,
    BA_in      => BA_0,
    mcando     => mcando,
    prod_c_out => prod_c_1,
    prod_d_out => prod_d_1,
    BA_out     => BA_1
  );

-- iteração 2
  iter2: iteracao_mult port map (
    prod_c_in  => prod_c_1,
    prod_d_in  => prod_d_1,
    BA_in      => BA_1,
    mcando     => mcando,
    prod_c_out => prod_c_2,
    prod_d_out => prod_d_2,
    BA_out     => BA_2
  );

  -- iteração 3
  iter3: iteracao_mult port map (
    prod_c_in  => prod_c_2,
    prod_d_in  => prod_d_2,
    BA_in      => BA_2,
    mcando     => mcando,
    prod_c_out => prod_c_3,
    prod_d_out => prod_d_3,
    BA_out     => BA_3
  );

  -- iteração 4
  iter4: iteracao_mult port map (
    prod_c_in  => prod_c_3,
    prod_d_in  => prod_d_3,
    BA_in      => BA_3,
    mcando     => mcando,
    prod_c_out => prod(7 downto 4), -- Conecta diretamente nos 4 bits superiores da saída prod
    prod_d_out => prod(3 downto 0), -- Conecta diretamente nos 4 bits inferiores da saída prod
    BA_out     => open              -- O último BA não é utilizado
  );
  

end architecture;
