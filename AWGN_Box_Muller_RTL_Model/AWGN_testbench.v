// AWGN testbench with input seeds s1-s6 for tausworthe's URNG's and with input clock frequency of 50MHz

`timescale 1ns/1ps
module AGWN_testbench();
reg clk, reset;
reg [31:0] s1,s2,s3,s4,s5,s6;
wire [15:0] x0,x1;

integer f1,f2,f3,f4,f5,f6,f7,f8,i1,i2;
reg [15:0] x0_matlab;
reg [15:0] x1_matlab;


Main test(clk, reset,s1,s2,s3,s4,s5,s6,x0,x1); //Module instantiation

always 
begin
	#2.15;
	clk=0;
	#2.15;			//233MHz clock
	clk=1;	
end

initial 
begin
	#2.15;
	reset=1;
	s1<=32'hFFFFFFFF;
	s2<=32'hFDFDFDFD;
	s3<=32'hEFEFEFEF;
	s4<=32'hFEDAFEDA;	//input seeds s1-s6
	s5<=32'hFFFAFFFA;
	s6<=32'hFDEAFDEA;
	#4.3;
	reset=0;
end


initial 
	begin
	f1 = $fopen("awgn_rtl_x0.txt","w"); 		//Output file for AWGN_x0
	f2 = $fopen("awgn_matlab_x0.txt","r");		//Input file: Matlab model AWGN_x0
	f3 = $fopen("Comparision_result_x0.txt","w");	//Output file for comparision of Matlab model and RTL model
	@(x0); 						//Wait for reset to be released
	
	for (i1=0; i1<10000; i1=i1+1) 
	begin
		@(clk);
		f4 = $fscanf(f2,"%b\n",x0_matlab);	
		$display("awgn_x0 : %b",x0);
		$fwrite(f1,"%b\n",x0);
		
		if(x0 && x0_matlab)			//Logical AND operation between Matlab result and RTL result
		$fwrite(f3,"%d : Pass\n",i1);
		else
		$fwrite(f3,"%d : Fail\n",i1);
	end

	$fclose(f1);
	$fclose(f2);
	$fclose(f3);
end

initial 
	begin
	
	f5 = $fopen("awgn_rtl_x1.txt","w");			//Output file for AWGN_x1
	f6 = $fopen("awgn_matlab_x1.txt","r");		//Input file: Matlab model AWGN_x1
	f7 = $fopen("Comparision_result_x1.txt","w");	//Output file for comparision of Matlab model and RTL model
	
	@(x1); 						//Wait for reset to be released
	

	for (i2=0; i2<10000; i2=i2+1) 
	begin
		@(clk);
		f8 = $fscanf(f6,"%b\n",x1_matlab);
		$display("awgn_x1 : %b",x1);
		$fwrite(f5,"%b\n",x1);

		if(x1 && x1_matlab)			//Logical AND operation between Matlab result and RTL result
		$fwrite(f7,"%d : Pass\n",i1);
		else
		$fwrite(f7,"%d : Fail\n",i1);
	end

	$fclose(f5);
	$fclose(f6);
	$fclose(f7);
end

endmodule
