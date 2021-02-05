module accumulatorRegister #
  (
    parameter N = 16
  )(
    input clk,
    input rst,
    input accLd,
    input [N-1:0] in,
    output [N-1:0] out
  );
  
  reg [N-1:0] register;
  
  always@(posedge clk, posedge rst) begin
    if(rst) register <= 0;
    else if(accLd) begin
      register <= in;
    end
  end
  
  assign out = register;
  
endmodule