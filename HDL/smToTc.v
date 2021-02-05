`timescale 1ns / 1ps

module smToTc #(parameter DW = 8)( input[DW-1:0] a, output[DW-1:0] w);
	wire [DW-2:0] mag;
	wire [DW-1:0] temp;
	wire sign;
	assign sign = a[DW-1];
	assign mag = a[DW-2:0];
	
	assign temp = {1'b0, mag};
	assign w = (sign) ? (~temp + 1'b1) : temp;

endmodule
