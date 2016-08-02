//Square Root funtional Unit using polynomial approximation based on Horner's Rule
`timescale 1ns/1ps
module Sqrt(e,f);


input [30:0] e;
output [16:0] f;
reg [16:0] f;

wire [5:0] LZD_Sqrt;
wire [5:0] x_f_A;
wire [20:0] f_temp;
wire [31:0] coeffs_Sqrt1,coeffs_Sqrt2;
wire [5:0] exp_f;
wire [30:0] x_f_1,x_f,x_f_B;
wire [19:0] x_f_D0_1,x_f_D0_2;
wire [20:0] y_f,y_f_1,y_f_2;
wire [19:0] coeffs_Sqrt1_c0,coeffs_Sqrt2_c0;
wire [11:0] coeffs_Sqrt1_c1,coeffs_Sqrt2_c1;

//Module instantiation for Leading Zero Detector, Coefficient values, Multiplication, Addition and Range Reconstruction
LZD LZD_Sqrt1({17'b00000000000000000,e},LZD_Sqrt);
Sqrt1_Coeffs Sqrt1_Coeffs1(x_f_A,coeffs_Sqrt1);
Sqrt2_Coeffs Sqrt2_Coeffs2(x_f_A,coeffs_Sqrt2);
Sqrt_mul Sqrt1_mul(coeffs_Sqrt1_c1,x_f_B,x_f_D0_1);
Sqrt_add Sqrt1_add(coeffs_Sqrt1_c0,x_f_D0_1,y_f_1);
Sqrt_mul Sqrt2_mul(coeffs_Sqrt2_c1,x_f_B,x_f_D0_2);
Sqrt_add Sqrt2_add(coeffs_Sqrt2_c0,x_f_D0_2,y_f_2);
Sqrt_range Range_reconstruction(exp_f,LZD_Sqrt,y_f,f_temp);

//Assignment of Coefficient values to independent vectors
assign coeffs_Sqrt1_c1 = coeffs_Sqrt1[31:20];
assign coeffs_Sqrt1_c0 = coeffs_Sqrt1[19:0];
assign coeffs_Sqrt2_c1 = coeffs_Sqrt2[31:20];
assign coeffs_Sqrt2_c0 = coeffs_Sqrt2[19:0];

assign y_f = exp_f[0]?y_f_2:y_f_1;
assign exp_f = 5 - (LZD_Sqrt-6'b010001);
assign x_f_1 = ((LZD_Sqrt-6'b010001) < 6)?(e>>(5 - (LZD_Sqrt-6'b010001))):(e<<((LZD_Sqrt-6'b010001) - 5));
assign x_f = exp_f[0]?(x_f_1 >>1):x_f_1;
assign x_f_A = x_f[30:25];	//Coefficient retrival
assign x_f_B = (x_f<<6);	//Shifted version of x_f

always@(f_temp)
begin
	f <= f_temp[20:4];
end

endmodule 