//Addition module of the Log unit
`timescale 1ns/1ps
module Log_add1(coeffs_Log_in,y_e_D0,y_e_D1);

input [21:0] coeffs_Log_in,y_e_D0;
output [22:0] y_e_D1;
reg  [22:0] y_e_D1;

wire [22:0]temp;

//Addition of Coefficient c1 with output of multiplication module
assign temp = coeffs_Log_in + y_e_D0;

always@(coeffs_Log_in or y_e_D0 or temp)
begin
	y_e_D1 <= temp;	
end
endmodule 