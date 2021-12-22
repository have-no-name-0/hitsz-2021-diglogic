`timescale 1ns / 1ps
/*船新版本的消抖*/
module xiaodou(
    input clk, 
    input rst, 
    input button,
    output reg button_pos
    );

    // 初次变化记录的数据
    reg status1;

    // 计时，15ms
    reg [18:0]cnt;
    always @(posedge clk or posedge rst) begin
        if(rst)
            cnt <= 'b0;
        else if(status1!=button && !cnt)
            cnt <= 'b1;
        else if(cnt == 100000)
            cnt <= 'b0;
        else if(cnt)
            cnt <= cnt+1'b1;
    end
    
    // 记录两次的数据
    always @(posedge clk or negedge rst) begin
        if(rst)
            status1 <= 1'b0;
        else if(button!=status1 && !cnt)
            // 第一次出现不一样
            status1 <= button;
        else;
    end

    always @(posedge clk or posedge rst) begin
        if(rst)
            button_pos <= 1'b0;
        else if(cnt==100000 && status1==button)
            button_pos <= button;
        else;
    end

endmodule
