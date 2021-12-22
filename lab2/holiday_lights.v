module holiday_lights (
    input  wire        clk   ,
	input  wire        rst   ,
	input  wire        button,
    input  wire [ 2:0] switch,
	output reg  [15:0] led
);
wire clk_o;
reg [3:0]stats = 4'b1000;
reg flag = 1'b0;
//divider d(rst, clk, clk_o);
always @(posedge clk or posedge rst) begin
    if(rst) begin
      led <= 16'b1111_1111_1111_1111;
	  stats <= 4'b0;
	  flag <= 1'b0;
    end
    else begin
        if(button) begin
        	// 复位
			case(switch)
				3'b000 : led <= 16'b1;
				3'b001 : led <= 16'b11;
				3'b010 : led <= 16'b111;
				3'b011 : led <= 16'b1111;
				3'b100 : led <= 16'b11111;
				3'b101 : led <= 16'b111111;
				3'b110 : led <= 16'b1111111;
				3'b111 : led <= 16'b11111111;
			endcase
			flag <= 1'b1;
        end
	    else if(flag) begin
			if(stats!={1'b0,switch}) begin
				case(switch)
					3'b000 : led <= 16'b1;
					3'b001 : led <= 16'b11;
					3'b010 : led <= 16'b111;
					3'b011 : led <= 16'b1111;
					3'b100 : led <= 16'b11111;
					3'b101 : led <= 16'b111111;
					3'b110 : led <= 16'b1111111;
					3'b111 : led <= 16'b11111111;
				endcase
				stats <= {1'b0,switch};
			end
			else
				led <= {led[14:0],led[15]};
		end
		else;
	end
end

endmodule