`timescale 1ns / 1ps
module led_mem(
    input clk,
    input ena,
    input wea,
    input [3:0]addra,
    input [15:0]dina,
    output [15:0]douta
);
sample_mem u_sample_mem(
    .clka(clk),
    .ena(ena),
    .wea(wea),
    .addra(addra),
    .dina(dina),
    .douta(douta)
);
endmodule
