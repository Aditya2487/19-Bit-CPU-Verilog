// Parameterized Decoder , Defaults to 3X8 decoder, N can be varied for
// different values

module Deco_NX2PN #(parameter N = 3) (
		input [ (N-1):0 ] select,
		output [ ( (1<<N)-1 ) :0] decoded_op
	);

assign decoded_op = 1 << select ; //Shifting 1 by N bits.

endmodule








