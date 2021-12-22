`timescale 1ns / 1ps

module xiaodou(
    input clk,				//时钟信号
    input rst,
    input button,			//输入的按键开关信号
    output reg button_pos	//输出的使能信号
    );
    reg t  = 1'b0;			//刚开始变化的信号
    reg t2 = 1'b0;			//15ms之后的信号
    reg clk_o;
    reg judge = 1'b0;		//判断条件，控制计数器的开始
    reg [3:0]cou=4'b0000;	//计数器
    
    reg [16:0] cnt=0;
    always@(posedge clk) begin
    if(cnt == 99999)
        cnt <= 'b000;
    else 
        cnt <= cnt + 1'b1;
    
    if(cnt <= 49999)
        clk_o <= 1'b1;
    else 
        clk_o <= 1'b0;
    end
        
    always@(posedge clk_o)
    begin
        if(judge)					//t已经读入成功，需要计时
        begin
            if(cou == 4'b1111)		//计时结束
            begin
                cou <= 4'b0000;		//计数器清零
                t2 = button;
                judge <= 1'b0;		//判断条件改为无效
                if(t2 == t)
                    button_pos <= button;//确实变化了
                else;				//保持
            end
            else					//计时
                cou <= cou+1'b1;
        end
        
        else if(button != t)		//s发生变化
        begin
            judge <= 1'b1;			//开始计时
            t = button;				//第一个寄存器读入
        end
        
        else
			button_pos = button;	//什么都没有改变，不需要启动模块
    end
    
endmodule
