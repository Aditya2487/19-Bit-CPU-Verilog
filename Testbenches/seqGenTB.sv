
`include "cmpts/Seq_Gen.v"

module seqGenTB;
reg clk,rst;
wire [7:0] OP1;
wire [15:0] OP2;
wire [18:0] OP3;

SeqGenN #(8)(clk,rst,OP1);

SeqGenN #(16)(clk,rst,OP2);

SeqGenN #(19)(clk,rst,OP3);

initial begin
	clk = 0 ;
	rst = 0;
end

always begin
	#5 clk = ~ clk ;
end


initial begin
	#22 rst = 1 ; #10 rst = 0 ;
end
initial begin
	#225 rst =1 ; #5 rst = 0;
end
initial begin
	#600 rst = 1 ; #5 rst = 0;
end

initial begin
	$monitor($time,"| rst - %d | OP1 - %b | OP2 - %b | OP3 - %b | ", rst,OP1,OP2,OP3 );
	#1000 $finish;
end

endmodule
