`timescale 1ns / 1ps

module controller# (parameter N = 16)(input clk, rst, start, output reg accLd, ready, output reg [clogb2(N)-1:0] sel);  
  
  function integer clogb2;
    input [31:0] value;
    integer i;
    begin
    clogb2 = 0;
    for(i = 0; 2**i < value; i = i + 1)
      clogb2 = i + 1;
    end
  endfunction 
  
  reg [clogb2(N)-1:0] count;
  reg [2:0] ns, ps;
  
  always@(posedge clk, posedge rst)
  begin
    if(rst) count = {clogb2(N){1'b0}};
    else if (ps == 3'b011) count = count + 1'b1;
    else count = count;
  end
  
  always@(posedge clk, posedge rst)
  begin
    if(rst) ps = 3'b000;
    else ps = ns;
  end
  
  always@(ps, count, start)
  begin
    case(ps)
      3'b000 : ns = (start) ? 3'b001 : 3'b000;
      3'b001 : ns = (start) ? 3'b001 : 3'b010;
      3'b010 : ns = 3'b011;
		3'b011 : ns = (count < N-1) ? 3'b010 : 3'b100;
      3'b100 : ns = 3'b000;
		default : ns = 3'b000;
    endcase
  end
  
  always@(ps, count)
  begin
    case(ps)
      0: begin
        {accLd, ready} = 2'b00;
		  sel = {clogb2(N){1'b0}};
      end
      1: begin
        {accLd, ready} = 2'b00;
		  sel = {clogb2(N){1'b0}};
      end
      2: begin
        {accLd, ready} = 2'b00;
        sel = count;
      end
      3: begin
        {accLd, ready} = 2'b10;
		  sel = count;
      end
		4: begin
        {accLd, ready} = 2'b01;
		  sel = {clogb2(N){1'b0}};
      end
		default: begin
			{accLd, ready} = 2'b00;
			sel = {clogb2(N){1'b0}};
		end
    endcase
  end
endmodule
