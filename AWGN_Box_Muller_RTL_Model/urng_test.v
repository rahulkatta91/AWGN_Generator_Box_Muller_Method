`timescale 1ns/1ns
module urng_test();
reg clk, reset;
reg [31:0] s1,s2,s3,s4,s5,s6;
wire [15:0] x0,x1;

Main test(clk, reset,s1,s2,s3,s4,s5,s6,x0,x1);

always 
begin
clk=0;
#10;
clk=1;
#10;
end

initial
begin
reset=1;
s1<=32'hFFFF;
s2<=32'hFDFD;
s3<=32'hEFEF;
s4<=32'hFEDA;
s5<=32'hFFFA;
s6<=32'hFDEA;
#50;
reset=0;
end
endmodule
