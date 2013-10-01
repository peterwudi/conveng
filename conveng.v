
module conveng
(
	input				clk,
	input				reset,
	input		[179:0]	data,
	input				colShift,
	input				rowShift,

	output	[9:0]	res
);

rf2d	#(.numCol(18), .numRow(16), .numBits(10)) 
rf2d
(
	.clk			(clk),
	.data			(data),
	
	.reset		(reset),
	.colShift	(colShift),
	.rowShift	(rowShift),
	
	.res			(res)
);


endmodule
