library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_topo is
  port (
    clk : in std_logic;
    rst : in std_logic;
    mcador : in std_logic_vector(3 downto 0);
    mcando : in std_logic_vector(3 downto 0);
    m_an : out std_logic_vector(3 downto 0);
    m_ca : out std_logic_vector(7 downto 0)
  );
end entity;

architecture simples of mult_topo is

component mult is
  port (
    mcador : in std_logic_vector(3 downto 0);
    mcando : in std_logic_vector(3 downto 0);
    prod : out std_logic_vector(7 downto 0)  
  );
end component;

component mostrador is
  port (
    clk : in std_logic;
    rst : in std_logic;
    prod : in std_logic_vector(7 downto 0);
    m_an : out std_logic_vector(3 downto 0);
    m_ca : out std_logic_vector(7 downto 0)
  );
end component;

signal prod : std_logic_vector(7 downto 0);

begin

  DUT_mult: mult port map(
    mcador => mcador,
    mcando => mcando,
    prod => prod
  );


  DUT_mostrador: mostrador port map(
    clk => clk,
    rst => rst,
    prod => prod,
    m_ca => m_ca,
    m_an => m_an
  );


end architecture;