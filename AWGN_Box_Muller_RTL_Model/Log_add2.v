//Addition module of the Log unit
`timescale 1ns/1ps
module Log_add2(coeffs_Log_in,y_e_D2,y_e);

input [29:0] coeffs_Log_in,y_e_D2;
output [30:0] y_e;
reg  [30:0] y_e;

wire [30:0]temp;

//Addition of Coefficient c0 with output of multiplication module
assign temp = coeffs_Log_in + y_e_D2;

always@(coeffs_Log_in or y_e_D2 or temp)
begin
	y_e <= temp;	
end
endmodule 