//////// 19 Bit register ///////

module UserRegister_19Bit(
	input [18:0] inpData,
	input LOAD,INC,DEC,CLR,
	input CLK,
	output reg [18:0] opData);

initial begin
	opData = 19'd0;
end

always @(negedge CLK) begin
	if( CLR == 1'b1) begin
	opData <= 19'd0;
	end
	else if (LOAD == 1'b1) begin
	opData <= inpData ;
	end
	else if (INC == 1'b1) begin
	opData <= opData + 1 ;
	end
	else if (DEC == 1'b1) begin
	opData <= opData - 1;
	end
	else begin
		opData <= opData;
	end
end

endmodule

