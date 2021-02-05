module MLP(
	input[503:0]inp,
	input clk,
	input rst,
	input start,
	output[7:0] label,
	output ready);
	
	wire snRst, shiftEn, ld1, ld2;
	wire inputSel, snStart, snReady;
	wire[1:0] weightSel;

	mainDatapath datapath (
    .inp(inp), 
    .clk(clk), 
    .rst(rst), 
    .snRst(snRst), 
    .shiftEn(shiftEn), 
    .ld1(ld1), 
    .ld2(ld2), 
    .inputSel(inputSel), 
    .weightSel(weightSel), 
    .snStart(snStart), 
    .out(label), 
    .snReady(snReady)
    );

	mainController controller (
    .clk(clk), 
    .rst(rst), 
    .start(start), 
    .snReady(snReady), 
    .snRst(snRst), 
    .snStart(snStart), 
    .shiftEn(shiftEn), 
    .ld1(ld1), 
    .ld2(ld2), 
    .inputSel(inputSel), 
    .ready(ready), 
    .weightSel(weightSel)
    );

endmodule
