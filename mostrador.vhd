library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mostrador is
  port (
    clk : in std_logic;
    rst : in std_logic;
    prod : in std_logic_vector(7 downto 0);
    m_an : out std_logic_vector(3 downto 0);
    m_ca : out std_logic_vector(7 downto 0)
  );
end entity;

architecture simples of mostrador is

component controle_mostrador is
  port (
    clk : in std_logic;
    rst : in std_logic;
    prod_u : in std_logic_vector(3 downto 0); --Digito da unidade
    prod_d : in std_logic_vector(3 downto 0); --Digito da dezena
    prod_sig : in std_logic_vector(3 downto 0);--Combinação para mostrar o sinal do número no 3 dígito do mostrador
    m_an : out std_logic_vector(3 downto 0);
    m_ca : out std_logic_vector(7 downto 0)
  );
end component;

component conv_bcd is
  port (
    prod : in std_logic_vector(7 downto 0);
    prod_u : out std_logic_vector(3 downto 0); --Digito da unidade
    prod_d : out std_logic_vector(3 downto 0); --Digito da dezena
    prod_sig : out std_logic_vector(3 downto 0)--Combinação para mostrar o sinal do número no 3 dígito do mostrador
  );
end component;

  signal prod_u : std_logic_vector(3 downto 0); --Digito da unidade
  signal prod_d : std_logic_vector(3 downto 0); --Digito da dezena
  signal prod_sig : std_logic_vector(3 downto 0);

begin

  DUT_conv_bcd: conv_bcd port map(
     prod => prod,
     prod_u => prod_u,
     prod_d => prod_d,
     prod_sig => prod_sig
  );

  DUT_controle: controle_mostrador port map(
     clk => clk,
     rst => rst,
     prod_u => prod_u,
     prod_d => prod_d,
     prod_sig => prod_sig,
     m_ca => m_ca,
     m_an => m_an
  );

end architecture;