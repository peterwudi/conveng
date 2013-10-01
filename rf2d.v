module rf2d
(
	input				clk,
	input		[179:0]	data,
	
	input				reset,
	input				colShift,
	input				rowShift,
	
	output	[9:0]	res

);

parameter numCol	= 18;
parameter numRow	= 16;
parameter numBits	= 10;

localparam rowSize = numCol*numBits;


reg	[numCol*numBits-1 : 0]	rf	[numRow-1 : 0];

genvar i;
integer j;


generate
	for (i = 0; i < numRow; i = i+1)	begin: a
		always @(posedge clk) begin
			for (j = 0; j < rowSize; j = j+1)	begin: b
				if (reset) begin
					rf[i] <= 'b0;
				end
				else if (colShift) begin
					rf[i][j] <= rf[i][(j+numBits)%rowSize];
				end
				else if (rowShift) begin
					if (i < numRow - 1) begin
						rf[i] <= rf[i+1];
					end
					else begin
						rf[i] <= data;
					end
				end
			end
		end
	end	
endgenerate
/*
genvar k;
generate
	for (k = 0; k < rowSize; k = k+1)	begin: c
		always @(posedge clk) begin
			if (reset) begin
				rf[numRow-1] <= 'b0;
			end
			else if (colShift) begin
				rf[numRow-1][k] <= rf[numRow-1][(k+numBits)%rowSize];
			end
			else if (rowShift) begin
				rf[numRow-1] <= data;
			end
		end
	end
endgenerate
*/

assign res = rf[0][numBits-1:0];


endmodule

