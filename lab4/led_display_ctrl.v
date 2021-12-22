module led_display_ctrl (
    input  wire       clk   ,
	input  wire       rst   ,
	input  wire       button,
	output wire [7:0] led_en,
	output wire       led_ca,
	output wire       led_cb,
    output wire       led_cc,
	output wire       led_cd,
	output wire       led_ce,
	output wire       led_cf,
	output wire       led_cg,
	output wire       led_dp 
);

led u_led(
	.clk(clk),
	.rst(rst),
	.button(button),
	.led_en(led_en),
	.led_value({led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp})
);

endmodule