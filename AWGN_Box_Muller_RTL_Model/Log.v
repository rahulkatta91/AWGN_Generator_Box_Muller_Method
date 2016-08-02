//Log funtional Unit using polynomial approximation based on Horner's Rule
`timescale 1ns/1ps
module Log(u0,e);


input [47:0] u0;
output [30:0] e;
reg [30:0] e;

reg [30:0] y_e_reg;

wire [5:0] LZD_Log;
wire [7:0] x_e_A;
wire [64:0] coeffs_Log_in;
wire [48:0] x_e;
wire [48:0] x_e_B;
wire [21:0] y_e_D0;
wire [22:0] y_e_D1;
wire [29:0] y_e_D2;
wire [30:0] y_e;
wire [37:0] e_1_temp;
wire [30:0] e_1;
wire [30:0] e_temp;
wire [12:0] coeff_c2;
wire [21:0] coeff_c1;
wire [29:0] coeff_c0;

parameter ln2 = 32'b01001101000100000100110101000010;

//Module instantiation for Leading Zero Detector, Coefficient Retrival, Multiplication and Addition Modules
LZD LZD_Log1(u0,LZD_Log);
Log_Coeffs Log_Coeffs1(x_e_A,coeffs_Log_in);
Log_mul1 lmul1(coeff_c2,x_e_B,y_e_D0);
Log_add1 ladd1(coeff_c1,y_e_D0,y_e_D1);
Log_mul2 lmul2(y_e_D1,x_e_B,y_e_D2);
Log_add2 ladd2(coeff_c0,y_e_D2,y_e);//Output of the polynomial arithmetic

assign x_e = (u0 << (LZD_Log + 1'b1));
assign x_e_A = x_e[48:41];	//First 8 bits used for indexing to the Coefficient tables
assign x_e_B = (x_e<<8);	//Input to the polynomial arithmetic

//Assignment of coefficient values to variables
assign coeff_c2 = coeffs_Log_in[64:52];
assign coeff_c1 = coeffs_Log_in[51:30];
assign coeff_c0 = coeffs_Log_in[29:0];

//Range Reconstruction
assign e_1_temp = ln2 * (LZD_Log + 1'b1);
assign e_1 = e_1_temp [37:7];
assign e_temp = (e_1 - y_e) << 1;

always@(y_e)
begin	
	y_e_reg <= y_e;
	e <= e_temp;
end

endmodule
