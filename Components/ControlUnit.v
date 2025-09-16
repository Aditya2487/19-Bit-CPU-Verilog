// Control Unit
module ControlUnit(
	output 	LD_AR,
	LD_PC,
	INC_PC,
	LD_DR,
	LD_AC,
	LD_IR,
	LD_RegC,
	INC_RegC,
	DEC_RegC,
	LD_RegD,
	INC_RegD,
	DEC_RegD,
	LD_RegE,
	INC_RegE,
	DEC_RegE,
	LD_RegF,
	INC_RegF,
	DEC_RegF,
	STK_PUSH,
	STK_POP,
	MEM_RD,
	MEM_WR,
	SC_CLR,
	ALU_ADD,ALU_SUB,ALU_MUL,ALU_DIV,ALU_AND,ALU_OR,ALU_XOR,ALU_NOT,ALU_FFT,ALU_ENC,ALU_DNC,ALU_TNF,
	BUS1_AR , BUS2_PC, BUS4_AC , BUS6_IR , BUS7_MEM ,  BUS8_STK , BUS12_RegC , BUS13_RegD , BUS14_RegE ,BUS15_RegF , 
	input		T0,T1,T2,T3,T4,T5,T6,
	input		[7:0]D1,
	input 	[3:0]Dv,
	input 	[3:0]Dw,
	input 	[15:0]D2,
	input 	[3:0]Dx,
	input 	[3:0]Dy,
	input 	[3:0]Dz,
	input		[18:0] DR,
	input		[18:0] AC
);

wire CSF;
wire A3O;
wire Eq;

Equality_Detector Eq_Module (.DR(DR), .AC(AC), .EQ(Eq));

assign CSF = D2[11] || D2[12] || D2[13] ;
assign A3O = D2[1] || D2[2] || D2[3] || D2[4] || D2[7] || D2[8] || D2[9] ;

/////////////////////////////////////////////////////////////////////////

assign LD_AR = T0 || 
	( ( ~D1[7] ) && T2 ) ||
	( D1[7] && CSF  && ( T2 || T5 ) ) ;

assign LD_PC = ( T3 && D1[1] ) ||
	( T4 && D1[2] ) ||
	( T6 && D1[5] && Eq ) || 
	( T6 && D1[6] && (~Eq) ) || 
	( T2 && D1[7] && D2[14] ) ;			
assign INC_PC = T1 ;

assign LD_DR =  ( ( T3 || T5 ) && ( D1[5] || D1[6] ) ) ||
	( D1[7] && T2 && D2[10] ) ||
	( D1[7] && T3 && CSF ) ||
	( D1[7] && ( T2 || T4 ) && A3O );

assign LD_AC =  (  T4 && ( D1[5] || D1[6] ) ) ||
	( D1[7] && T3 && D2[10] ) ||
	( D1[7] && T4 && CSF ) ||
	( D1[7] && ( T3 || T5 ) && A3O );
assign LD_IR = T1 ;

////////////////////////////////////////////////////////////////////////
assign LD_RegC = ( D1[3] && T3 && Dv[0] ) ||
	( D1[7] && T4 && D2[10] && Dx[0] ) ||
	( D1[7] && T6 &&  A3O && Dx[0] );					  
assign INC_RegC = D1[7] && T2 && D2[5] && Dx[0] ; 

assign DEC_RegC = D1[7] && T2 && D2[6] && Dx[0] ; 		
///////////////////////////////////////////////////////////////////////
assign LD_RegD = ( D1[3] && T3 && Dv[1] ) ||
	( D1[7] && T4 && D2[10] && Dx[1] ) ||
	( D1[7] && T6 &&  A3O && Dx[1] );
assign INC_RegD = D1[7] && T2 && D2[5] && Dx[1] ; 

assign DEC_RegD = D1[7] && T2 && D2[6] && Dx[1] ; 					 

////////////////////////////////////////////////////////////////////////
assign LD_RegE = ( D1[3] && T3 && Dv[2] ) ||
	( D1[7] && T4 && D2[10] && Dx[2] ) ||
	( D1[7] && T6 &&  A3O && Dx[2] );
assign INC_RegE = D1[7] && T2 && D2[5] && Dx[2] ; 

assign DEC_RegE = D1[7] && T2 && D2[6] && Dx[2] ; 					 

////////////////////////////////////////////////////////////////////////
assign LD_RegF = ( D1[3] && T3 && Dv[3] ) ||
	( D1[7] && T4 && D2[10] && Dx[3] ) ||
	( D1[7] && T6 &&  A3O && Dx[3] );
