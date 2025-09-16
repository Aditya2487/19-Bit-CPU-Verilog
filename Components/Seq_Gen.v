// Parameterised Sq Generator
//
//

module SeqGenN #(parameter N = 16) (
       				input CLK , RESET ,
				output reg [(N-1) : 0] OP_SIG  );

initial begin
	OP_SIG <= 1;
end

always @(posedge CLK)
	if(RESET) begin
	OP_SIG <= 1;
	end
	else begin
	OP_SIG <= ( OP_SIG[N-1] == 1 ) ? 1 : OP_SIG << 1 ;
	end

endmodule








