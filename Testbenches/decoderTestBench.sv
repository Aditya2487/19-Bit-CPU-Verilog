
`include "cmpts/DecoderNX2PN.v"

module decoTB;

reg [3:0] inp1;
wire [3:0] op1;
wire [7:0] op2;
wire [15:0] op3;

//2X4 Decoder
Deco_NX2PN #(.N(2)) d1 (.select(inp1[1:0]) , .decoded_op(op1) );

//3X8 Decoder
Deco_NX2PN #(.N(3)) d2 (.select(inp1[2:0]) , .decoded_op(op2) );

//4X16 Decoder
Deco_NX2PN #(.N(4)) d3 (.select(inp1[3:0]) , .decoded_op(op3) );

initial begin
	$monitor($time," | inp - %b | OP1 - %b | OP2 - %b | OP3 - %b ",inp1,op1,op2,op3);
	inp1= 4'd0;
	for( int i = 1 ;  i < 16 ; i ++ ) begin
		#5 inp1 = i; $display(" I - %0d ", i );
	end
	#5 $finish;
end


endmodule











