//Stack
module Stack_19X32(
	input [18:0] inpData,
	input PUSH,POP,CLR,
	output reg [18:0] opData);

reg [18:0] stackData [0:31];
reg [4:0] stackPointer;
integer i;
initial
begin
	opData <= 19'd0;
	stackPointer <= 5'b00000;

end

always @(posedge PUSH or posedge POP or posedge CLR)
begin
	if(PUSH)
	begin
		stackData[stackPointer] = inpData;
		stackPointer = stackPointer + 1 ;
	end
	else if (POP)
	begin
		stackPointer = stackPointer - 1 ;
		opData = stackData[stackPointer];
	end
	else if (CLR)
	begin
		stackPointer <= 5'b0;
		for( i = 0 ; i<32 ; i = i + 1 )
		begin
		stackData[i] = 19'd0;
		end
		opData = 19'd0;
	end
end
endmodule


