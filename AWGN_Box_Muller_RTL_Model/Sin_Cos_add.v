//Addition module of the Sin/Cos unit
`timescale 1ns/1ps
module Sin_Cos_add(coeffs_c0,x_g_D0,x_g_D1);

input [18:0] coeffs_c0,x_g_D0;
output [19:0] x_g_D1;
reg  [19:0] x_g_D1;

wire [19:0]temp;

//Adding Coefficient c0 with the result obtained from the multipilcation module
assign temp = coeffs_c0 + x_g_D0;

always@(coeffs_c0 or x_g_D0 or temp)
begin
	x_g_D1 <= temp;	
end
endmodule 