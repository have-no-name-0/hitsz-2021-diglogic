`timescale 1ns / 1ps
module calculator_display(
    input clk,
    input rst,
    input button,
    input [31:0]cal_result,
    output reg [7:0]led_en,
    output reg [7:0]led
    );

    // flag部分，需要一个变量来控制是否工作
    reg flag;
    always @(posedge clk or posedge rst) begin
        if(rst)
            flag <= 1'b0;
        else if(button)
            flag <= 1'b1;
        else;
    end

    // 计数器部分
    reg [15:0]counter;
    always @(posedge clk or posedge rst) begin
        if(rst)
            counter <= 'b0;
        else if(flag&&counter!=40000)
        // else if(flag&&counter!=2)
            counter <= counter +1'b1;
        else if(flag&&counter==40000)
        // else if(flag&&counter==2)
            counter <= 'b0;
    end

    // led_en部分
    always @(posedge clk or posedge rst) begin
        if(rst)
            led_en <= 8'b1111_1111;
        else if(counter==40000&&led_en==8'b1111_1111)
        // else if(counter==2&&led_en==8'b1111_1111)
            led_en <= 8'b1111_1110;
        else if(counter==40000&&led_en)
        // else if(counter==2&&led_en)
            led_en <= {led_en[6:0],led_en[7]};
        else;
    end
    
    // 显示内容，这部分我准备拆成8个数字来进行操作
    reg [7:0] num0_show; // 最左边的
    always @(*) begin
        if(rst)
            num0_show = 8'b1111_1111;
        else if(flag)
            case(cal_result[3:0])
                4'b0000: num0_show = 8'b0000_0011;
                4'b0001: num0_show = 8'b1001_1111;
                4'b0010: num0_show = 8'b0010_0101;
                4'b0011: num0_show = 8'b0000_1101;
                4'b0100: num0_show = 8'b1001_1001;
                4'b0101: num0_show = 8'b0100_1001;
                4'b0110: num0_show = 8'b0100_0001;
                4'b0111: num0_show = 8'b0001_1111;
                4'b1000: num0_show = 8'b0000_0001;
                4'b1001: num0_show = 8'b0000_1001;
                4'b1010: num0_show = 8'b0001_0001;
                4'b1011: num0_show = 8'b1100_0001;
                4'b1100: num0_show = 8'b1110_0101;
                4'b1101: num0_show = 8'b1000_0101;
                4'b1110: num0_show = 8'b0110_0001;
                4'b1111: num0_show = 8'b0111_0001;
            endcase
    end
    reg [7:0] num1_show;
    always @(*) begin
        if(rst)
            num1_show = 8'b1111_1111;
        else if(flag)
            case(cal_result[7:4])
                4'b0000: num1_show = 8'b0000_0011;
                4'b0001: num1_show = 8'b1001_1111;
                4'b0010: num1_show = 8'b0010_0101;
                4'b0011: num1_show = 8'b0000_1101;
                4'b0100: num1_show = 8'b1001_1001;
                4'b0101: num1_show = 8'b0100_1001;
                4'b0110: num1_show = 8'b0100_0001;
                4'b0111: num1_show = 8'b0001_1111;
                4'b1000: num1_show = 8'b0000_0001;
                4'b1001: num1_show = 8'b0000_1001;
                4'b1010: num1_show = 8'b0001_0001;
                4'b1011: num1_show = 8'b1100_0001;
                4'b1100: num1_show = 8'b1110_0101;
                4'b1101: num1_show = 8'b1000_0101;
                4'b1110: num1_show = 8'b0110_0001;
                4'b1111: num1_show = 8'b0111_0001;
            endcase
    end
    reg [7:0] num2_show;
    always @(*) begin
        if(rst)
            num2_show = 8'b1111_1111;
        else if(flag)
            case(cal_result[11:8])
                4'b0000: num2_show = 8'b0000_0011;
                4'b0001: num2_show = 8'b1001_1111;
                4'b0010: num2_show = 8'b0010_0101;
                4'b0011: num2_show = 8'b0000_1101;
                4'b0100: num2_show = 8'b1001_1001;
                4'b0101: num2_show = 8'b0100_1001;
                4'b0110: num2_show = 8'b0100_0001;
                4'b0111: num2_show = 8'b0001_1111;
                4'b1000: num2_show = 8'b0000_0001;
                4'b1001: num2_show = 8'b0000_1001;
                4'b1010: num2_show = 8'b0001_0001;
                4'b1011: num2_show = 8'b1100_0001;
                4'b1100: num2_show = 8'b1110_0101;
                4'b1101: num2_show = 8'b1000_0101;
                4'b1110: num2_show = 8'b0110_0001;
                4'b1111: num2_show = 8'b0111_0001;
            endcase
    end
    reg [7:0] num3_show;
    always @(*) begin
        if(rst)
            num3_show = 8'b1111_1111;
        else if(flag)
            case(cal_result[15:12])
                4'b0000: num3_show = 8'b0000_0011;
                4'b0001: num3_show = 8'b1001_1111;
                4'b0010: num3_show = 8'b0010_0101;
                4'b0011: num3_show = 8'b0000_1101;
                4'b0100: num3_show = 8'b1001_1001;
                4'b0101: num3_show = 8'b0100_1001;
                4'b0110: num3_show = 8'b0100_0001;
                4'b0111: num3_show = 8'b0001_1111;
                4'b1000: num3_show = 8'b0000_0001;
                4'b1001: num3_show = 8'b0000_1001;
                4'b1010: num3_show = 8'b0001_0001;
                4'b1011: num3_show = 8'b1100_0001;
                4'b1100: num3_show = 8'b1110_0101;
                4'b1101: num3_show = 8'b1000_0101;
                4'b1110: num3_show = 8'b0110_0001;
                4'b1111: num3_show = 8'b0111_0001;
            endcase
    end
    reg [7:0] num4_show;
    always @(*) begin
        if(rst)
            num4_show = 8'b1111_1111;
        else if(flag)
            case(cal_result[19:16])
                4'b0000: num4_show = 8'b0000_0011;
                4'b0001: num4_show = 8'b1001_1111;
                4'b0010: num4_show = 8'b0010_0101;
                4'b0011: num4_show = 8'b0000_1101;
                4'b0100: num4_show = 8'b1001_1001;
                4'b0101: num4_show = 8'b0100_1001;
                4'b0110: num4_show = 8'b0100_0001;
                4'b0111: num4_show = 8'b0001_1111;
                4'b1000: num4_show = 8'b0000_0001;
                4'b1001: num4_show = 8'b0000_1001;
                4'b1010: num4_show = 8'b0001_0001;
                4'b1011: num4_show = 8'b1100_0001;
                4'b1100: num4_show = 8'b1110_0101;
                4'b1101: num4_show = 8'b1000_0101;
                4'b1110: num4_show = 8'b0110_0001;
                4'b1111: num4_show = 8'b0111_0001;
            endcase
    end
    reg [7:0] num5_show;
    always @(*) begin
        if(rst)
            num5_show = 8'b1111_1111;
        else if(flag)
            case(cal_result[23:20])
                4'b0000: num5_show = 8'b0000_0011;
                4'b0001: num5_show = 8'b1001_1111;
                4'b0010: num5_show = 8'b0010_0101;
                4'b0011: num5_show = 8'b0000_1101;
                4'b0100: num5_show = 8'b1001_1001;
                4'b0101: num5_show = 8'b0100_1001;
                4'b0110: num5_show = 8'b0100_0001;
                4'b0111: num5_show = 8'b0001_1111;
                4'b1000: num5_show = 8'b0000_0001;
                4'b1001: num5_show = 8'b0000_1001;
                4'b1010: num5_show = 8'b0001_0001;
                4'b1011: num5_show = 8'b1100_0001;
                4'b1100: num5_show = 8'b1110_0101;
                4'b1101: num5_show = 8'b1000_0101;
                4'b1110: num5_show = 8'b0110_0001;
                4'b1111: num5_show = 8'b0111_0001;
            endcase
    end
    reg [7:0] num6_show;
    always @(*) begin
        if(rst)
            num6_show = 8'b1111_1111;
        else if(flag)
            case(cal_result[27:24])
                4'b0000: num6_show = 8'b0000_0011;
                4'b0001: num6_show = 8'b1001_1111;
                4'b0010: num6_show = 8'b0010_0101;
                4'b0011: num6_show = 8'b0000_1101;
                4'b0100: num6_show = 8'b1001_1001;
                4'b0101: num6_show = 8'b0100_1001;
                4'b0110: num6_show = 8'b0100_0001;
                4'b0111: num6_show = 8'b0001_1111;
                4'b1000: num6_show = 8'b0000_0001;
                4'b1001: num6_show = 8'b0000_1001;
                4'b1010: num6_show = 8'b0001_0001;
                4'b1011: num6_show = 8'b1100_0001;
                4'b1100: num6_show = 8'b1110_0101;
                4'b1101: num6_show = 8'b1000_0101;
                4'b1110: num6_show = 8'b0110_0001;
                4'b1111: num6_show = 8'b0111_0001;
            endcase
    end
    reg [7:0] num7_show;
    always @(*) begin
        if(rst)
            num7_show = 8'b1111_1111;
        else if(flag)
            case(cal_result[31:28])
                4'b0000: num7_show = 8'b0000_0011;
                4'b0001: num7_show = 8'b1001_1111;
                4'b0010: num7_show = 8'b0010_0101;
                4'b0011: num7_show = 8'b0000_1101;
                4'b0100: num7_show = 8'b1001_1001;
                4'b0101: num7_show = 8'b0100_1001;
                4'b0110: num7_show = 8'b0100_0001;
                4'b0111: num7_show = 8'b0001_1111;
                4'b1000: num7_show = 8'b0000_0001;
                4'b1001: num7_show = 8'b0000_1001;
                4'b1010: num7_show = 8'b0001_0001;
                4'b1011: num7_show = 8'b1100_0001;
                4'b1100: num7_show = 8'b1110_0101;
                4'b1101: num7_show = 8'b1000_0101;
                4'b1110: num7_show = 8'b0110_0001;
                4'b1111: num7_show = 8'b0111_0001;
            endcase
    end

    // led部分
    always @(posedge clk or posedge rst) begin
        if(rst)
            led <= 8'b11111111;
        else if(flag)
            case(led_en)
                8'b1111_1110: led <= num0_show;
                8'b1111_1101: led <= num1_show;
                8'b1111_1011: led <= num2_show;
                8'b1111_0111: led <= num3_show;
                8'b1110_1111: led <= num4_show;
                8'b1101_1111: led <= num5_show;
                8'b1011_1111: led <= num6_show;
                8'b0111_1111: led <= num7_show;
            endcase
        else;
    end
endmodule
