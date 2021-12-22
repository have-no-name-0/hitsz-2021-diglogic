`timescale 1ns / 1ps
/*
    计算模块
    输入20mhz的时钟，复位信号
    输入button
    输入num1、num2、func
    输出计算的结果
*/
module calculator_hex(
    input clk,
    input rst,
    input button,
    input [7:0]num1,
    input [7:0]num2,
    input [2:0]func,
    output reg [31:0]cal_result
    );

    // flag标志位
    reg flag;
    always @(posedge clk or posedge rst) begin
        if(rst)
            flag <= 1'b0;
        else if(button)
            flag <= 1'b1;
        else;
    end

    // 我们的button只能一个周期有效，所以定义一个reg类型，晚一个周期
    reg button_pos;
    always @(posedge clk or posedge rst) begin
        if(rst)
            button_pos <= 1'b0;
        else
            button_pos <= button;
    end

    // 计算部分
    always @(negedge clk or posedge rst) begin
        if(rst)
            cal_result <= 32'b0;
        else if(button&&!button_pos)
        begin
            // 说明是第一个周期，我们来一手计算
            case({flag,func})
                4'b0000: cal_result <= num1 + num2;
                4'b0001: cal_result <= num1 - num2;
                4'b0010: cal_result <= num1 * num2;
                4'b0011: cal_result <= num1 / num2;
                4'b0100: cal_result <= num1 % num2;
                4'b0101: cal_result <= num1 * num1;
                4'b1000: cal_result <= cal_result + num2;
                4'b1001: cal_result <= cal_result - num2;
                4'b1010: cal_result <= cal_result * num2;
                4'b1011: cal_result <= cal_result / num2;
                4'b1100: cal_result <= cal_result % num2;
                4'b1101: cal_result <= cal_result * cal_result;
            endcase
        end
        else;
    end
endmodule
