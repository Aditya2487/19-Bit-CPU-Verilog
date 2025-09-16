#!/usr/bin/tclsh
#TCL Script to read file , store it in an array

exec  rm -rf simv.daidir/.vcs.timestamp dump.vcd dump.vcd.fsdb ./simv mem_init.txt
proc toBinary { number width } {
	return [format "%0${width}b" $number]
}
proc giveReg { regStr } {
	if { [string match $regStr "C"] } {
       	return "00"
	} elseif { [string match $regStr "D"] } {
       	return "01"
	} elseif { [string match $regStr "E"] } {
       	return "10"
	} elseif { [string match $regStr "F"] } {
       	return "11"
	}
}
set filename "AssemblyProgram.txt"
set fileHandler [ open $filename r]
set opFile "mem_init.txt"
set fileHnd2 [open $opFile w]
set lineNumb 0

while { [gets $fileHandler fileLine] != -1 }  {
	#puts " LiNum: $lineNumb || Line - $fileLine "
	set instr [lindex $fileLine 0]
	set bin ""
	if { [string match $instr "LD"] } {
		append bin "011"
		set reg [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg}"
		append bin "00"
		set addr [ toBinary [lindex [split [lindex $fileLine 1] ","] 1] 12 ]
		append bin "${addr}"			
	} elseif { [string match $instr "ST"] } {
		append bin "100"
		set reg [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg}"
		append bin "00"
		set addr [ toBinary [lindex [split [lindex $fileLine 1] ","] 0] 12 ]
		append bin "${addr}"			
	} elseif { [string match $instr "BEQ"] } {
		append bin "101"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		set addr [ toBinary [lindex [split [lindex $fileLine 1] ","] 2] 12 ]
		append bin "${addr}"			
	} elseif { [string match $instr "BNQ"] } {
		append bin "110"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		set addr [ toBinary [lindex [split [lindex $fileLine 1] ","] 2] 12 ]
		append bin "${addr}"			
	} elseif { [string match $instr "CALL"] } {
		append bin "010"
		append bin "0000"
		set addr [ toBinary [lindex $fileLine 1]  12 ]
		append bin "${addr}"			
	} elseif { [string match $instr "JMP"] } {
		append bin "001"
		append bin "0000"
		set addr [ toBinary [lindex $fileLine 1]  12 ]
		append bin "${addr}"			
	} elseif { [string match $instr "MUL"] } {
		append bin "111000000"
		append bin "0011"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		set reg3 [ giveReg [lindex [split [lindex $fileLine 1] ","] 2] ]
		append bin "${reg3}"
	} elseif { [string match $instr "ADD"] } {
		append bin "111000000"
		append bin "0001"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		set reg3 [ giveReg [lindex [split [lindex $fileLine 1] ","] 2] ]
		append bin "${reg3}"
	} elseif { [string match $instr "SUB"] } {
		append bin "111000000"
		append bin "0010"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		set reg3 [ giveReg [lindex [split [lindex $fileLine 1] ","] 2] ]
		append bin "${reg3}"
	} elseif { [string match $instr "DIV"] } {
		append bin "111000000"
		append bin "0100"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		set reg3 [ giveReg [lindex [split [lindex $fileLine 1] ","] 2] ]
		append bin "${reg3}"
	} elseif { [string match $instr "AND"] } {
		append bin "111000000"
		append bin "0111"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		set reg3 [ giveReg [lindex [split [lindex $fileLine 1] ","] 2] ]
		append bin "${reg3}"
	} elseif { [string match $instr "OR"] } {
		append bin "111000000"
		append bin "1000"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		set reg3 [ giveReg [lindex [split [lindex $fileLine 1] ","] 2] ]
		append bin "${reg3}"
	} elseif { [string match $instr "XOR"] } {
		append bin "111000000"
		append bin "1001"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		set reg3 [ giveReg [lindex [split [lindex $fileLine 1] ","] 2] ]
		append bin "${reg3}"
	} elseif { [string match $instr "NOT"] } {
		append bin "111000000"
		append bin "1010"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		append bin "00"
	} elseif { [string match $instr "FFT"] } {
		append bin "111000000"
		append bin "1011"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		append bin "00"
	} elseif { [string match $instr "ENC"] } {
		append bin "111000000"
		append bin "1100"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		append bin "00"
	} elseif { [string match $instr "DNC"] } {
		append bin "111000000"
		append bin "1101"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		set reg2 [ giveReg [lindex [split [lindex $fileLine 1] ","] 1] ]
		append bin "${reg2}"
		append bin "00"
	} elseif { [string match $instr "INC"] } {
		append bin "111000000"
		append bin "0101"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		append bin "0000"
	} elseif { [string match $instr "DEC"] } {
		append bin "111000000"
		append bin "0110"
		set reg1 [ giveReg [lindex [split [lindex $fileLine 1] ","] 0] ]
		append bin "${reg1}"
		append bin "0000"
	} elseif { [string match $instr "RET"] } {
		append bin "111000000"
		append bin "1110"
		append bin "000000"
	} else {
		if { [string length $instr] == 0 } {
			append bin [ toBinary 0 19 ]
		} else {
			append bin [ toBinary $instr 19 ]
		}
	}

	puts $fileHnd2 "$bin"
	incr lineNumb
}
close $fileHnd2
close $fileHandler


