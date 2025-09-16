# 19-Bit-CPU-Verilog
Basic computer with a 19 bit instruction size and 4096 Memory locations. The following CPU can perform various arithmetic, logical, encryption and decryption operations. Input is provided by the user storing instructions in the memory.

In the designed CPU, User Registers C,D,E and F are designed to be user accessible with the help of Insructions given by user that are stored in the memory locations.
Timelapse for the coding and design process - https://youtu.be/x6ywrpuxJe8

The attached files in DOCS folder with their respecive description - 

CPU-Architecture.jpg - Shows all the major components of the system along with the control and data lines between them.

ISA_1.jpg and ISA_2.jpg - Shows a comprehensive list of all micro-operations performed by each of the provided instruction. On the ISA_2.jpg file, there is also a table given which shows how all the Assembly Level instrucitons provided by the user are to be translated into machine level binary.

InstructionGenerator.xlsx - Used to generate machine level code for the desired Instruction. 

CU_LOGIC_1.jpg and CU_LOGIC_2.jpg - Shows all the logic behind each control signal.

OutputWaveForm.png - Screenshot of the output waveform. To generate a simulation wave form with all major signals visible, a new text fixture was created labelled as CPU_TEST.v Inside this test fixture all the components and connections of the CPU have been initialized and the following program has been stored in the memory.

Location|	Instruction	       | Binary

00 &emsp;  LD C, 004 	&emsp; &emsp; 0110000000000000100

01 &emsp; LD D, 005   &emsp; &emsp; 0110100000000000101 

02 &emsp; MUL F,C,D 	&emsp; &emsp; 1110000000001110001 

03 &emsp; JMP 000 		&emsp; &emsp; 0010000000000000000 

04 &emsp; (Decimal Value 4)&emsp; 0000000000000000100  

05 &emsp; (Decimal Value 7)&emsp;	0000000000000000111

The Output waveform shows how the values get loaded into the UserRegC and UserRegD and are then multiplied and stored into UserRegF. (Observing the last 8 signals of the outpu waveform, one can see that values get loaded in the register C,D and F when the load signal goes high.)

The CPU can also be programmed in Assembly by simply editing the file AssemblyProgram.txt

Post the assembly program, run the script ./compileScript.tcl

This script will generate the binary and store it into mem_init.txt

Once this is done CPU_MAIN.v can be simulated in desired simulator and the output of the program can be observed.
