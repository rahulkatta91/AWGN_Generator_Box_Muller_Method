//Main module used for all module instantiations

module Main(clk, reset,urng_seed1,urng_seed2,urng_seed3,urng_seed4,urng_seed5,urng_seed6,x0,x1,g0_final,g1_final,e_final,f_final,u0,u1);
input clk,reset;
input [31:0] urng_seed1,urng_seed2,urng_seed3,urng_seed4,urng_seed5,urng_seed6;

output [15:0] x0,x1;
output [15:0]g0_final,g1_final;
output [16:0]f_final;
output [30:0]e_final;
output [15:0] u1;
output [47:0] u0;

reg [15:0]g0_final,g1_final;
reg [16:0]f_final;
reg [30:0]e_final;
reg [15:0] x0,x1;
reg [15:0] u1;
reg [47:0] u0;

reg [32:0] temp0,temp1;

wire [31:0] a,b;
wire [15:0] g0,g1;
wire [30:0] coeffs_Cos_in,coeffs_Sin_in;
wire [6:0] x_g_a_A,x_g_b_A;

wire [64:0] coeffs_Log_in;
wire [5:0] LZD_Log;
wire [7:0] x_e_A;
wire [30:0] e;

wire [31:0] coeffs_Sqrt1_in,coeffs_Sqrt2_in;
wire [5:0] LZD_Sqrt;
wire [5:0] x_f_A;
wire [16:0] f;


URNG URNG1(clk,reset,urng_seed1,urng_seed2,urng_seed3,a);				//Tausworth's URNG's
URNG URNG2(clk,reset,urng_seed4,urng_seed5,urng_seed6,b);

Sin_Cos Sin_Cos_function(clk,u1,g0,g1,coeffs_Sin_in,coeffs_Cos_in,x_g_a_A,x_g_b_A);	//Sin/Cos unit
Sin_Cos_Coeffs Sin_Coeffs(clk,x_g_a_A,coeffs_Sin_in);
Sin_Cos_Coeffs Cos_Coeffs(clk,x_g_b_A,coeffs_Cos_in);


Log Log_function(clk,u0,coeffs_Log_in,LZD_Log,x_e_A,e);					//Log unit
LZD LZD_Log1(clk,u0,LZD_Log);
Log_Coeffs Log_Coeffs1(clk,x_e_A,coeffs_Log_in);

Sqrt Sqrt_function(clk,e,coeffs_Sqrt1_in,coeffs_Sqrt2_in,LZD_Sqrt-6'b010001,x_f_A,f);	//Square Root unit
LZD LZD_Sqrt1(clk,{17'b00000000000000000,e},LZD_Sqrt);
Sqrt1_Coeffs Sqrt1_Coeffs1(clk,x_f_A,coeffs_Sqrt1_in);
Sqrt2_Coeffs Sqrt2_Coeffs2(clk,x_f_A,coeffs_Sqrt2_in);

always@(clk)
begin

	u1[15:0] <= a[15:0];
	u0[47:0] <= {b[31:0],a[31:16]};
	g0_final <= g0;
	g1_final <= g1;
	f_final <= f;
	e_final <= e;

	temp0 <= g0*f;
	temp1 <= g1*f;
	x0 <= temp0[32:17];		//Final output of AWGN x0
	x1 <= temp1[32:17];		//Final output of AWGN x1
end
endmodule
