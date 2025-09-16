


module Bus_16X1_19bit(
	input [18:0] busInput0,	
	input [18:0] busInput1,	
	input [18:0] busInput2,	
	input [18:0] busInput3,	
	input [18:0] busInput4,	
	input [18:0] busInput5,	
	input [18:0] busInput6,	
	input [18:0] busInput7,	
	input [18:0] busInput8,	
	input [18:0] busInput9,	
	input [18:0] busInput10,	
	input [18:0] busInput11,	
	input [18:0] busInput12,	
	input [18:0] busInput13,	
	input [18:0] busInput14,	
	input [18:0] busInput15,	
	input s3,s2,s1,s0,
	output [18:0] busOutput
);	


assign  busOutput = ( 
			{s3,s2,s1,s0} == 4'h0 ? busInput0 :
			{s3,s2,s1,s0} == 4'h1 ? busInput1 :
			{s3,s2,s1,s0} == 4'h2 ? busInput2 :
			{s3,s2,s1,s0} == 4'h3 ? busInput3 :
			{s3,s2,s1,s0} == 4'h4 ? busInput4 :
			{s3,s2,s1,s0} == 4'h5 ? busInput5 :
			{s3,s2,s1,s0} == 4'h6 ? busInput6 :
			{s3,s2,s1,s0} == 4'h7 ? busInput7 :
			{s3,s2,s1,s0} == 4'h8 ? busInput8 :
			{s3,s2,s1,s0} == 4'h9 ? busInput9 :
			{s3,s2,s1,s0} == 4'ha ? busInput10 :
			{s3,s2,s1,s0} == 4'hb ? busInput11 :
			{s3,s2,s1,s0} == 4'hc ? busInput12 :
			{s3,s2,s1,s0} == 4'hd ? busInput13 :
			{s3,s2,s1,s0} == 4'he ? busInput14 :
			{s3,s2,s1,s0} == 4'hf ? busInput15 : busInput0	);


endmodule
