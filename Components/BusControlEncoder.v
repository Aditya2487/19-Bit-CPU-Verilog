




module BusControlEncoder(
	input x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,
	output reg s3,s2,s1,s0
);


always @(*)
begin
	case({x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15})
	16'h8000: {s3,s2,s1,s0} = 4'h0;
	16'h4000: {s3,s2,s1,s0} = 4'h1;
	16'h2000: {s3,s2,s1,s0} = 4'h2;
	16'h1000: {s3,s2,s1,s0} = 4'h3;
	16'h0800: {s3,s2,s1,s0} = 4'h4;
	16'h0400: {s3,s2,s1,s0} = 4'h5;
	16'h0200: {s3,s2,s1,s0} = 4'h6;
	16'h0100: {s3,s2,s1,s0} = 4'h7;
	16'h0080: {s3,s2,s1,s0} = 4'h8;
	16'h0040: {s3,s2,s1,s0} = 4'h9;
	16'h0020: {s3,s2,s1,s0} = 4'ha;
	16'h0010: {s3,s2,s1,s0} = 4'hb;
	16'h0008: {s3,s2,s1,s0} = 4'hc;
	16'h0004: {s3,s2,s1,s0} = 4'hd;
	16'h0002: {s3,s2,s1,s0} = 4'he;
	16'h0001: {s3,s2,s1,s0} = 4'hf;
	default : {s3,s2,s1,s0} = 4'h0;
	endcase
end


endmodule
