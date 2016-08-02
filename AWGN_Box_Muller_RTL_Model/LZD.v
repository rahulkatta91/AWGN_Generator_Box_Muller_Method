// Leading Zero Detector module returns the number of zero in a given vector
`timescale 1ns/1ps
module LZD(data_in,data_out);

input [47:0] data_in;
output [5:0] data_out;
reg [5:0] data_out;

parameter enable = 1;

always@(data_in)
begin
//Step by step detection for first occurence of a '1'
	data_out <= (!enable)?6'b110000:
	(data_in[47])?6'b000000:
	(data_in[46])?6'b000001:
	(data_in[45])?6'b000010:
	(data_in[44])?6'b000011:
	(data_in[43])?6'b000100:
	(data_in[42])?6'b000101:
	(data_in[41])?6'b000110:
	(data_in[40])?6'b000111:
	(data_in[39])?6'b001000:
	(data_in[38])?6'b001001:
	(data_in[37])?6'b001010:
	(data_in[36])?6'b001011:
	(data_in[35])?6'b001100:
	(data_in[34])?6'b001101:
	(data_in[33])?6'b001110:
	(data_in[32])?6'b001111:
	(data_in[31])?6'b010000:
	(data_in[30])?6'b010001:
	(data_in[29])?6'b010010:
	(data_in[28])?6'b010011:
	(data_in[27])?6'b010100:
	(data_in[26])?6'b010101:
	(data_in[25])?6'b010110:
	(data_in[24])?6'b010111:
	(data_in[23])?6'b011000:
	(data_in[22])?6'b011001:
	(data_in[21])?6'b011010:
	(data_in[20])?6'b011011:
	(data_in[19])?6'b011100:
	(data_in[18])?6'b011101:
	(data_in[17])?6'b011110:
	(data_in[16])?6'b011111:
	(data_in[15])?6'b100000:
	(data_in[14])?6'b100001:
	(data_in[13])?6'b100010:
	(data_in[12])?6'b100011:
	(data_in[11])?6'b100100:
	(data_in[10])?6'b100101:
	(data_in[9])?6'b100110:
	(data_in[8])?6'b100111:
	(data_in[7])?6'b101000:
	(data_in[6])?6'b101001:
	(data_in[5])?6'b101010:
	(data_in[4])?6'b101011:
	(data_in[3])?6'b101100:
	(data_in[2])?6'b101101:
	(data_in[1])?6'b101110:
	(data_in[0])?6'b101111:6'b110000;
end

endmodule
