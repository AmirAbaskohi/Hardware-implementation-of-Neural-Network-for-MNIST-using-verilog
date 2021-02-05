module hiddenOutputReg(input[79:0] inp,input clk, input rst,
		input ld1, input ld2, output[503:0] out);

	reg[79:0] first, second;
	
	always@(posedge clk, posedge rst) begin
	
		if(rst)begin
			first <= 80'b0;
			second <= 80'b0;
		end
		else if(ld1) first <= inp;
		else if(ld2) second <= inp;
		else begin
			first <= first;
			second <= second;
		end
	
	end
	
	assign out = { 336'b0 ,8'b01111111 ,second, first};

endmodule


module mainDatapath(
		input[503:0] inp,
		input clk, rst, snRst,
		input shiftEn, ld1, ld2,
		input inputSel,
		input[1:0] weightSel,
		input snStart,
		output reg[7:0] out,
		output snReady
    );

	reg[503:0] weightHidden [0:19];
	reg[503:0] weightOutput [0:9];
	
	reg[503:0] selectedWeight[0:9];
	
	reg [7:0] file1[0:(20)-1];
	reg [7:0] file2[0:(10)-1];
	reg [7:0] file3[0:(62 * 20)-1];
	reg [7:0] file4[0:(20 * 10)-1];
	
	wire[503:0] selectedIn;
	
	wire[503:0] hiddenOut;
	wire[79:0] layerOut;
	wire[7:0] snOuts[0:9];
	wire [9:0]snReadies;
	
	reg[7:0] temp;
	
	integer i, j, k;
	
	initial begin
		$readmemh("bh_sm.dat", file1);
		$readmemh("bo_sm.dat", file2);
		$readmemh("wh_sm.dat", file3);
		$readmemh("wo_sm.dat", file4);
		for(i = 0; i < 20; i = i+1)begin
			for(j = 0; j < 62; j = j+1)begin
				for(k = 0; k < 8; k = k+1)begin
					weightHidden[i][(j*8)+k] = file3[(62*i)+j][k];
				end
			end
			weightHidden[i][503:496] = file1[i];
		end
		for(i = 0; i < 10; i = i+1)begin
			for(j = 0; j < 20; j = j+1)begin
				for(k = 0; k < 8; k = k+1)begin
					weightOutput[i][(j*8)+k] = file4[(20*i)+j][k];
				end
			end
			weightOutput[i][167:160] = file2[i];
			weightOutput[i][503:168] = 336'b0;
		end
	end
	
	always@(weightSel)begin
	
		if(weightSel == 2'b00)begin
			for(i=0; i < 10; i= i+1)
				selectedWeight[i] = weightHidden[i];
		end
		else if(weightSel == 2'b01)begin
			for(i=0; i < 10; i= i+1)
				selectedWeight[i] = weightHidden[i+10];
		end
		else begin
			for(i=0; i < 10; i= i+1)
				selectedWeight[i] = weightOutput[i];
		end
	
	end
	
	hiddenOutputReg hiddenOutputReg0 (
    .inp(layerOut), 
    .clk(clk), 
    .rst(rst), 
    .ld1(ld1), 
    .ld2(ld2), 
    .out(hiddenOut)
    );
	 
	assign selectedIn = inputSel ? hiddenOut : inp;
	
	singleNeuron #(63, 8) sn0(
			 .clk(clk), 
			 .rst(snRst), 
			 .start(snStart), 
			 .shiftEn(shiftEn), 
			 .in_vec(selectedIn), 
			 .w_vec(selectedWeight[0]), 
			 .out(snOuts[0]), 
			 .ready(snReadies[0])
			 );
	
	singleNeuron #(63, 8) sn1(
			 .clk(clk), 
			 .rst(snRst), 
			 .start(snStart), 
			 .shiftEn(shiftEn), 
			 .in_vec(selectedIn), 
			 .w_vec(selectedWeight[1]), 
			 .out(snOuts[1]), 
			 .ready(snReadies[1])
			 );
			 
	singleNeuron #(63, 8) sn2(
			 .clk(clk), 
			 .rst(snRst), 
			 .start(snStart), 
			 .shiftEn(shiftEn), 
			 .in_vec(selectedIn), 
			 .w_vec(selectedWeight[2]), 
			 .out(snOuts[2]), 
			 .ready(snReadies[2])
			 );
			 
	singleNeuron #(63, 8) sn3(
			 .clk(clk), 
			 .rst(snRst), 
			 .start(snStart), 
			 .shiftEn(shiftEn), 
			 .in_vec(selectedIn), 
			 .w_vec(selectedWeight[3]), 
			 .out(snOuts[3]), 
			 .ready(snReadies[3])
			 );
			 
	singleNeuron #(63, 8) sn4(
			 .clk(clk), 
			 .rst(snRst), 
			 .start(snStart), 
			 .shiftEn(shiftEn), 
			 .in_vec(selectedIn), 
			 .w_vec(selectedWeight[4]), 
			 .out(snOuts[4]), 
			 .ready(snReadies[4])
			 );
			 
	singleNeuron #(63, 8) sn5(
			 .clk(clk), 
			 .rst(snRst), 
			 .start(snStart), 
			 .shiftEn(shiftEn), 
			 .in_vec(selectedIn), 
			 .w_vec(selectedWeight[5]), 
			 .out(snOuts[5]), 
			 .ready(snReadies[5])
			 );
			 
	singleNeuron #(63, 8) sn6(
			 .clk(clk), 
			 .rst(snRst), 
			 .start(snStart), 
			 .shiftEn(shiftEn), 
			 .in_vec(selectedIn), 
			 .w_vec(selectedWeight[6]), 
			 .out(snOuts[6]), 
			 .ready(snReadies[6])
			 );
			 
	singleNeuron #(63, 8) sn7(
			 .clk(clk), 
			 .rst(snRst), 
			 .start(snStart), 
			 .shiftEn(shiftEn), 
			 .in_vec(selectedIn), 
			 .w_vec(selectedWeight[7]), 
			 .out(snOuts[7]), 
			 .ready(snReadies[7])
			 );
			 
	singleNeuron #(63, 8) sn8(
			 .clk(clk), 
			 .rst(snRst), 
			 .start(snStart), 
			 .shiftEn(shiftEn), 
			 .in_vec(selectedIn), 
			 .w_vec(selectedWeight[8]), 
			 .out(snOuts[8]), 
			 .ready(snReadies[8])
			 );
			 
	singleNeuron #(63, 8) sn9(
			 .clk(clk), 
			 .rst(snRst), 
			 .start(snStart), 
			 .shiftEn(shiftEn), 
			 .in_vec(selectedIn), 
			 .w_vec(selectedWeight[9]), 
			 .out(snOuts[9]), 
			 .ready(snReadies[9])
			 );
	
	assign snReady = &{snReadies};
	
	assign layerOut = {snOuts[9], snOuts[8], snOuts[7], snOuts[6], snOuts[5],
		snOuts[4], snOuts[3], snOuts[2], snOuts[1], snOuts[0]};
		
	//Softmax
	always@(snOuts[0], snOuts[1], snOuts[2], snOuts[3], snOuts[4],
		snOuts[5], snOuts[6], snOuts[7], snOuts[8], snOuts[9])begin
		
		temp = snOuts[0];
		out = 8'b0;
		if(snOuts[1] > temp) begin
			temp = snOuts[1];
			out = 8'b00000001;
		end
		if(snOuts[2] > temp) begin
			temp = snOuts[2];
			out = 8'b00000010;
		end
		if(snOuts[3] > temp) begin
			temp = snOuts[3];
			out = 8'b00000011;
		end
		if(snOuts[4] > temp) begin
			temp = snOuts[4];
			out = 8'b00000100;
		end
		if(snOuts[5] > temp) begin
			temp = snOuts[5];
			out = 8'b00000101;
		end
		if(snOuts[6] > temp) begin
			temp = snOuts[6];
			out = 8'b00000110;
		end
		if(snOuts[7] > temp) begin
			temp = snOuts[7];
			out = 8'b00000111;
		end
		if(snOuts[8] > temp) begin
			temp = snOuts[8];
			out = 8'b00001000;
		end
		if(snOuts[9] > temp) begin
			temp = snOuts[9];
			out = 8'b00001001;
		end
		
	end	
endmodule
