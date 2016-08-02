// Range reduction module for the Square Root unit
`timescale 1ns/1ps
module Sqrt_range(exp_f,LZD_Sqrt,y_f,f_temp);
input [5:0] exp_f;
input [5:0] LZD_Sqrt;
input [20:0] y_f;
output [20:0] f_temp;
reg [20:0] f_temp;
reg [5:0] exp_f_1;

always@(exp_f or LZD_Sqrt or y_f or exp_f_1)
begin
//Performing Left or Right shift based of the value of exp_f[0]
exp_f_1 <= (exp_f[0])?((LZD_Sqrt-6'b010001) < 6)?((6 - (LZD_Sqrt-6'b010001))>>1):(((LZD_Sqrt-6'b010001) - 5)>>1):((LZD_Sqrt-6'b010001) < 6)?((5 - (LZD_Sqrt-6'b010001))>>1):(((LZD_Sqrt-6'b010001) - 5)>>1);
f_temp <= ((LZD_Sqrt-6'b010001) < 6)?(y_f << exp_f_1):(y_f >> exp_f_1);
end
endmodule 