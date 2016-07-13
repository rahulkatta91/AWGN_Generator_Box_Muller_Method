`timescale 1ns/1ns
module LZD_test();
reg clk,enable;
reg [15:0]data_in;

wire [3:0]data_out;

LZD test(clk,enable,data_in,data_out);

always
begin
clk=1;
#10;
clk=0;
#10;
end

initial
begin
enable<=1;
data_in<=16'b0001010101010000;
#1;
data_in<=16'b0000010101010000;
#5;
data_in<=16'b0000000101010000;
#10;
data_in<=16'b1000000101010000;
end
endmodule
