library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conv_bcd_tb is
end entity;

architecture simples of conv_bcd_tb is

  component conv_bcd is
    port (
      prod     : in  std_logic_vector(7 downto 0);
      prod_u   : out std_logic_vector(3 downto 0);
      prod_d   : out std_logic_vector(3 downto 0);
      prod_sig : out std_logic_vector(3 downto 0)
    );
  end component;

  signal prod_tb     : std_logic_vector(7 downto 0) := (others => '0');
  signal prod_u_tb   : std_logic_vector(3 downto 0);
  signal prod_d_tb   : std_logic_vector(3 downto 0);
  signal prod_sig_tb : std_logic_vector(3 downto 0);

begin

  DUT : conv_bcd port map (
    prod     => prod_tb,
    prod_u   => prod_u_tb,
    prod_d   => prod_d_tb,
    prod_sig => prod_sig_tb
  );

  process
  begin
    -- 1. Teste: 0 ("00000000") -> sig: 10 (+), d: 0, u: 0
    prod_tb <= std_logic_vector(to_signed(0, 8));
    wait for 20 ns;

    -- 2. Teste: +6 ("00000110") -> sig: 10 (+), d: 0, u: 6
    prod_tb <= std_logic_vector(to_signed(6, 8));
    wait for 20 ns;

    -- 3. Teste: -5 ("11111011") -> sig: 11 (-), d: 0, u: 5
    prod_tb <= std_logic_vector(to_signed(-5, 8));
    wait for 20 ns;

    -- 4. Teste: +64 (-8 * -8 = 64) ("01000000") -> sig: 10 (+), d: 6, u: 4
    prod_tb <= std_logic_vector(to_signed(64, 8));
    wait for 20 ns;

    -- 5. Teste: -56 (-8 * 7 = -56) ("11001000") -> sig: 11 (-), d: 5, u: 6
    prod_tb <= std_logic_vector(to_signed(-56, 8));
    wait for 20 ns;

    -- 6. Teste: -14 (7 * -2) ("11110010") -> sig: 11 (-), d: 1, u: 4
    prod_tb <= std_logic_vector(to_signed(-14, 8));
    wait for 20 ns;

    -- 7. Teste: 0 ("00000000") -> sig: 10 (+), d: 0, u: 0
    prod_tb <= std_logic_vector(to_signed(0, 8));
    wait for 40 ns;
  end process;

end architecture;