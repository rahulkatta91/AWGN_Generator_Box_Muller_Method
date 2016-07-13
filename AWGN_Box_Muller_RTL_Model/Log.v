//Log funtional Unit using polynomial approximation based on Horner's Rule
module Log(clk,u0,coeffs_Log_in,LZD_Log,x_e_A,e);

input clk;
input [47:0] u0;
input [5:0] LZD_Log;
input [64:0] coeffs_Log_in;
output [7:0] x_e_A;
output [30:0] e;
reg [7:0] x_e_A;
reg [5:0] exp_e;
reg [30:0] e;
reg [64:0] coeffs_Log;
reg [48:0] x_e,x_e_B;
reg [61:0] y_e_D0;
reg [22:0] y_e_D1;
reg [43:0] y_e_D2;
reg [29:0] y_e;
reg [37:0] e_1,e_temp;

parameter ln2 = 32'b10110011011011011000100000110101;

always@(clk)
begin
	exp_e <= LZD_Log + 1'b1;
	x_e <= (u0 << exp_e);					//Range reduction
	
	x_e_A <= x_e[48:41];					//First 8 bits used for indexing to the Coefficient tables
	x_e_B <= (x_e<<8);					//Input to the polynomial arithmetic

	y_e_D0 <= (coeffs_Log[64:52] * x_e_B);
	y_e_D1 <= y_e_D0[61:40] + coeffs_Log[51:30];
	y_e_D2 <= (y_e_D1 * x_e_B);
	y_e <= y_e_D2[43:14] + coeffs_Log[29:0];		//Output of the polynomial arithmetic

	e_1 <= ln2 * exp_e;
	
	e_temp <= (e_1 - y_e) << 1;				//Range reconstruction
	e <= e_temp[37:7];
end

always@(clk)
begin
	coeffs_Log <= coeffs_Log_in;				//Retrieving Coefficient values from tables
end
endmodule