assign INC_RegF = D1[7] && T2 && D2[5] && Dx[3] ; 

assign DEC_RegF = D1[7] && T2 && D2[6] && Dx[3] ; 					 

////////////////////////////////////////////////////////////////////////
assign STACK_PUSH = T3 && D1[2] ; 					 

assign STACK_POP = T2 && D1[7] && D2[14]; 					 
assign MEM_RD = T1 || ( T3 && D1[3] ) || ( T3 && D1[7] && CSF ) ;

assign MEM_WR = ( T3 && D1[4] ) || ( T6 && D1[7] && CSF ) ;

assign SC_CLR =( T3 && D1[1] ) ||
	( T4 && D1[2] ) ||
	( T3 && ( D1[3] || D1[4] ) ) ||
	( T6 && ( D1[5] || D1[6] ) ) ||
	( D1[7] && ( T6 || ( T4 && D2[10] ) || (T2 && ( D2[5] || D2[6] || D2[14]) ) ) );
assign ALU_TNF = ( T4 && ( D1[5] || D1[6] ) ) ||
	( T3 && D1[7] && A3O ) ;
assign ALU_ADD = D1[7] && T5 && D2[1];

assign ALU_SUB = D1[7] && T5 && D2[2];

assign ALU_MUL = D1[7] && T5 && D2[3];

assign ALU_DIV = D1[7] && T5 && D2[4];

assign ALU_AND = D1[7] && T5 && D2[7];

assign ALU_OR  = D1[7] && T5 && D2[8];

assign ALU_XOR = D1[7] && T5 && D2[9];

assign ALU_NOT = D1[7] && T3 && D2[10];

assign ALU_FFT = D1[7] && T4 && D2[11];

assign ALU_ENC = D1[7] && T4 && D2[12];

assign ALU_DNC = D1[7] && T4 && D2[13];				 

///////////////////////////////////////////////////////////////////////
assign BUS1_AR = ( T3 && D1[1] ) ||
	( T4 && D1[2] ) ||
	( T6 && D1[5] && Eq ) ||
	( T6 && D1[6] && (~Eq) ) ; 
assign BUS2_PC = T0 || ( T2 && D1[2]) ;

assign BUS4_AC = D1[7] && ( T6 || ( T4 && D2[10] )) ;

assign BUS6_IR = (~D1[7]) && T2 ;

assign BUS7_MEM = T1 || ( T3 && D1[3] ) ||  ( D1[7] && T3 && CSF ) ;

assign BUS8_STK =  T2 && D1[7] && D2[14] ;

assign BUS12_RegC = ( T3 && Dv[0] && ( D1[4] || D1[5] || D1[6]) ) ||
	( T5 && Dw[0] && ( D1[5] || D1[6]) ) ||
	( D1[7] && T2 && Dy[0] && ( ~ D2[14]) ) ||
	( D1[7] && T4 && Dz[0] && A3O ) ||
	( D1[7] && T5 && Dx[0] && CSF );

assign BUS13_RegD = ( T3 && Dv[1] && ( D1[4] || D1[5] || D1[6]) ) ||
	( T5 && Dw[1] && ( D1[5] || D1[6]) ) ||
	( D1[7] && T2 && Dy[1] && ( ~ D2[14]) ) ||
	( D1[7] && T4 && Dz[1] && A3O ) ||
	( D1[7] && T5 && Dx[1] && CSF );

assign BUS14_RegE = ( T3 && Dv[2] && ( D1[4] || D1[5] || D1[6]) ) ||
	( T5 && Dw[2] && ( D1[5] || D1[6]) ) ||
	( D1[7] && T2 && Dy[2] && ( ~ D2[14]) ) ||
	( D1[7] && T4 && Dz[2] && A3O ) ||
	( D1[7] && T5 && Dx[2] && CSF );
assign BUS15_RegF = ( T3 && Dv[3] && ( D1[4] || D1[5] || D1[6]) ) ||
	( T5 && Dw[3] && ( D1[5] || D1[6]) ) ||
	( D1[7] && T2 && Dy[3] && ( ~ D2[14]) ) ||
	( D1[7] && T4 && Dz[3] && A3O ) ||
	( D1[7] && T5 && Dx[3] && CSF );

endmodule

module Equality_Detector( 
	input [18:0] DR,
	input [18:0] AC,
	output EQ
	    );

assign EQ = &(AC ~^ DR );

endmodule


