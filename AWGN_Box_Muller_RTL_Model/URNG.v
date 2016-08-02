//Tausworth's URNG module implementation using simple logic gates and shift registers performing bit-level logic operations
`timescale 1ns/1ps
module URNG(clk,reset,s1,s2,s3,out);

input reset,clk;
input [31:0] s1,s2,s3;
output [31:0] out;
reg [31:0] out;
reg [31:0] temp,temp1,temp2;
wire [31:0] test,test1,test2,out_test;
parameter const1=32'hFFFFFFFE,const2=32'hFFFFFFF8,const3=32'hFFFFFFF0; //Constants in the Taus's algorithm

//Taus's algorithm
assign test = (((temp<<13) ^ temp)>>19)^((temp & const1)<<12);
assign test1 = ((((temp1<<2) ^ temp1)>>25)^((temp1 & const2)<<4));
assign test2 = ((((temp2<<3) ^ temp2)>>11)^((temp2 & const3)<<17));
assign out_test = test ^ test1 ^ test2;

always@(clk)
begin
	if(reset==1)
		begin
			temp <= s1;
			temp1 <= s2;		//initial seed s1-s3 inputs
			temp2 <= s3; 
		end
	else
		begin
			temp <= test;
			temp1 <= test1;
			temp2 <= test2;
		end

	out <= out_test;
	
end

endmodule
