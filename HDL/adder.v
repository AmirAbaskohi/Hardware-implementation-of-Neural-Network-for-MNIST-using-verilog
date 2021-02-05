module adder #
  (
    parameter N = 16,
    parameter DW = 8,
    parameter NSEB = N - 2*DW
  )(
    input [N-1:0] a,
    input [2*DW-1:0] b,
    output [N-1:0] w
  );
  
  wire [N-1:0] extended;
  
  assign extended = { {NSEB{b[2*DW-1]}}, b[2*DW-1:0] }; 
  
  assign w = extended + a;
  
endmodule
