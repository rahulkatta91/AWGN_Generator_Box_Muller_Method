module taus(clk, reset,urng_seed1,urng_seed2,urng_seed3,urng_seed4,urng_seed5,urng_seed6,a,b);

input clk,reset;
input [31:0] urng_seed1,urng_seed2,urng_seed3,urng_seed4,urng_seed5,urng_seed6;
output [31:0] a,b;
reg [31:0] a,b;
wire [31:0] a1,b1;

URNG URNG1(clk,reset,urng_seed1,urng_seed2,urng_seed3,a1);
URNG URNG2(clk,reset,urng_seed4,urng_seed5,urng_seed6,b1);

always@(clk)
begin
	assign a = a1;
	assign b = b1;
end
endmodule
