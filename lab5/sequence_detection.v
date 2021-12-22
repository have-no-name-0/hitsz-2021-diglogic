module sequence_detection (
    input  wire       clk   ,
	input  wire       rst   ,
	input  wire       button,
	input  wire [7:0] switch,
	output reg        led
);
/*
	状态机，三段式
	第一部分是确定输入
	第二部分是状态变化
	第三部分是输出
	是moore的状态机
*/
reg [2:0]cnt = 'b0;	// 计数器，判断数到哪个位置
reg flag = 1'b0;	// 判断是否开始计数
wire rstn = ~rst;	// 复位取反
reg [2:0]  status;	// 状态

// flag信号
always @(posedge clk or negedge rstn) begin
	if(!rstn)
		flag <= 1'b0;
	else if(button)
		flag <= 1'b1;
	else;
end

// 确定输入
always @(posedge clk or negedge rstn) begin
	if(!rstn || button)
		cnt <= 'd7;
	else if(!flag)
		cnt <= 'd7;
	else if(cnt)
		cnt <= cnt - 1'b1;
	else;
end

// 状态转换
always @(posedge clk or negedge rstn) begin
	if(!rstn||button)
		status <= 'b0;
	else if(!flag)
		status <= 'b0;
	else begin
		// 按照状态转移图来
		case({status, switch[cnt]})
			// S0
			4'b0000: status <= 3'b000;
			4'b0001: status <= 3'b001;
			// S1
			4'b0010: status <= 3'b010;
			4'b0011: status <= 3'b001;
			// S2
			4'b0100: status <= 3'b011;
			4'b0101: status <= 3'b001;
			// S3
			4'b0110: status <= 3'b000;
			4'b0111: status <= 3'b100;
			// S4
			4'b1000: status <= 3'b101;
			4'b1001: status <= 3'b001;
			// S5
			4'b1010: status <= 3'b011;
			4'b1011: status <= 3'b001;
			default;
		endcase
	end
end

always @(posedge clk or negedge rstn) begin
	if(!rstn || button)
		led <= 1'b0;
	else if(!flag)
		led <= 1'b0;
	else if(status == 3'd5)
		led <= 1'b1;
	else;
end

endmodule