`timescale 1ns / 1ns

module singleNeuronTb;

	reg clk;
	reg rst;
	reg shiftEn;
	reg start;
	reg [31:0] in_vec;
	reg [31:0] w_vec;

	
	wire [7:0] out;
	wire ready;

	
	singleNeuron #(4) uut (
		.clk(clk), 
		.rst(rst), 
		.start(start),
		.shiftEn(shiftEn),
		.in_vec(in_vec), 
		.w_vec(w_vec), 
		.out(out), 
		.ready(ready)
	);
	always #50 clk = ~clk;
	initial begin
		clk = 1'b0;
		shiftEn = 1'b0;
		rst = 1'b1;
		start = 1'b0;
		in_vec= 32'b00000001_11001101_00010110_00010011;//   1  -77  22   19
		w_vec = 32'b11101011_00001000_10001010_11101110;// -107  8  -10  -110
		#100;
		rst = 1'b0;
		start = 1'b1; 
		#100;
		start = 1'b0;
		
		#1200
		
		rst = 1'b1;
		start = 1'b0;
		in_vec= 32'b00000001_01101000_11001001_10110010;//  1   104  -73  -50
		w_vec = 32'b11001000_00100001_10100111_01000110;// -72  33   -39  70
		#100;
		rst = 1'b0;
		start = 1'b1; 
		#100;
		start = 1'b0;
		
		#1200
		
		rst = 1'b1;
		start = 1'b0;
		in_vec= 32'b00000001_00000000_00000000_00000000;//  1   -116  86  82
		w_vec = 32'b01111100_11100000_01010110_00001111;// 124  -96   86  15
		#100;
		rst = 1'b0;
		start = 1'b1; 
		#100;
		start = 1'b0;
		
		#1200
		$stop;

	end
endmodule