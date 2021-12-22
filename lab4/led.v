`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/23 20:44:32
// Design Name: 
// Module Name: led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led(
    input clk,
    input rst,
    input button, 
    output reg [7:0]led_en,
    output reg [7:0]led_value
    );
    // 第一个分频，2ms
    reg [17:0]cnt1;
    always@(posedge clk or posedge rst) begin
        if(rst)
            cnt1 <= 'b0;
        else if(button)
            cnt1 <= 'b0;
        else if(cnt1 == 200000)//200000
            cnt1 <= 'b0;
        else
            cnt1 <= cnt1+1'b1;
     end
    // 第二个分频
    reg [26:0]cnt2;
    always@(posedge clk or posedge rst) begin
        if(rst)
            cnt2 <= 'b0;
        else if(button)
            cnt2 <= 'b0;
        else if(cnt1 == 100000000)//100000000
            cnt2 <= 'b0;
        else
            cnt2 <= cnt2+1'b1;
     end

    // flag信号判断是否正常运行
    reg flag;
    always@(posedge clk or posedge rst) begin
        if(rst)
            flag <= 'b0;
        else if(button)
            flag <= 'b1;
        else;
     end
    
    // led使能部分
    always@(posedge clk or posedge rst) begin
        if(rst)
            led_en <= 8'b1111_1111;
        else if(button)
            led_en <= 8'b1111_1111;
        else if(!flag)
            led_en <= 8'b1111_1111;
        else if(!led_en)
            led_en <= 8'b1111_1110;
        else if(cnt1 == 200000)
            led_en <= {led_en[6:0],led_en[7]};
        else;
    end

    // 倒计时部分
    reg [3:0]time_now;
    reg stats;  // 为0表示减少，为1表示增加
    always@(posedge clk) begin
        if(!flag)
            stats <= 'b0;
        else if(flag && !stats && time_now == 0)
            stats <= 'b1;
        else if(flag && stats && time_now == 10)
            stats <= 'b0;
        else;
    end
    always@(posedge clk or posedge rst) begin
        if(rst)
            time_now <= 4'hf;
        else if(button)
            time_now <= 4'hf;
        else if(!flag)
            time_now <= 4'hf;
        else if(time_now == 15)
            time_now <= 4'd10;
        else if(stats && cnt2 == 100000000)
            time_now <= time_now+1'b1;
        else if(!stats && cnt2 == 100000000)
            time_now <= time_now-1'b1;
        else;
    end

    // led显示部分
    reg [7:0]value7;// 倒计时
    reg [7:0]value6;
    reg [7:0]value5 = 8'b1001_1111;// 年级
    reg [7:0]value4 = 8'b0000_1001;
    reg [7:0]value3 = 8'b0000_0011;// 班级
    reg [7:0]value2 = 8'b1001_1001;
    reg [7:0]value1 = 8'b0010_0101;// 学号后两位
    reg [7:0]value0 = 8'b0010_0101;

    always@(*) begin
        if(rst)
            value6 = 8'b1111_1111;
        else
            case(time_now)
            4'h0a:
                value6 = 8'b0000_0011;
            4'h00:
                value6 = 8'b0000_0011;
            4'h01:
                value6 = 8'b1001_1111;
            4'h02:
                value6 = 8'b0010_0101;
            4'h03:
                value6 = 8'b0000_1101;
            4'h04:
                value6 = 8'b1001_1001;
            4'h05:
                value6 = 8'b0100_1001;
            4'h06:
                value6 = 8'b0100_0001;
            4'h07:
                value6 = 8'b0001_1111;
            4'h08:
                value6 = 8'b0000_0001;
            4'h09:
                value6 = 8'b0000_1001;
            endcase
    end
    always@(*) begin
        if(rst)
            value7 = 8'b1111_1111;
        else
            case(time_now)
            4'h0a:
                value7 = 8'b1001_1111;
            default:
                value7 = 8'b0000_0011;
            endcase
    end
    // 总的赋值
    always@(*) begin
        if(rst)
            led_value = 8'b1111_1111;
        else
            case(led_en)
                8'b1111_1110: led_value = value0;
                8'b1111_1101: led_value = value1;
                8'b1111_1011: led_value = value2;
                8'b1111_0111: led_value = value3;
                8'b1110_1111: led_value = value4;
                8'b1101_1111: led_value = value5;
                8'b1011_1111: led_value = value6;
                8'b0111_1111: led_value = value7;
            endcase
    end

endmodule
