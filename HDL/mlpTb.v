module MLPTB();

	reg clk, rst, start;
	reg [503:0] inp;
	wire ready;
	wire[7:0] label;
	
	reg [503:0] in[0:750 - 1];
	reg [7:0] file1[0:(750 * 62)-1];
	reg [7:0] file2[0:(750)-1];

	integer i,j,k,c;
	integer count;

	MLP UUT (
	 .inp(inp), 
	 .clk(clk), 
	 .rst(rst), 
	 .start(start), 
	 .label(label), 
	 .ready(ready)
	 );
	 
	always #50 clk = ~clk;
	 
	initial begin
	
		$readmemh("test_data_sm.dat", file1);
		$readmemh("test_lable_sm.dat", file2);
		
		
		
		for(i = 0; i < 750; i = i+1)begin
			for(j = 0; j < 62; j = j+1)begin
				for(k = 0; k < 8; k = k+1)begin
					in[i][(j*8)+k] = file1[(62*i)+j][k];
				end
			end
			in[i][503:496] = 8'b01111111;
		end
		
		clk = 0;
		count = 0;
		for(c = 0 ; c < 750; c = c+1)begin
			#100
			rst = 1;
			start = 0;
			#100
			rst = 0;
			start = 1;
			#100
			start = 0;
			inp = in[c];
			while(ready != 1'b1) #100;
			if(label == file2[c]) count = count + 1;
		end
		
		$display("True Guess Nmber = %d\n", count);
		$stop;
		
	end

  
endmodule

