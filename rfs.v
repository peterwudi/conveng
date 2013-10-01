// Register Files
`include "params.v"

module shift2drf
(
	input											clk,
	input			`SHIFT_RF_2D_ROW_WORD	data,
	
	input											reset,
	input											colShift,
	input											rowShift,
	
	output reg	`SHIFT_RF_2D_ROW_WORD	rf	[`SHIFT_RF_2D_ROW-1 : 0]

);

parameter numCol	= 18;
parameter numRow	= 16;
parameter numBits	= 10;

localparam rowSize = numCol*numBits;

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


endmodule

