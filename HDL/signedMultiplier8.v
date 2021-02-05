`timescale 1ns / 1ps

module twoBitMultiplier(input[1:0] a, input[1:0] b, output[3:0] c);
  wire m0, m1, m2, m3, m4, m5;
  
  and and0(c[0], a[0], b[0]);
  and and1(m0, a[1], ~a[0], b[0]);
  and and2(m1, a[1], ~b[1], b[0]);
  and and3(m2, b[1], ~a[1], a[0]);
  and and4(m3, a[0], ~b[0], b[1]);
  or or0(c[1], m0, m1, m2, m3);
  and and5(m4, a[1], ~a[0], b[1]);
  and and6(m5, a[1], ~b[0], b[1]);
  or or1(c[2], m4, m5);
  and and7(c[3], a[0], a[1], b[0], b[1]);
endmodule

module fourBitMultiplier(input[3:0] a, input[3:0] b, output[7:0] c);
  wire [3:0] p1,p2,p3,p4;
  
  twoBitMultiplier mul1(a[1:0], b[1:0], p1);
  twoBitMultiplier mul2(a[3:2], b[1:0], p2);
  twoBitMultiplier mul3(a[1:0], b[3:2], p3);
  twoBitMultiplier mul4(a[3:2], b[3:2], p4);
  assign c = p1 + {p2 , 2'b00} + {p3 , 2'b00} + {p4, 4'b0000} ;
endmodule

module signedMultiplier8(input clk, input[7:0] a, input[7:0] b, output reg[15:0] c);
  wire [7:0] first, second;
  wire [15:0] temp;
  
  assign first = (a[7] == 1'b1) ? (~a) + 1'b1 : a;
  assign second = (b[7] == 1'b1) ? (~b) + 1'b1 : b;
  
  wire [7:0] p1,p2,p3,p4;
  fourBitMultiplier mul1(first[3:0], second[3:0], p1);
  fourBitMultiplier mul2(first[7:4], second[3:0], p2);
  fourBitMultiplier mul3(first[3:0], second[7:4], p3);
  fourBitMultiplier mul4(first[7:4], second[7:4], p4);
  assign temp = p1 + {p2 , 4'b0000} + {p3 , 4'b0000} + {p4, 8'b00000000} ;
  always@(posedge clk) begin
	c = ((a[7] == 1'b1 && b[7] == 1'b0) || (b[7] == 1'b1 && a[7] == 1'b0)) ? (~temp+1'b1) : temp;
	end
endmodule