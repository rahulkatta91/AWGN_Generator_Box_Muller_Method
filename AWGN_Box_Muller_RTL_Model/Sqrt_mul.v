//Multiplication unit of the Square Root unit
`timescale 1ns/1ps
module Sqrt_mul(coeffs_Sqrt,x_f_B,x_f_D0);

input [11:0] coeffs_Sqrt;
input [30:0] x_f_B;
output [19:0] x_f_D0;
reg  [19:0] x_f_D0;

wire [42:0]temp;

//Multiplication of Coefficient c1 with shifted version of e
assign temp = coeffs_Sqrt * x_f_B;

always@(coeffs_Sqrt or x_f_B or temp)
begin
	x_f_D0 <= temp[42:23];	
end
endmodule 
