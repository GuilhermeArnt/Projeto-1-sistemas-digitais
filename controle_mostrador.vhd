library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controle_mostrador is
  port (
    clk : in std_logic;
    rst : in std_logic;
    prod_u : in std_logic_vector(3 downto 0); --Digito da unidade
    prod_d : in std_logic_vector(3 downto 0); --Digito da dezena
    prod_sig : in std_logic_vector(3 downto 0);--Combinação para mostrar o sinal do número no 3 dígito do mostrador
    m_an : out std_logic_vector(3 downto 0);
    m_ca : out std_logic_vector(7 downto 0)
  );
end entity;

architecture simples of controle_mostrador is

component divisor_frequencia is
    port (
        clk      : in  std_logic; -- Clock da placa Nexys3 (100 MHz)
        rst      : in  std_logic; -- Reset síncrono/assíncrono
        en_count : out std_logic  -- Sinal de habilitação para o contador
    );
end component;

component cont_est is
  port (
    en : in std_logic; -- vem do divisor de frequencia
    clk : in std_logic; --100MHz da placa
    rst : in std_logic; --reset assíncrono
    sel : out std_logic_vector(1 downto 0)
  );
end component;

component multiplexador is
    port (
        sel      : in  std_logic_vector(1 downto 0); -- Sinal do contador (00, 01, 10, 11)
        prod_u   : in  std_logic_vector(3 downto 0); -- Dígito das Unidades
        prod_d   : in  std_logic_vector(3 downto 0); -- Dígito das Dezenas
        prod_sig : in  std_logic_vector(3 downto 0); -- Dígito das Centenas
        dig_prod : out std_logic_vector(3 downto 0)  -- Dígito selecionado para o 7 seg
    );
end component;

component trans_cod is
  port (
    dig_prod : in std_logic_vector(3 downto 0);
    m_ca : out std_logic_vector(7 downto 0)
  );
end component;

component decod is
  port (
    sel : in std_logic_vector(1 downto 0);
    m_an : out std_logic_vector(3 downto 0)
  );
end component;

  signal sel_est : std_logic_vector(1 downto 0);
  signal en_cont_est : std_logic;
  signal dig_prod : std_logic_vector(3 downto 0);

begin

  DUT_div_freq: divisor_frequencia port map(
     clk => clk,
     rst => rst,
     en_count => en_cont_est
  );

  DUT_cont_est: cont_est port map(
     en => en_cont_est,
     clk => clk,
     rst => rst,
     sel => sel_est
  );
  
  DUT_decod: decod port map(
     sel => sel_est,
     m_an => m_an
  );

  DUT_mux: multiplexador port map(
     sel => sel_est,
     prod_u => prod_u,
     prod_d => prod_d,
     prod_sig => prod_sig,
     dig_prod => dig_prod
  );

  DUT_trans_cod: trans_cod port map(
     dig_prod => dig_prod,
     m_ca => m_ca
  );


end architecture;