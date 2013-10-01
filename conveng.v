`include "params.v"

module conveng
(
	input										clk,
	input										reset,
	input		`SHIFT_RF_2D_ROW_WORD	data,
	input										colShift,
	input										rowShift,

	output	`SHIFT_RF_2D_ROW_WORD	res	[`SHIFT_RF_2D_ROW-1 : 0]
);


shift2drf	#(.numCol(`SHIFT_RF_2D_COL), .numRow(`SHIFT_RF_2D_ROW), .numBits(`DATA_WIDTH)) 
shift2drf
(
	.clk			(clk),
	.data			(data),
	
	.reset		(reset),
	.colShift	(colShift),
	.rowShift	(rowShift),
	
	.rf			(res)
);


endmodule
