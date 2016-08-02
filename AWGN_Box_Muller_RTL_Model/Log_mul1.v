//Multiplication unit of the Log unit
`timescale 1ns/1ps
module Log_mul1(coeffs_Log_in,x_e_B,y_e_D0);

input [12:0] coeffs_Log_in;
input [48:0] x_e_B;
output [21:0] y_e_D0;
reg  [21:0] y_e_D0;

wire [61:0]temp;

//Multiplication of Coefficient c2 with shifted version of u0
assign temp = coeffs_Log_in * x_e_B;

always@(coeffs_Log_in or x_e_B or temp)
begin
	y_e_D0 <= temp[61:40];	
end
endmodule 