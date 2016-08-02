//Multiplication unit of the Log unit
`timescale 1ns/1ps
module Log_mul2(y_e_D1,x_e_B,y_e_D2);

input [48:0] x_e_B;
input [22:0] y_e_D1;
output [29:0] y_e_D2;
reg  [29:0] y_e_D2;

wire [71:0]temp;

//Multiplication of addition module output with input signal x_e_B
assign temp = y_e_D1 * x_e_B;

always@(y_e_D1 or x_e_B or temp)
begin
	y_e_D2 <= temp[71:42];	
end
endmodule 