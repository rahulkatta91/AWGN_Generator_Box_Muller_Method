//Main module used for all module instantiations
`timescale 1ns/1ps
module test(clk, reset,urng_seed1,urng_seed2,urng_seed3,urng_seed4,urng_seed5,urng_seed6,x0,x1);
input clk,reset;
input [31:0] urng_seed1,urng_seed2,urng_seed3,urng_seed4,urng_seed5,urng_seed6;

output [15:0] x0,x1;
reg [15:0] x0,x1;


reg [32:0] temp0,temp1;

wire [31:0] a,b;
wire [15:0] g0,g1;
wire [30:0] e;
wire [16:0] f;


URNG URNG1(clk,reset,urng_seed1,urng_seed2,urng_seed3,a);				//Tausworth's URNG's
URNG URNG2(clk,reset,urng_seed4,urng_seed5,urng_seed6,b);

Sin_Cos Sin_Cos_function(a[15:0],g0,g1);	//Sin/Cos unit


Log Log_function({b[31:0],a[31:16]},e);		//Log unit


Sqrt Sqrt_function(e,f);			//Square Root unit


always@(clk or temp0 or temp1)
begin
	temp0 <= g0*f;
	temp1 <= g1*f;
	x0 <= temp0[32:17];		//Final output of AWGN x0
	x1 <= temp1[32:17];		//Final output of AWGN x1
end

endmodule
