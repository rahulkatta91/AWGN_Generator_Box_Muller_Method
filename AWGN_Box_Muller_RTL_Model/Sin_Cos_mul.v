//Multiplication unit of the Sin/Cos unit
`timescale 1ns/1ps
module Sin_Cos_mul(coeffs_c1,x_g_B,x_g_D0);

input [11:0] coeffs_c1;
input [13:0] x_g_B;
output [18:0] x_g_D0;
reg  [18:0] x_g_D0;

wire [25:0]temp;

//Multiplication of Coefficient c1 with shifted version of u1
assign temp = coeffs_c1 * x_g_B;

always@(coeffs_c1 or x_g_B or temp)
begin
	x_g_D0 <= temp[25:7];	
end
endmodule 
