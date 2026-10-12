library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divisor_frequencia_tb is
-- Testbench não possui portas (ports)
end divisor_frequencia_tb;

architecture Behavioral of divisor_frequencia_tb is

    -- Componente a ser testado (DUT - Device Under Test)
    component divisor_frequencia is
        port (
            clk      : in  std_logic;
            rst      : in  std_logic;
            en_count : out std_logic
        );
    end component;

    -- Sinais internos para conectar ao componente
    signal clk_tb      : std_logic := '0';
    signal rst_tb      : std_logic := '0';
    signal en_count_tb : std_logic;

    -- Definição do período do clock (10 ns = 100 MHz)
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instanciação do Divisor de Frequência
    DUT: divisor_frequencia
        port map (
            clk      => clk_tb,
            rst      => rst_tb,
            en_count => en_count_tb
        );

    -- Processo para geração contínua do sinal de Clock
    clk_process : process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD / 2;
        clk_tb <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Processo de estímulos para o teste
    stim_proc: process
    begin
        -- 1. Aplicar Reset inicial
        rst_tb <= '1';
        wait for 20 ns;
        
        -- 2. Liberar o Reset
        rst_tb <= '0';
        
        -- 3. Deixar a simulação rodar por tempo suficiente para ver os pulsos
        wait for 500 ns;

        -- Encerra a simulação
        wait;
    end process;

end Behavioral;
