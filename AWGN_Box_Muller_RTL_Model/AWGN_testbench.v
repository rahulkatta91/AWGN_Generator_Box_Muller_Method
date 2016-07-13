// AWGN testbench with input seeds s1-s6 for tausworthe's URNG's and with input clock frequency of 50MHz

module AGWN_testbench();
reg clk, reset;
reg [31:0] s1,s2,s3,s4,s5,s6;
wire [15:0] x0,x1;
wire [15:0] g0,g1;
wire [16:0] f;
wire [30:0] e;
integer f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,i1,i2,i3,i4,i5,i6;
reg [15:0] x0_matlab;
reg [15:0] x1_matlab;
reg [15:0] g0_matlab,g1_matlab;
reg [16:0] f_matlab;
reg [30:0] e_matlab;

Main test(clk, reset,s1,s2,s3,s4,s5,s6,x0,x1,g0,g1,e,f); //Module instantiation

always 
begin
	clk=0;
	#10;			//50MHz clock
	clk=1;	
	#10;
end

initial 
begin
	reset=1;
	s1<=32'hFFFFFFFF;
	s2<=32'hFDFDFDFD;
	s3<=32'hEFEFEFEF;
	s4<=32'hFEDAFEDA;	//input seeds s1-s6
	s5<=32'hFFFAFFFA;
	s6<=32'hFDEAFDEA;
	#20;
	reset=0;
end


initial 
	begin
	f1 = $fopen("awgn_x0.txt","w"); 		//Output file for AWGN_x0
	f2 = $fopen("awgn_matlab_x0.txt","r");		//Input file: Matlab model AWGN_x0
	f3 = $fopen("error_x0.txt","w");		//Output file for error analysis of Matlab model and RTL model
	@(x1); 						//Wait for reset to be released
	@(posedge clk);  				//Wait for fisrt clock out of reset

	for (i1=0; i1<10000; i1=i1+1) 
	begin
		@(clk);
		f4 = $fscanf(f2,"%b\n",x0_matlab);	
		$display("awgn_x0 : %b",x0);
		$fwrite(f1,"%b\n",x0);
		$fwrite(f3,"%d\n",x0 ^ x0_matlab);
	end

	$fclose(f1);
	$fclose(f2);
	$fclose(f3);
end

initial 
	begin
	
	f5 = $fopen("awgn_x1.txt","w");			//Output file for AWGN_x1
	f6 = $fopen("awgn_matlab_x1.txt","r");		//Input file: Matlab model AWGN_x1
	f7 = $fopen("error_x1.txt","w");		//Output file for error analysis of Matlab model and RTL model
	
	@(x1); 						//Wait for reset to be released
	@(posedge clk);   				//Wait for fisrt clock out of reset

	for (i2=0; i2<10000; i2=i2+1) 
	begin
		@(clk);
		f8 = $fscanf(f6,"%b\n",x1_matlab);
		$display("awgn_x1 : %b",x1);
		$fwrite(f5,"%b\n",x1);
		$fwrite(f7,"%d\n",(x1 ^ x1_matlab));
	end

	$fclose(f5);
	$fclose(f6);
	$fclose(f7);
end

initial 
	begin
	
	f9 = $fopen("awgn_g0.txt","w");			//Output file for AWGN_g0
	f10 = $fopen("awgn_matlab_g0.txt","r");		//Input file: Matlab model AWGN_g0
	f11 = $fopen("error_g0.txt","w");		//Output file for error analysis of Matlab model and RTL model
	
	@(x1); 						//Wait for reset to be released
	@(posedge clk);   				//Wait for fisrt clock out of reset

	for (i3=0; i3<10000; i3=i3+1) 
	begin
		@(clk);
		f12 = $fscanf(f10,"%b\n",g0_matlab);
		$display("awgn_g0 : %b",g0);
		$fwrite(f9,"%b\n",g0);
		$fwrite(f11,"%d\n",(g0 ^ g0_matlab));
	end

	$fclose(f9);
	$fclose(f10);
	$fclose(f11);
end

initial 
	begin
	
	f13 = $fopen("awgn_g1.txt","w");		//Output file for AWGN_g1
	f14 = $fopen("awgn_matlab_g1.txt","r");		//Input file: Matlab model AWGN_g1
	f15 = $fopen("error_g1.txt","w");		//Output file for error analysis of Matlab model and RTL model

	
	@(x1); 						//Wait for reset to be released
	@(posedge clk);   				//Wait for fisrt clock out of reset

	for (i4=0; i4<10000; i4=i4+1) 
	begin
		@(clk);
		f16 = $fscanf(f14,"%b\n",g1_matlab);
		$display("awgn_g1 : %b",g1);
		$fwrite(f13,"%b\n",g1);
		$fwrite(f15,"%d\n",(g1 ^ g1_matlab));
	end

	$fclose(f13);
	$fclose(f14);
	$fclose(f15);
end

initial 
	begin
	
	f17 = $fopen("awgn_f.txt","w");			//Output file for AWGN_f
	f18 = $fopen("awgn_matlab_f.txt","r");		//Input file: Matlab model AWGN_f
	f19 = $fopen("error_f.txt","w");		//Output file for error analysis of Matlab model and RTL model
	
	@(x1); 						//Wait for reset to be released
	@(posedge clk);   				//Wait for fisrt clock out of reset

	for (i5=0; i5<10000; i5=i5+1) 
	begin
		@(clk);
		f20 = $fscanf(f18,"%b\n",f_matlab);
		$display("awgn_f : %b",f);
		$fwrite(f17,"%b\n",f);
		$fwrite(f19,"%d\n",(f ^ f_matlab));
	end

	$fclose(f17);
	$fclose(f18);
	$fclose(f19);
end

initial 
	begin
	
	f21 = $fopen("awgn_e.txt","w");			//Output file for AWGN_f
	f22 = $fopen("awgn_matlab_e.txt","r");		//Input file: Matlab model AWGN_f
	f23 = $fopen("error_e.txt","w");		//Output file for error analysis of Matlab model and RTL model
	
	@(x1); 						//Wait for reset to be released
	@(posedge clk);   				//Wait for fisrt clock out of reset

	for (i6=0; i6<10000; i6=i6+1) 
	begin
		@(clk);
		f24 = $fscanf(f22,"%b\n",e_matlab);
		$display("awgn_e : %b",x1);
		$fwrite(f21,"%b\n",e);
		$fwrite(f23,"%d\n",(e ^ e_matlab));
	end

	$fclose(f21);
	$fclose(f22);
	$fclose(f23);
end

endmodule
