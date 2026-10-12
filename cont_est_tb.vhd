library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_cont_est is
-- Testbench não possui portas
end entity;

architecture sim of tb_cont_est is

    -- 1. Declaração do Componente
    component cont_est is
        port (
            en  : in  std_logic;
            clk : in  std_logic;
            rst : in  std_logic;
            sel : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Sinais internos para conectar com a UUT
    signal tb_en  : std_logic := '0';
    signal tb_clk : std_logic := '0';
    signal tb_rst : std_logic := '0';
    signal tb_sel : std_logic_vector(1 downto 0);

    -- Período do clock de 100 MHz (10 ns)
    constant CLK_PERIOD : time := 10 ns;

begin

    -- 2. Instanciação do Componente declarada acima
    uut: cont_est
        port map (
            en  => tb_en,
            clk => tb_clk,
            rst => tb_rst,
            sel => tb_sel
        );

    -- Gerador de Clock (100 MHz)
    clk_process: process
    begin
        tb_clk <= '0';
        wait for CLK_PERIOD / 2;
        tb_clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Processo de Estímulos
    stim_proc: process
    begin
        -- Aplica Reset Inicial
        tb_rst <= '1';
        wait for 20 ns;
        tb_rst <= '0';
        wait for 10 ns;

        -- Teste com Enable desativado (contador parado)
        tb_en <= '0';
        wait for 30 ns;

        -- Ativa o Enable (contador rodando: 0 -> 1 -> 2 -> 3 -> 0...)
        tb_en <= '1';
        wait for 200 ns;

        -- Pausa o contador
        tb_en <= '0';
        wait for 50 ns;

        -- Retoma a contagem
        tb_en <= '1';
        wait for 100 ns;

        -- Encerra a simulação
        wait;
    end process;

end architecture;