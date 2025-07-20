`timescale 1ns / 1ps
`include "contador.v"
module TestBench;

    // Parámetros
    parameter PERIOD = 10;
    parameter bits=4;
    // Señales del test bench
    reg clk, rst, select;
    wire [3:0] count;

    // Instancia del contador a probar
    counter #(.bits(bits))cont1 (
        .clk(clk),
        .rst(rst),
	.select(select),
        .count(count)
    );

    // Generación del reloj
    always 
	#((PERIOD)/2) clk = ~clk;

    // Proceso para verificar el contador
    initial begin
        $dumpfile("count_tb.vcd");
        $dumpvars(0, TestBench);

        // Reset inicial
	clk =1;
        rst = 1;
	select=0;
        #5;
        rst = 0;

        // Esperar algunos ciclos de reloj para verificar el contador
        #30;
	select=1;
        // Finalizar simulación
        #100;
        $finish;
    end

endmodule
