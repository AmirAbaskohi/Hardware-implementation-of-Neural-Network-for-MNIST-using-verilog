module activationFunction #
  (
    parameter N = 16
  )(
    input [N-1:0] in,
    output [7:0] out
  );
  
  assign out = (in[N-1] == 1'b1) ? 8'b00000000 : (in > 8'b01111111) ? 8'b01111111 : {1'b0,in[6:0]}; 
  
endmodule
