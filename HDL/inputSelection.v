`timescale 1ns / 1ps

module inputSelection #
  (
    parameter N = 2,
    parameter DW = 8,
    parameter DW_VEC = N*DW
  )(
    input [DW_VEC-1:0] inVec,
    input [DW_VEC-1:0] wVec,
    input [clogb2(N)-1:0]sel,
    output reg [DW-1:0] outInput,
    output reg [DW-1:0] outWeight
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
  
  integer i;
  always@(sel, inVec, wVec)begin
    for(i = 0 ; i < DW ; i=i+1)begin
      outInput[i] = inVec[(sel*DW)+i];
      outWeight[i] = wVec[(sel*DW)+i];
    end
  end
  
endmodule
