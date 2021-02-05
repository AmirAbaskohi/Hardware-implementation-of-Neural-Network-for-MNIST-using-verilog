module mainController (input clk, rst, start, snReady,
output reg snRst, snStart, shiftEn, ld1, ld2, inputSel, ready, output reg[1:0]weightSel);

	reg [3:0] ns, ps;

	always@(posedge clk, posedge rst) begin
		if(rst) ps = 4'b0000;
		else ps = ns;
	end

	always@(ps, snReady, start)begin
		case(ps)
		4'b0000: ns = (start) ? 4'b0001 : 4'b0000;
		4'b0001: ns = (start) ? 4'b0001 : 4'b0010;
		4'b0010: ns = 4'b0011;
		4'b0011: ns = 4'b0100;
		4'b0100: ns = (snReady) ? 4'b0101 : 4'b0100;
		4'b0101: ns = 4'b0110;
		4'b0110: ns = 4'b0111;
		4'b0111: ns = 4'b1000;
		4'b1000: ns = (snReady) ? 4'b1001 : 4'b1000;
		4'b1001: ns = 4'b1010;
		4'b1010: ns = 4'b1011;
		4'b1011: ns = 4'b1100;
		4'b1100: ns = (snReady) ? 4'b1101 : 4'b1100;
		4'b1101: ns = 4'b0000;
		default : ns = 4'b0000;
		endcase
	end

	always@(ps) begin
	
		{snRst, snStart, shiftEn, ld1, ld2, inputSel, ready} = 7'b0000000;
		weightSel = 2'b00;

		case(ps)
		4'b0000: ;
		4'b0001: ;
		4'b0010: {snRst} = 1'b1;
		4'b0011: {snStart, shiftEn, inputSel, weightSel} = 5'b11000;
		4'b0100: {shiftEn, inputSel, weightSel} = 4'b1000;
		4'b0101: {ld1, shiftEn} = 2'b11;
		4'b0110: {snRst} = 1'b1;
		4'b0111: {snStart, shiftEn, inputSel, weightSel} = 5'b11001;
		4'b1000: {shiftEn, inputSel, weightSel} = 4'b1001;
		4'b1001: {ld2, shiftEn} = 2'b11;
		4'b1010: {snRst} = 1'b1;
		4'b1011: {snStart, inputSel, weightSel, shiftEn} = 5'b11101;
		4'b1100: {inputSel, weightSel, shiftEn} = 4'b1101;
		4'b1101: {ready, shiftEn} = 2'b11;
		endcase
	end
	
endmodule