`include "Components/ALU.v"  
`include "Components/BusControlEncoder.v"
`include "Components/commonBus16X1.v"  
`include "Components/ControlUnit.v"
`include "Components/DecoderNX2PN.v"  
`include "Components/MEM_4K_19Bit.v"  
`include "Components/Register12Bit.v"  
`include "Components/Register19Bit.v" 
`include "Components/Seq_Gen.v"  
`include "Components/STACK_19BIT_32L.v"

module CPU_MAIN ();
reg CLK;
wire [11:0] AR_OP, PC_OP;
wire [18:0] busOP, IR_OP, DR_OP, AC_OP, RegC_OP, RegD_OP, RegE_OP, RegF_OP, Mem_OP, Stack_OP, ALU_OP ;
wire IR_LD, IR_INC, IR_DEC, IR_CLR,
     AR_LD, AR_INC, AR_DEC, AR_CLR,
     DR_LD, DR_INC, DR_DEC, DR_CLR,
     AC_LD, AC_INC, AC_DEC, AC_CLR,
     PC_LD, PC_INC, PC_DEC, PC_CLR,
     RegC_LD, RegC_INC, RegC_DEC, RegC_CLR,
     RegD_LD, RegD_INC, RegD_DEC, RegD_CLR,
     RegE_LD, RegE_INC, RegE_DEC, RegE_CLR,
     RegF_LD, RegF_INC, RegF_DEC, RegF_CLR;

wire MEM_RD, MEM_WR, STK_PUSH, STK_POP, STK_CLR;
wire OVF_FLG,CT_ADD,CT_SUB,CT_MUL,CT_DIV,CT_AND,CT_OR,CT_XOR,CT_NOT,CT_INC,
	CT_DEC,CT_FFT,CT_ENC,CT_DNC,CT_TNF;
wire [7:0] D1;
wire [15:0] D2;
wire [3:0] Dv,Dw,Dx,Dy,Dz;
wire s3,s2,s1,s0;
wire SC_CLR;
wire [7:0] T_SGN;
wire  BUS1_AR , BUS2_PC, BUS4_AC , BUS6_IR , BUS7_MEM ,  BUS8_STK , BUS12_RegC , BUS13_RegD , BUS14_RegE, BUS15_RegF ;
UserRegister_19Bit IR_19BIT(busOP,
			IR_LD,IR_INC,IR_DEC,IR_CLR,
			CLK,
			IR_OP);

Deco_NX2PN #(3) DecoD1(IR_OP[18:16],D1);
Deco_NX2PN #(2) DecoDv(IR_OP[15:14],Dv);
Deco_NX2PN #(2) DecoDw(IR_OP[13:12],Dw);
Deco_NX2PN #(4) DecoD2(IR_OP[9:6],D2);
Deco_NX2PN #(2) DecoDx(IR_OP[5:4],Dx);
Deco_NX2PN #(2) DecoDy(IR_OP[3:2],Dy);
Deco_NX2PN #(2) DecoDz(IR_OP[1:0],Dz);

UserRegister_19Bit DR_19BIT(busOP,
			DR_LD,DR_INC,DR_DEC,DR_CLR,
			CLK,
			DR_OP);

UserRegister_19Bit AC_19BIT(ALU_OP,
			AC_LD,AC_INC,AC_DEC,AC_CLR,
			CLK,
			AC_OP);

UserRegister_12Bit AR_12BIT(busOP[11:0],
			AR_LD,AR_INC,AR_DEC,AR_CLR,
			CLK,
			AR_OP);

UserRegister_12Bit PC_12BIT(busOP[11:0],
			PC_LD,PC_INC,PC_DEC,PC_CLR,
			CLK,
			PC_OP);

		////////////// USer Registers
UserRegister_19Bit RegC_19BIT(busOP,
			RegC_LD,RegC_INC,RegC_DEC,RegC_CLR,
			CLK,
			RegC_OP);
UserRegister_19Bit RegD_19BIT(busOP,
			RegD_LD,RegD_INC,RegD_DEC,RegD_CLR,
			CLK,
			RegD_OP);
