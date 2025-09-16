////////////////////ALU

module ALU_19Bit( input [18:0] AC, DR ,
		  input ADD,
		  	SUB,
			MUL,
			DIV,
			AND,
			OR,
			XOR,
			NOT,
			INC,
			DEC,
			FFT,
			ENC,
			DNC,
			TNF,
		output reg [18:0] ALU_OP,
		output reg OVF_FLAG
	 		);

wire [18:0] enc_op;
wire [18:0] dnc_op;

reg [37:0] tempAC;
reg [37:0] tempDR;
reg [37:0] tempProduct;




ENC_MODULE enc_mod (
	.input_data(DR), 
	.output_data(enc_op)
);


DNC_MODULE dnc_mod (
	.input_data(DR), 
	.output_data(dnc_op)
);

initial 
begin
	ALU_OP = 19'b0;
	OVF_FLAG = 1'b0;
	tempProduct = 38'b0;

end
always @(*)
begin
	if(ADD)
	begin
		tempProduct = 37'b0;
		ALU_OP = AC + DR ;
		OVF_FLAG = (	(~AC[18])&(~DR[18])&(ALU_OP[18])	) 
			| (	(AC[18])&(DR[18])&(~ALU_OP[18])	); 
	end
	else if (SUB)
	begin
		tempProduct = 37'b0;
		ALU_OP = AC - DR;
		OVF_FLAG = (	(AC[18])&(~DR[18])&(~ALU_OP[18])	) 
			| (	(~AC[18])&(DR[18])&(ALU_OP[18])	); 
	end
	else if (MUL)
	begin
		tempAC[18:0] = AC; 
		tempAC[37:19] = {AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18],AC[18]}; 
		tempDR[18:0] = DR; 
		tempDR[37:19] = {DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18],DR[18]};
		tempProduct = (tempAC *tempDR) ;
		ALU_OP = tempProduct;
		OVF_FLAG = &tempProduct[37:18] ^ |tempProduct[37:18] ;
	end
	else if (DIV)
	begin
		tempProduct = 37'b0;
		if(DR != 0 )
		begin
			ALU_OP = AC / DR;
			OVF_FLAG = 1'b0;
		end
		else
		begin
			ALU_OP = 19'b0;
			OVF_FLAG = 1'b0;
		end
	end
	else if (AND)
	begin
		tempProduct = 37'b0;
		ALU_OP = AC & DR;
		OVF_FLAG = 1'b0;
	end
	else if (OR)
	begin
		tempProduct = 37'b0;
		ALU_OP = AC | DR;
		OVF_FLAG = 1'b0;
	end
	else if (XOR)
	begin
		tempProduct = 37'b0;
		ALU_OP = AC ^ DR;
		OVF_FLAG = 1'b0;
	end
	else if (NOT)
	begin
		tempProduct = 37'b0;
		ALU_OP = ~DR;
		OVF_FLAG = 1'b0;
	end
	else if (INC)
	begin
		tempProduct = 37'b0;
		ALU_OP = AC + 1 ;
		OVF_FLAG = 1'b0;
	end
	else if (DEC)
	begin
		tempProduct = 37'b0;
		ALU_OP = AC - 1;
		OVF_FLAG = 1'b0;
	end
	else if (FFT)
	begin
		tempProduct = 37'b0;
		ALU_OP = 19'b0 ;
		OVF_FLAG = 1'b0;
	end
	else if (ENC)
	begin
		tempProduct = 37'b0;
		ALU_OP = enc_op ;
		OVF_FLAG = 1'b0;
	end
	else if (DNC)
	begin
		tempProduct = 37'b0;
		ALU_OP = dnc_op;
		OVF_FLAG = 1'b0;
	end
	else if (TNF)
	begin
		tempProduct = 37'b0;
		ALU_OP = DR;
		OVF_FLAG = 1'b0;
	end
	else 
	begin
		tempProduct = 37'b0;
		ALU_OP = 19'b0;
		OVF_FLAG = 1'b0;
	end
end	

endmodule

 ////////////////////////////      ENCRYPTER MODULE
 /////////////////////////////////////////

 module ENC_MODULE(
	input [18:0] input_data,
	output [18:0] output_data
);

wire[18:0] temp;

assign temp[18] 	= ~input_data[18];
assign temp[17] 	= input_data[1];
assign temp[16] 	= ~input_data[16];
assign temp[15] 	= input_data[3];
assign temp[14] 	= ~input_data[14];
assign temp[13] 	= input_data[5];
assign temp[12] 	= ~input_data[12];
assign temp[11] 	= input_data[7];
assign temp[10] 	= ~input_data[10];
assign temp[9] 	= input_data[9];
assign temp[8] 	= ~input_data[8];
assign temp[7] 	= input_data[11];
assign temp[6] 	= ~input_data[6];
assign temp[5] 	= input_data[13];
assign temp[4] 	= ~input_data[4];
assign temp[3] 	= input_data[15];
assign temp[2] 	= ~input_data[2];
assign temp[1] 	= input_data[17];
assign temp[0] 	= ~input_data[0];

assign output_data = temp ^ 19'b1110011001011110010;

endmodule

/////////////////////////////////////////////////////////// DECRYPTER MODULE
//////////////////////////////////////

module DNC_MODULE(
	input [18:0] input_data,
	output [18:0] output_data
);

wire[18:0] temp;
assign temp = input_data ^ 19'b1110011001011110010;

assign output_data[18] 	= ~temp[18];
assign output_data[17] 	= temp[1];
assign output_data[16] 	= ~temp[16];
assign output_data[15] 	= temp[3];
assign output_data[14] 	= ~temp[14];
assign output_data[13] 	= temp[5];
assign output_data[12] 	= ~temp[12];
assign output_data[11] 	= temp[7];
assign output_data[10] 	= ~temp[10];
assign output_data[9] 	= temp[9];
assign output_data[8] 	= ~temp[8];
assign output_data[7] 	= temp[11];
assign output_data[6] 	= ~temp[6];
assign output_data[5] 	= temp[13];
assign output_data[4] 	= ~temp[4];
assign output_data[3] 	= temp[15];
assign output_data[2] 	= ~temp[2];
assign output_data[1] 	= temp[17];
assign output_data[0] 	= ~temp[0];



endmodule


