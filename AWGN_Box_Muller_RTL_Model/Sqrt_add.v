//Addition module of the Square Root unit
`timescale 1ns/1ps
module Sqrt_add(coeffs_Sqrt,x_f_D0,y_f);

input [19:0] coeffs_Sqrt;
input [19:0] x_f_D0;
output [20:0] y_f;
reg  [20:0] y_f;

wire [20:0]temp;

//Adding Coefficient c0 with the result obtained from the multipilcation module
assign temp = coeffs_Sqrt + x_f_D0;

always@(coeffs_Sqrt or x_f_D0 or temp)
begin
	y_f <= temp;	
end
endmodule 