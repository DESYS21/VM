G2  	 .INT 	 2; 	 
G4  	 .INT 	 1; 	 
LF  	 .INT 	 10; 	 
UNDERFLOW  	 .BYT 	 U; 	 
UPSIZE  	 .INT 	 21; 	 // Character count for UNDERFLOW
OVERFLOW  	 .BYT 	 O; 	 
OFSIZE  	 .INT 	 20; 	 // Character count for OVERFLOW

// Start

// Main
		// get Func 'main' Code
 	MOV 	 R0 	 SP; 	 // [FRAME] Check for Stack Overflow 
ADI 	 R0 	 -12; 	  
CMP 	 R0 	 SL; 	  
BLT 	 R0 	 STOVERFLOW; 	  
MOV 	 R0 	 FP; 	 // [FRAME] get M0 Activation Record, store PFP 
MOV 	 FP 	 SP; 	 // [FRAME] Move Stack Pointer to Frame Pointer (push a stack frame) 
ADI 	 SP 	 -4; 	 // [FRAME]  
STR 	 R0 	 (SP); 	 // [FRAME] Storing Previous Frame Pointer 
ADI 	 SP 	 -4; 	 // [FRAME] Shift to 'this' spot 
LDA 	 TR 	 M0; 	 // [FRAME][this] For main, just load main's address 
STR 	 TR 	 (SP); 	 // [FRAME][this] Store it on the activation record 
ADI 	 SP 	 -4; 	 // [FRAME][this] Move to next available spot after 'this' 

		// get Func 'main' Code
 	MOV 	 R1 	 PC; 	 // [CALL] M0 Activation Record 
ADI 	 R1 	 40; 	 // [CALL]  
STR 	 R1 	 (FP); 	 // [CALL]  
JMP 	 M0; 		 // [CALL] Calling main function

		// get Quit Code
 	TRP 	 0; 		 // [QUIT] Quit program

		// get Func 'main' Code
M0 	ADI 	 SP 	 -12; 	 // [FUNC] Move SP to account for Locals and Temps 
		//  [FUNC] Function 'main' starts here


		// get Move Immediate Code
 	LDR 	 R3 	 2; 	 // [MOVEI] Loading global: 2 
MOV 	 TR 	 FP; 	 // [StoringRegister][L] Storing symbolId L1: x 
ADI 	 TR 	 -16; 	 // [StoringRegister][L] Shift to right place : memory 
STR 	 R3 	 (TR); 	 // [StoringRegister][L] 

		// get Move Immediate Code
 	LDR 	 R4 	 1; 	 // [MOVEI] Loading global: 1 
MOV 	 TR 	 FP; 	 // [StoringRegister][L] Storing symbolId L3: y 
ADI 	 TR 	 -20; 	 // [StoringRegister][L] Shift to right place : memory 
STR 	 R4 	 (TR); 	 // [StoringRegister][L] 

		// get Math Code - ADD
 	MOV 	 R5 	 FP; 	 // [LoadRegister][L] Load L1(x) from the stack 
ADI 	 R5 	 -16; 	 // [LoadRegister][L] 
LDR 	 R5 	 (R5); 	  
MOV 	 R6 	 FP; 	 // [LoadRegister][L] Load L3(y) from the stack 
ADI 	 R6 	 -20; 	 // [LoadRegister][L] 
LDR 	 R6 	 (R6); 	  
MOV 	 R7 	 FP; 	 // [LoadRegister][T] Load T5(x+y) from the stack 
ADI 	 R7 	 -12; 	 // [LoadRegister][T] 
LDR 	 R7 	 (R7); 	  
MOV 	 R7 	 R5; 	 // [MATH] Operation 
ADD 	 R7 	 R6; 	 // [MATH] ADD 
MOV 	 TR 	 FP; 	 // [StoringRegister][T] Storing symbolId T5: x+y 
ADI 	 TR 	 -12; 	 // [StoringRegister][T] Shift to right place : memory 
STR 	 R7 	 (TR); 	 // [StoringRegister][T] 

		// get Move Code
 	MOV 	 R9 	 FP; 	 // [LoadRegister][T] Load T5(x+y) from the stack 
ADI 	 R9 	 -12; 	 // [LoadRegister][T] 
LDR 	 R9 	 (R9); 	  
MOV 	 R8 	 R9; 	 // [MOVE] Operation 
MOV 	 TR 	 FP; 	 // [StoringRegister][L] Storing symbolId L1: x 
ADI 	 TR 	 -16; 	 // [StoringRegister][L] Shift to right place : memory 
STR 	 R8 	 (TR); 	 // [StoringRegister][L] 

		// get Write Code
 	MOV 	 R10 	 FP; 	 // [LoadRegister][L] Load L1(x) from the stack 
ADI 	 R10 	 -16; 	 // [LoadRegister][L] 
LDR 	 R10 	 (R10); 	  
MOV 	 TR 	 R10; 	 // [WRITE] Operation 
TRP 	 1; 		 // [WRITE] Type integer(1)

		// get Return Code
 	MOV 	 SP 	 FP; 	 // Check for Stack Underflow 
MOV 	 R11 	 SP; 	  
CMP 	 R11 	 SB; 	  
BGT 	 R11 	 STUNDERFLOW; 	  
LDR 	 R11 	 (FP); 	 // [RETURN] Start the return process 
MOV 	 R12 	 FP; 	 // [RETURN] 
ADI 	 R12 	 -4; 	 // [RETURN] 
LDR 	 FP 	 (R12); 	 // [RETURN] 
JMR 	 R11; 		 // [RETURN] Return to calling function

		// // If we hit any of this code we have a real problem

STOVERFLOW 	LDR 	 R2 	 OFSIZE; 	  
LDA 	 R1 	 OVERFLOW; 	  
PRTOVERFLOW 	LDB 	 TR 	 (R1); 	  
TRP 	 3; 		 
ADI 	 R2 	 -1; 	  
ADI 	 R1 	 1; 	  
BNZ 	 R2 	 PRTOVERFLOW; 	  
TRP 	 0; 		 

STUNDERFLOW 	LDR 	 R2 	 UPSIZE; 	  
LDA 	 R1 	 UNDERFLOW; 	  
PRTUNDERFLOW 	LDB 	 TR 	 (R1); 	  
TRP 	 3; 		 
ADI 	 R2 	 -1; 	  
ADI 	 R1 	 1; 	  
BNZ 	 R2 	 PRTUNDERFLOW; 	  
TRP 	 0; 		 

DEBUG 	LDB 	 TR 	 LF; 	  
TRP 	 3; 		 
SUB 	 TR 	 TR; 	  
ADI 	 TR 	 25; 	  
TRP 	 1; 		 
TRP 	 0; 		 

// End
