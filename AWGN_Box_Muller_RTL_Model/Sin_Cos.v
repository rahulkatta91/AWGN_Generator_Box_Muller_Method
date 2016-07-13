//Sin/Cos funtional Unit using polynomial approximation based on Horner's Rule
module Sin_Cos(clk,u1,g0,g1,coeffs_Sin_in,coeffs_Cos_in,x_g_a_A,x_g_b_A);
input clk;
input [15:0] u1;
input [30:0] coeffs_Sin_in,coeffs_Cos_in;
output [15:0] g0,g1;
output [6:0] x_g_a_A, x_g_b_A;
reg [15:0] g0,g1;
reg [6:0] x_g_a_A, x_g_b_A,x_g_a_B, x_g_b_B;
reg [1:0] quad;
reg [13:0] x_g_a,x_g_b;
reg [30:0] coeffs_Sin,coeffs_Cos;
reg [25:0] x_g_a_D0,x_g_b_D0;
reg [19:0] x_g_a_D1,x_g_b_D1;
reg [14:0] y_g_a,y_g_b;

parameter const = 14'b11111111111111;

always@(clk)
begin
	quad <= u1[15:14];			//Range reduction
	x_g_a <= u1[13:0];			//Sine signal
	x_g_b <= const - x_g_a;			//Cosine signal
	
	x_g_a_A <= x_g_a[13:7];			//First 7 bits used for indexing to the Coefficient tables
	x_g_a_B <= (x_g_a<<7);			//Input to the polynomial arithmetic
	
	x_g_b_A <= x_g_b[13:7]; 
	x_g_b_B <= (x_g_b<<7);

	
	
	x_g_a_D0 <= (coeffs_Sin[30:19] * x_g_a_B);
	x_g_b_D0 <= (coeffs_Cos[30:19] * x_g_b_B);
	x_g_a_D1 <= x_g_a_D0[25:7] + coeffs_Sin[18:0];
	x_g_b_D1 <= x_g_b_D0[25:7] + coeffs_Cos[18:0];

	y_g_a <= x_g_a_D1[19:5];		//Output of the polynomial arithmetic
	y_g_b <= x_g_b_D1[19:5];

	case(quad)				//Range reconstruction
		2'b00:
		begin
			g0 <= y_g_b;
			g1 <= y_g_a;
		end

		2'b01:
		begin
			g0 <= y_g_a;
			g1[14:0] <= ~(y_g_b) + 1'b1;		//Performing 2's complement representation
			g1[15] <= 1'b1;
		end
	
		2'b10:
		begin
			g0[14:0] <= ~(y_g_b) + 1'b1;
			g0[15] <= 1'b1;
			g1[14:0] <= ~(y_g_a) + 1'b1;
			g1[15] <= 1'b1;
		end

		2'b01:
		begin
			g1 <= y_g_b;
			g0[14:0] <= ~(y_g_a) + 1'b1;
			g0[15] <= 1'b1;
		end
	endcase
end

always@(clk)
begin
	coeffs_Sin[30:0] <= coeffs_Sin_in;			//Retrieving Coefficient values from tables
	coeffs_Cos[30:0] <= coeffs_Cos_in;
end
endmodule

