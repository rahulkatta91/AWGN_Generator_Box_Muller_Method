module temp();

reg [15:0] mem [0:9999];
integer m,i;

initial $readmemb("C:\Users\Rahul Katta\Desktop\TexasLDPC Inc EvaluationProject\AWGN_Box_Muller\x_0.dat",mem);
                initial
		begin
                    $display("data:");           
                    for (i=0; i < 9999; i=i+1)         
                    $display("%d:%b",i,mem[i]);           
                 end 
endmodule
