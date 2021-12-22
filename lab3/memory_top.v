module memory_top (
    input  wire        clk   ,
	input  wire        rst   ,
	input  wire        button,
	output wire [15:0] led   
);
wire clk_o;
wire locked;
wire ena;
wire wea;
wire [3:0]addra;
wire [15:0]dina;
wire [15:0]douta;

// 时钟ip，仿真用直接连接的方式
clk_div u_clk_div (
	.clk_in1  (clk   ),
	.clk_out1 (clk_o ),
	.locked   (locked)
);
// assign clk_o = clk;

memory_w_r u_memory_w_r (
	clk_o, rst, button, douta, led, ena, wea, addra, dina
);

led_mem u_led_mem(
    .clk(clk_o),
    .ena(ena),
    .wea(wea),
    .addra(addra),
    .dina(dina),
    .douta(douta)
);
endmodule