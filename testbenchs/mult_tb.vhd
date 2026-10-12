library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mult_tb is
end mult_tb;

architecture simples of mult_tb is
    
    component mult is
      port (
        mcador : in std_logic_vector(3 downto 0);
        mcando : in std_logic_vector(3 downto 0);
        prod : out std_logic_vector(7 downto 0)  
      );
    end component;

    -- Sinais de Teste para conectar nas entradas e saídas da UUT
    signal mcando_tb : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal mcador_tb : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal prod_tb   : STD_LOGIC_VECTOR(7 downto 0);

  begin
    
    DUT : mult port map(
        mcando => mcando_tb,
        mcador => mcador_tb,
        prod   => prod_tb
    );
    
    process
    begin
        
        -- Teste 1 -> -3 * -5 = 15
        mcando_tb <= "1011"; 
        mcador_tb <= "1101"; 
        wait for 20 ns;

        -- Teste 2 -> 3 * 2 = 6
        mcando_tb <= "0011"; 
        mcador_tb <= "0010";
        wait for 20 ns;
        
        -- Teste 3 -> 7 * -2 = -14
        mcando_tb <= "0111"; 
        mcador_tb <= "1110";
        wait for 20 ns;

        -- Teste 4 -> -8 * 7 = -56
        mcando_tb <= "1000"; 
        mcador_tb <= "0111"; 
        wait for 20 ns;

        -- Teste 5 -> -3 * 0 = 0
        mcando_tb <= "1011"; 
        mcador_tb <= "0000"; 
        wait for 20 ns;
        
        wait for 30 ns;

    end process;
end;
