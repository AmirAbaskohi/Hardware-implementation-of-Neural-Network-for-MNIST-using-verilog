`timescale 1ns / 1ps

module datapath #
  (
    parameter N = 10,
		parameter DW = 8,
		parameter DW_VEC = N*DW
  )(
    input clk,
		input rst,
		input accLd,
		input shiftEn,
		input [clogb2(N)-1:0]sel,
		input [DW_VEC-1:0] inVec,
		input [DW_VEC-1:0] wVec,
		output [7:0] out
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
   
  wire [DW-1:0] in, weight, inTemp, weightTemp;
  wire [2*DW-1:0] multplierOut;
  wire [2*DW+clogb2(N)-1:0] accumulatorOut, adderOut, shiftedAccOut;
  wire [7:0] actvTemp;
   
  inputSelection #(N, DW, DW_VEC) selector(inVec, wVec, sel, inTemp, weightTemp);
  
  smToTc #(DW) s1(inTemp, in);
  smToTc #(DW) s2(weightTemp, weight);
  
  signedMultiplier8 mult (clk, in, weight, multplierOut);
  
  adder #(2*DW+clogb2(N), DW) adder0(accumulatorOut, multplierOut, adderOut);
  
  accumulatorRegister #(2*DW+clogb2(N)) accReg(clk, rst, accLd, adderOut, accumulatorOut);
  
  assign shiftedAccOut = shiftEn ? {{9{accumulatorOut[2*DW+clogb2(N)-1]}}, accumulatorOut[2*DW+clogb2(N)-1:9]} : accumulatorOut;
  
  activationFunction #(2*DW+clogb2(N)) af(shiftedAccOut , out);
    
endmodule

