`timescale 1ns/1ps

module tb();

logic					clk;
logic					reset;
logic		[179:0]	data;
logic					colShift;
logic					rowShift;

logic		[9:0]		res;

logic signed	[34:0]	data_o;

conveng dut ( .* );

initial clk = '1;
always #2.5 clk = ~clk;  // 200 MHz clock
integer i;

logic unsigned		[7:0]		tmp;

initial begin
	reset = 1'b1;
	colShift = 0;
	rowShift = 0;
	
	@(negedge clk);
	reset = 1'b0;	
	
	for (i = 0; i < 16; i++) begin
		@(negedge clk);
		rowShift = 1;
		tmp = i;
		data = {{22{tmp}}, {4'hF}};
	end
	
	for (i = 0; i < 18; i++) begin
		@(negedge clk);
		rowShift = 0;
		colShift = 1;
	end
	
	@(negedge clk);
	colShift = 0;	
	rowShift = 1;
	
	tmp = 8'hEA;
	data = {{22{tmp}}, {4'hF}};
	
	@(negedge clk);
	rowShift = 0;
	
	
	#300
	$stop(0);
end

endmodule