UserRegister_19Bit RegE_19BIT(busOP,
			RegE_LD,RegE_INC,RegE_DEC,RegE_CLR,
			CLK,
			RegE_OP);
UserRegister_19Bit RegF_19BIT(busOP,
			RegF_LD,RegF_INC,RegF_DEC,RegF_CLR,
			CLK,
			RegF_OP);

	////////// memory and Stack
Stack_19X32 stack01( busOP,
			STK_PUSH, STK_POP, STK_CLR,
			Stack_OP);

MEM_4K_19Bit memory01(AR_OP,MEM_RD,MEM_WR,busOP,Mem_OP);

///////////////////////// ALU ////////////////////

ALU_19Bit ALU_MAIN (AC_OP,DR_OP,
	CT_ADD,CT_SUB,CT_MUL,CT_DIV,CT_AND,CT_OR,CT_XOR,CT_NOT,CT_INC,
	CT_DEC,CT_FFT,CT_ENC,CT_DNC,CT_TNF,
	ALU_OP,OVF_FLG);


//////////////////////////////// Bus Multipxes
BusControlEncoder BusEncoder( 
	1'b0,
	BUS1_AR , BUS2_PC, 1'b0, BUS4_AC , 1'b0, BUS6_IR , BUS7_MEM ,  
	BUS8_STK , 1'b0, 1'b0, 1'b0, BUS12_RegC , BUS13_RegD , BUS14_RegE ,BUS15_RegF ,
	s3,s2,s1,s0);
Bus_16X1_19bit busMultiplexer( 19'd0,{7'b0000_000,AR_OP}, {7'b0000_000,PC_OP}, 19'd0, AC_OP, 19'd0, IR_OP, Mem_OP,
				Stack_OP, 19'd0, 19'd0, 19'd0, RegC_OP, RegD_OP, RegE_OP, RegF_OP,
				s3,s2,s1,s0,
				busOP);
///////////////////////////////////////
SeqGenN #(8) seqGen1(CLK,SC_CLR,T_SGN);
/////////////

///////// CONTROL UNIT ////////////////////////

ControlUnit CU_MAIN(
	AR_LD,
	PC_LD,
	PC_INC,
	DR_LD,
	AC_LD,
	IR_LD,
	RegC_LD,
	RegC_INC,
	RegC_DEC,
	RegD_LD,
	RegD_INC,
	RegD_DEC,
	RegE_LD,
	RegE_INC,
	RegE_DEC,
	RegF_LD,
	RegF_INC,
	RegF_DEC,
	STK_PUSH,
	STK_POP,
	MEM_RD,
	MEM_WR,
	SC_CLR,
	CT_ADD,CT_SUB,CT_MUL,CT_DIV,CT_AND,CT_OR,CT_XOR,CT_NOT,CT_FFT,CT_ENC,CT_DNC,CT_TNF,
	BUS1_AR , BUS2_PC, BUS4_AC , BUS6_IR , BUS7_MEM ,
	BUS8_STK , BUS12_RegC , BUS13_RegD , BUS14_RegE ,BUS15_RegF,
	T_SGN[0],T_SGN[1],T_SGN[2],T_SGN[3],T_SGN[4],T_SGN[5],T_SGN[6],
	D1,Dv,Dw,D2,Dx,Dy,Dz,
	DR_OP,AC_OP);
//// Pulldown unused signals


assign {DR_INC,DR_DEC,DR_CLR,IR_INC,IR_DEC,IR_CLR,AC_INC,AC_DEC,AC_CLR,AR_INC,AR_DEC,AR_CLR,PC_DEC,PC_CLR,RegC_CLR,RegD_CLR,RegE_CLR,RegF_CLR,STK_CLR} = 0;

////////////////////////////////////////////////
initial 
begin
	CLK = 1'b0;
	#10;
	forever #10 CLK = ~CLK;
end
initial begin
$dumpfile("dump.vcd");
$dumpvars();
end
initial begin
	#1600 $finish();
end
///////////////////////////////



endmodule

