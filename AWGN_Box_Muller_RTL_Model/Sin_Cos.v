//Sin/Cos funtional Unit using polynomial approximation based on Horner's Rule
`timescale 1ns/1ps
module Sin_Cos(u1,g0,g1);


input [15:0] u1;
output [15:0] g0,g1;
reg [15:0] g0,g1;

wire [15:0] y_g_a,y_g_b;
wire [6:0] x_g_a_A, x_g_b_A;
wire [13:0] x_g_a,x_g_b,x_g_a_B, x_g_b_B;
wire [1:0] quad;
wire [18:0] x_g_a_D0,x_g_b_D0;
wire [19:0] x_g_a_D1,x_g_b_D1;
wire [18:0] coeff_Sin_c0,coeff_Cos_c0;
wire [11:0] coeff_Sin_c1, coeff_Cos_c1;
wire [30:0] coeffs_Sin_in,coeffs_Cos_in;

parameter const = 14'b11111111111111;

//Module instantiation for Coefficient values, Multiplication, Addition
Sin_Cos_Coeffs Sin_Coeffs(x_g_a_A,coeffs_Sin_in);
Sin_Cos_Coeffs Cos_Coeffs(x_g_b_A,coeffs_Cos_in);
Sin_Cos_mul Sin_mul(coeff_Sin_c1,x_g_a_B,x_g_a_D0);
Sin_Cos_mul Cos_mul(coeff_Cos_c1,x_g_b_B,x_g_b_D0);
Sin_Cos_add Sin_add(coeff_Sin_c0,x_g_a_D0,x_g_a_D1);
Sin_Cos_add Cos_add(coeff_Cos_c0,x_g_b_D0,x_g_b_D1);

assign x_g_a = u1[13:0];	//Sin Signal
assign x_g_b = (const - x_g_a);	//Cos Signal
assign x_g_a_A = x_g_a[13:7];	//Coefficient Index for Sin
assign x_g_a_B = (x_g_a<<7);	
assign x_g_b_A = x_g_b[13:7];	//Coefficient Index for Cos
assign x_g_b_B = (x_g_b<<7);

//Assigning of Coefficients to variables
assign coeff_Sin_c1 = coeffs_Sin_in [30:19];
assign coeff_Sin_c0 = coeffs_Sin_in [18:0];
assign coeff_Cos_c1 = coeffs_Cos_in [30:19];
assign coeff_Cos_c0 = coeffs_Cos_in [18:0];

assign y_g_a = x_g_a_D1[19:4];		//Output of the polynomial arithmetic
assign y_g_b = x_g_b_D1[19:4];
assign quad = u1[15:14];

always@(y_g_a or y_g_b or quad)
begin
	case(quad)				//Range reconstruction
		2'b00:
		begin
			g0 <= y_g_b;
			g1 <= y_g_a;
		end

		2'b01:
		begin
			g0 <= y_g_a;
			g1[15:0] <= (~(y_g_b)) + 1'b1;		//Performing 2's complement representation
		end
	
		2'b10:
		begin
			g0[15:0] <= (~(y_g_b)) + 1'b1;
			g1[15:0] <= (~(y_g_a)) + 1'b1;
		end

		2'b11:
		begin
			g1 <= y_g_b;
			g0[15:0] <= (~(y_g_a)) + 1'b1;
		end
	endcase
end

endmodule

