//Square Root funtional Unit using polynomial approximation based on Horner's Rule
module Sqrt(clk,e,coeffs_Sqrt1_in,coeffs_Sqrt2_in,LZD_Sqrt,x_f_A,f);

input clk;
input [30:0] e;
input [31:0]coeffs_Sqrt1_in,coeffs_Sqrt2_in;
input [5:0] LZD_Sqrt;
output [5:0] x_f_A;
output [16:0] f;
reg [5:0] x_f_A;
reg [16:0] f;
reg [31:0] coeffs_Sqrt1,coeffs_Sqrt2;
reg [5:0] exp_f,exp_f_1;
reg [30:0] x_f_1,x_f,x_f_B;
reg [36:0] x_f_D0;
reg [20:0] y_f;

always@(clk)
begin
	exp_f <= 5 - LZD_Sqrt;					//Range reduction
	x_f_1 <= (e>>exp_f);
	
	x_f <= exp_f[0]?(x_f_1 >>1):x_f_1;			//Based of odd or even value of exp_f signal, we choose from either Sqrt1 or Sqrt2 tables

	x_f_A <= x_f[30:25];					//First 6 bits used for indexing to the Coefficient tables
	x_f_B <= (x_f<<6);					//Input to the polynomial arithmetic
	
	if(exp_f[0])
	begin
	x_f_D0 <= (coeffs_Sqrt1[31:20] * x_f_B);
	y_f <= x_f_D0[36:17] + coeffs_Sqrt1[19:0];
	
	exp_f_1 <= ((exp_f + 1'b1) >> 1);
	f <= (y_f[20:4] << exp_f_1);
	end
	
	else
	begin
	x_f_D0 <= (coeffs_Sqrt2[31:20] * x_f_B);
	y_f <= x_f_D0[36:17] + coeffs_Sqrt2[19:0];
	
	exp_f_1 <= ((exp_f + 1'b1) >> 1);			//Range reconstruction
	f <= (y_f[20:4] << exp_f_1);
	end
end

always@(clk)
begin
	coeffs_Sqrt1 <= coeffs_Sqrt1_in;			//Retrieving Coefficient values from tables
	coeffs_Sqrt2 <= coeffs_Sqrt2_in;
end
endmodule 