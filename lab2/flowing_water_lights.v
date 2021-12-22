`timescale 1ns/1ps
module flowing_water_lights(
    input clk,
    input rst,
    input button,
    output reg [7:0]led
);
wire clk_o;
divider d(clk, rst, clk_o);
always @(posedge clk_o or posedge rst) begin
    if(rst) begin
      led <= 8'h0;
    end
    else begin
      if(button) begin
        // 复位
        led <= 8'b0;
      end
      else if(!led) begin
        led <= 8'b1;
      end
      else begin
        led <= {led[6:0],led[7]};
      end
    end
end
endmodule
