module singleNeuron #
	( 	
	   parameter N = 10,
		parameter DW = 8,
		parameter DW_VEC = N*DW
	)(		
		input wire clk,
		input wire rst,
		input wire start,
		input wire shiftEn,
		input wire [DW_VEC-1:0] in_vec,
		input wire [DW_VEC-1:0] w_vec,
		output wire [7:0] out,
		output wire ready
	);
	
	function integer clogb2;
   input [31:0] value;
   integer 	i;
   begin
      clogb2 = 0;
      for(i = 0; 2**i < value; i = i + 1)
	       clogb2 = i + 1;
   end
  endfunction
  
  wire accLd;
  wire [clogb2(N)-1:0]sel;
  
  datapath #(N , DW) dp (
   .clk(clk), 
   .rst(rst), 
   .accLd(accLd),
	.shiftEn(shiftEn),
   .sel(sel), 
   .inVec(in_vec), 
   .wVec(w_vec), 
   .out(out)
   );
	 
	controller #(N) sc (
   .clk(clk), 
   .rst(rst), 
   .start(start), 
   .accLd(accLd), 
   .ready(ready), 
   .sel(sel)
   );
	
endmodule
