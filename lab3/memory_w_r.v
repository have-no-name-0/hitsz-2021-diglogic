`timescale 1ns / 1ps
// 首先我们要有一个
module memory_w_r(
    input clk,
    input rst,
    input button,
    input [15:0]douta,
    output reg [15:0]led,
    output reg ena,                        // 模块调用部分
    output reg wea,
    output reg [3:0]addra,
    output reg [15:0]dina
);
reg [23:0]cnt;                  // 计数器部分
reg [23:0]cnt_max = 'd9999999;  //

// reg [15:0]get;               // 暂存得到的数据
reg flag;                       // 判断是否有效
/*
  这部分，我先赋值addr，同时拉高ena和wea，就能写入了
  这时候不需要管addr和ena，在下一个周期，拉低wea，进行读取，再下一个周期拉低ena，同时写入get
*/

always@(posedge clk or posedge rst) begin
  // 分频部分，10M -> 1
  if(button || rst)
    cnt <= 'b0;
  else if(cnt == cnt_max)
    cnt <= 'b0;
  else
    cnt <= cnt+1'b1;
end

always@(posedge clk or posedge rst) begin
  // flag
  if(rst)
    flag <= 'b0;
  else if(button)
    flag <= 'b1;
  else;
end

always@(posedge clk or posedge rst) begin
// 地址部分
  if(!flag || rst)
    addra <= 'hf;
  else if(button)
    addra <= 'hf;
  else if(cnt == cnt_max)
    addra <= addra+1;
  else;
end

always@(posedge clk or posedge rst) begin
// 写入部分
  if(!flag || rst)
    dina <= 'h0;
  else if(button)
    dina <= 'h0;
  else if(cnt == cnt_max)
    dina <= {dina[14:0], 1'b1};
  else;
end

always@(posedge clk or posedge rst) begin
// 使能部分
  if(!flag || rst)
    ena <= 'b0;
  else if(button)
    ena <= 'b0;
  else if(cnt == cnt_max)
    ena <= 'b1;
  else if(!wea && ena)
  begin
    ena <= 'b0;
  end
  else;
end

always@(posedge clk or posedge rst) begin
// 写使能部分
  if(!flag || rst)
    wea <= 'b0;
  else if(button)
    wea <= 'b0;
  else if(cnt == cnt_max)
    wea <= 'b1;
  else if(wea)
    wea <= 'b0;
  else;
end

always@(posedge clk or posedge rst) begin
  // led部分
  if(!flag || rst)
    led <= 'b0;
  else if(button)
    led <= 'b0;
  else if(!wea && ena)
    led <= douta;
  else;
end
endmodule