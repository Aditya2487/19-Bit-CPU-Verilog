////////// Memory /////////////////////////////////

module MEM_4K_19Bit(
	input [11:0] addr,
	input rd,wr,
	input [18:0] dataIn,
	output reg [18:0] dataOut );



reg [18:0] mem [0:4095];


always @(*)
begin
	if( rd == 1'b1 && wr == 1'b0 )
		begin
		dataOut <= mem[addr];
		end
	else if ( rd == 1'b0 && wr == 1'b1 )
		begin
		mem[addr] <= dataIn;
		end
	else
		begin
		dataOut <= 19'bz;
		end
end

initial begin
  $readmemb("mem_init.txt", mem);
  end
endmodule
