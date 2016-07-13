//Tausworth's URNG module implementation using simple logic gates and shift registers performing bit-level logic operations
module URNG(clk,reset,s1,s2,s3,out);

input reset,clk;
input [31:0] s1,s2,s3;
output [31:0] out;
reg [31:0] out;
reg [31:0] temp,temp1,temp2;
parameter const1=32'hFFFFFFFE,const2=32'hFFFFFFF8,const3=32'hFFFFFFF0;

always@(clk)
begin
	if(reset==1)
		begin
			temp <= s1;
			temp1 <= s2;		//seeds s1-s3
			temp2 <= s3; 
		end
	else
		begin
			temp <= ((((temp<<13) ^ temp)>>19)^((temp & const1)<<12));
			temp1 <= ((((temp1<<2) ^ temp1)>>25)^((temp1 & const2)<<4));
			temp2 <= ((((temp2<<13) ^ temp2)>>3)^((temp2 & const3)<<17));
		end

	out <= ((((temp<<13) ^ temp)>>19)^((temp & const1)<<12))^((((temp1<<2) ^ temp1)>>25)^((temp1 & const2)<<4))^((((temp2<<13) ^ temp2)>>3)^((temp2 & const3)<<17));
	
end

endmodule
