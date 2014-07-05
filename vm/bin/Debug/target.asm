; This is the assembly for file: target.kxi

; data

                G106    .INT       0	
                G116    .INT       1	
                G124    .INT       0	
                G126    .INT      12	
                  LF    .BYT      10	
           UNDERFLOW    .BYT "Underflow has occured"	
              UPSIZE    .INT      21	; Character count for UNDERFLOW
            OVERFLOW    .BYT "Overflow has occured"	
              OFSIZE    .INT      20	; Character count for OVERFLOW

; Start

; Main Activation Record
		; Create Func 'main' Assembly
                 MOV       R0,       SP	; [FRAME] Check for Stack Overflow
                 ADI       R0,      -12	
                 CMP       R0,       SL	
                 BLT       R0, STOVERFLOW	
                 MOV       R0,       FP	; [FRAME] Create M127 Activation Record, store PFP
                 MOV       FP,       SP	; [FRAME] Move Stack Pointer to Frame Pointer (push a stack frame)
                 ADI       SP,       -4	; [FRAME] 
                 STR       R0,     (SP)	; [FRAME] Storing Previous Frame Pointer
                 ADI       SP,       -4	; [FRAME] Shift to 'this' spot
                 LDA       TR,     M127	; [FRAME][this] For main, just load main's address
                 STR       TR,     (SP)	; [FRAME][this] Store it on the activation record
                 ADI       SP,       -4	; [FRAME][this] Move to next available spot after 'this'

		; Create Func 'main' Assembly
                 MOV       R1,       PC	; [CALL] M127 Activation Record
                 ADI       R1,       40	; [CALL] 
                 STR       R1,     (FP)	; [CALL] 
                 JMP     M127		; [CALL] Calling main function

		; Create Quit Assembly
                 TRP        0		; [QUIT] Quit program

		; Create Func 'iNode' Assembly
M104                 ADI       SP,        0	; [FUNC] Move SP to account for Locals and Temps
		; ; [FUNC] Function 'iNode' starts here


		; Create Move Assembly
                 MOV       R4,       FP	; [LoadRegister][P] Load P105(key) from the stack
                 ADI       R4,      -12	; [LoadRegister][P]
                 LDR       R4,     (R4)	
                 MOV       R3,       R4	; [MOVE] Operation
                 MOV       TR,       FP	; [StoringRegister][V] Getting the 'this' pointer's address
                 ADI       TR,       -8	; [StoringRegister][V] this
                 LDR       TR,     (TR)	; [StoringRegister][V] get the 'this' pointer's address into heap
                 ADI       TR,        0	; [StoringRegister][V] Move into heap to grab actual value
                 STR       R3,     (TR)	; [StoringRegister][V] Storing SymId V101: root

		; Create Move Assembly
                 LDR       R6,     G106	; [LoadRegister] Load Global: 0
                 MOV       R5,       R6	; [MOVE] Operation
                 MOV       TR,       FP	; [StoringRegister][V] Getting the 'this' pointer's address
                 ADI       TR,       -8	; [StoringRegister][V] this
                 LDR       TR,     (TR)	; [StoringRegister][V] get the 'this' pointer's address into heap
                 ADI       TR,        4	; [StoringRegister][V] Move into heap to grab actual value
                 STR       R5,     (TR)	; [StoringRegister][V] Storing SymId V102: left

		; Create Move Assembly
                 LDR       R8,     G106	; [LoadRegister] Load Global: 0
                 MOV       R7,       R8	; [MOVE] Operation
                 MOV       TR,       FP	; [StoringRegister][V] Getting the 'this' pointer's address
                 ADI       TR,       -8	; [StoringRegister][V] this
                 LDR       TR,     (TR)	; [StoringRegister][V] get the 'this' pointer's address into heap
                 ADI       TR,        8	; [StoringRegister][V] Move into heap to grab actual value
                 STR       R7,     (TR)	; [StoringRegister][V] Storing SymId V103: right

		; Create Return Assembly
                 MOV      R11,       FP	; [LoadRegister] Load this pointer for ctor
                 ADI      R11,       -8	; [LoadRegister] Move to this
                 LDR      R11,    (R11)	; [LoadRegister] Loading up the this pointer for object
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R9,       SP	
                 CMP       R9,       SB	
                 BGT       R9, STUNDERFLOW	
                 LDR       R9,     (FP)	; [RETURN] Start the return process
                 MOV      R10,       FP	; [RETURN]
                 ADI      R10,       -4	; [RETURN]
                 LDR       FP,    (R10)	; [RETURN]
                 STR      R11,     (SP)	; [RETURN]
                 JMR       R9		; [RETURN] Return to calling function

		; Create Func 'iTree' Assembly
M111                 ADI       SP,        0	; [FUNC] Move SP to account for Locals and Temps
		; ; [FUNC] Function 'iTree' starts here


		; Create Move Assembly
                 LDR      R14,     G106	; [LoadRegister] Load Global: 0
                 MOV      R13,      R14	; [MOVE] Operation
                 MOV       TR,       FP	; [StoringRegister][V] Getting the 'this' pointer's address
                 ADI       TR,       -8	; [StoringRegister][V] this
                 LDR       TR,     (TR)	; [StoringRegister][V] get the 'this' pointer's address into heap
                 ADI       TR,        0	; [StoringRegister][V] Move into heap to grab actual value
                 STR      R13,     (TR)	; [StoringRegister][V] Storing SymId V109: root

		; Create Return Assembly
                 MOV       R5,       FP	; [LoadRegister] Load this pointer for ctor
                 ADI       R5,       -8	; [LoadRegister] Move to this
                 LDR       R5,     (R5)	; [LoadRegister] Loading up the this pointer for object
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV      R15,       SP	
                 CMP      R15,       SB	
                 BGT      R15, STUNDERFLOW	
                 LDR      R15,     (FP)	; [RETURN] Start the return process
                 MOV       R2,       FP	; [RETURN]
                 ADI       R2,       -4	; [RETURN]
                 LDR       FP,     (R2)	; [RETURN]
                 STR       R5,     (SP)	; [RETURN]
                 JMR      R15		; [RETURN] Return to calling function

		; Create Func 'add' Assembly
M113                 ADI       SP,      -16	; [FUNC] Move SP to account for Locals and Temps
		; ; [FUNC] Function 'add' starts here


		; Create Boolean Assembly
                 MOV       R2,       FP	; [LoadRegister][V] Load up the this pointer
                 ADI       R2,       -8	; [LoadRegister][V] this
                 LDR       R2,     (R2)	; [LoadRegister][V] get the 'this' pointer's address into heap
                 ADI       R2,        0	; [LoadRegister][V] Move into heap to grab actual value
                 LDR       R2,     (R2)	; [LoadRegister][V] Get the actual value now
                 LDR       R5,     G106	; [LoadRegister] Load Global: 0
                 MOV      R10,       R2	; [BOOLEAN]: EQ Operation
                 CMP      R10,       R5	; [BOOLEAN]: root==null
                 BRZ      R10,       L0	; [BOOLEAN]: root==null GOTO L0
                 SUB      R10,      R10	; [BOOLEAN]: Set R10 to FALSE
                 JMP       L1		; [BOOLEAN]: jmp L1
L0                 SUB      R10,      R10	; [BOOLEAN]: Set R10 to TRUE
                 ADI      R10,        1	; [BOOLEAN]: TRUE
 L1		MOV	  R0,	   R0	; Label No Op
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1000: root==null
                 ADI       TR,      -16	; [StoringRegister][T] Shift to right place in memory
                 STR      R10,     (TR)	; [StoringRegister][T]

		; Create ControlFlow Assembly
                 MOV       R2,       FP	; [LoadRegister][T] Load T1000(root==null) from the stack
                 ADI       R2,      -16	; [LoadRegister][T]
                 LDR       R2,     (R2)	
                 BRZ       R2,  SKIPIF0	; [CONTROLFLOW] BRZ Operation

		; Create Object Malloc Assembly
                 MOV       R2,       HF	; [NEWI][MEMORY] Grab Heap pointer
                 ADI       HF,       12	; [NEWI][MEMORY] NEWI
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1002: sizeofctor
                 ADI       TR,      -24	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Func 'iNode' Assembly
                 MOV       R2,       SP	; [FRAME] Check for Stack Overflow
                 ADI       R2,      -12	
                 CMP       R2,       SL	
                 BLT       R2, STOVERFLOW	
                 MOV       R2,       FP	; [FRAME] Create M104 Activation Record, store PFP
                 MOV       FP,       SP	; [FRAME] Move Stack Pointer to Frame Pointer (push a stack frame)
                 ADI       SP,       -4	; [FRAME] 
                 STR       R2,     (SP)	; [FRAME] Storing Previous Frame Pointer
                 ADI       SP,       -4	; [FRAME] Shift to 'this' spot
                 MOV       TR,       R2	; [FRAME][this] Copy Previous Frame Pointer
                 ADI       TR,      -24	; [FRAME][this] move to the 'this' pointer from the PFP using offset: -24
                 LDR       TR,     (TR)	; [FRAME][this] retrieve the 'this' pointer from the PFP
                 STR       TR,     (SP)	; [FRAME][this] Store it on the activation record
                 ADI       SP,       -4	; [FRAME][this] Move to next available spot after 'this'

		; Create Push Assembly
                 MOV       R2,       FP	; [PUSH] Get Current FP
                 ADI       R2,       -4	; [PUSH] Get Previous Frame Pointer
                 LDR       R2,     (R2)	; [PUSH] Load Previous Frame Pointer address
                 ADI       R2,      -12	; [PUSH] Move to Param P114 memory location: key
                 LDR       R2,     (R2)	; [PUSH] Load Param
                 STR       R2,     (SP)	; [PUSH] Store Parameter in current Stack Frame
                 ADI       SP,       -4	; [PUSH] Increment SP to next avaliable stack location

		; Create Func 'iNode' Assembly
                 MOV       R2,       PC	; [CALL] M104 Activation Record
                 ADI       R2,       40	; [CALL] 
                 STR       R2,     (FP)	; [CALL] 
                 JMP     M104		; [CALL] Calling iNode function

		; Create Peek Assembly
                 MOV       R2,       SP	; [PEEK] Get Return Value
                 LDR       R2,     (R2)	; [PEEK] Load Return Value
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1001: ctor
                 ADI       TR,      -20	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Move Assembly
                 MOV       R5,       FP	; [LoadRegister][T] Load T1001(ctor) from the stack
                 ADI       R5,      -20	; [LoadRegister][T]
                 LDR       R5,     (R5)	
                 MOV       R2,       R5	; [MOVE] Operation
                 MOV       TR,       FP	; [StoringRegister][V] Getting the 'this' pointer's address
                 ADI       TR,       -8	; [StoringRegister][V] this
                 LDR       TR,     (TR)	; [StoringRegister][V] get the 'this' pointer's address into heap
                 ADI       TR,        0	; [StoringRegister][V] Move into heap to grab actual value
                 STR       R2,     (TR)	; [StoringRegister][V] Storing SymId V109: root

		; Create Return Assembly
                 LDR      R10,     G116	; [LoadRegister] Load Global: 1
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 STR      R10,     (SP)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; Create ControlFlow Assembly
                 JMP SKIPELSE1		; [CONTROLFLOW] JMP Operation

		; Create Func 'insert' Assembly
SKIPIF0                 MOV       R2,       SP	; [FRAME] Check for Stack Overflow
                 ADI       R2,      -12	
                 CMP       R2,       SL	
                 BLT       R2, STOVERFLOW	
                 MOV       R2,       FP	; [FRAME] Create M117 Activation Record, store PFP
                 MOV       FP,       SP	; [FRAME] Move Stack Pointer to Frame Pointer (push a stack frame)
                 ADI       SP,       -4	; [FRAME] 
                 STR       R2,     (SP)	; [FRAME] Storing Previous Frame Pointer
                 ADI       SP,       -4	; [FRAME] Shift to 'this' spot
                 MOV       TR,       R2	; [FRAME][this] Copy Previous Frame Pointer
                 ADI       TR,       -8	; [FRAME][this] move to the 'this' pointer from the PFP
                 LDR       TR,     (TR)	; [FRAME][this] retrieve the 'this' pointer from the PFP
                 STR       TR,     (SP)	; [FRAME][this] Store it on the activation record
                 ADI       SP,       -4	; [FRAME][this] Move to next available spot after 'this'

		; Create Push Assembly
                 MOV       R2,       FP	; [PUSH] Get Current FP
                 ADI       R2,       -4	; [PUSH] Get Previous Frame Pointer
                 LDR       R2,     (R2)	; [PUSH] Load Previous Frame Pointer address
                 ADI       R2,      -12	; [PUSH] Move to Param P114 memory location: key
                 LDR       R2,     (R2)	; [PUSH] Load Param
                 STR       R2,     (SP)	; [PUSH] Store Parameter in current Stack Frame
                 ADI       SP,       -4	; [PUSH] Increment SP to next avaliable stack location

		; Create Push Assembly
                 MOV       R2,       FP	; [PUSH] Get Current FP
                 ADI       R2,       -4	; [PUSH] Get Previous Frame Pointer
                 LDR       R2,     (R2)	; [PUSH] Load Previous Frame Pointer address
                 ADI       R2,       -8	; [PUSH] [V] Index off of 'this' pointer
                 LDR       R2,     (R2)	; [PUSH] [V] Load 'this' Pointer address
                 ADI       R2,        0	; [PUSH] Move to Param V109 memory location: root
                 LDR       R2,     (R2)	; [PUSH] Load Param
                 STR       R2,     (SP)	; [PUSH] Store Parameter in current Stack Frame
                 ADI       SP,       -4	; [PUSH] Increment SP to next avaliable stack location

		; Create Func 'insert' Assembly
                 MOV       R2,       PC	; [CALL] M117 Activation Record
                 ADI       R2,       40	; [CALL] 
                 STR       R2,     (FP)	; [CALL] 
                 JMP     M117		; [CALL] Calling insert function

		; Create Peek Assembly
                 MOV       R2,       SP	; [PEEK] Get Return Value
                 LDR       R2,     (R2)	; [PEEK] Load Return Value
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1003: insert()
                 ADI       TR,      -28	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Return Assembly
                 MOV      R10,       FP	; [LoadRegister][T] Load T1003(insert()) from the stack
                 ADI      R10,      -28	; [LoadRegister][T]
                 LDR      R10,    (R10)	
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 STR      R10,     (SP)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; Create Return Assembly
SKIPELSE1                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; Create Func 'insert' Assembly
M117                 ADI       SP,      -72	; [FUNC] Move SP to account for Locals and Temps
		; ; [FUNC] Function 'insert' starts here


		; Create Reference Assembly
                 MOV       R2,       FP	; [LoadRegister][P] Load P119(node) from the stack
                 ADI       R2,      -16	; [LoadRegister][P]
                 LDR       R2,     (R2)	
                 ADI       R2,        0	; [REFERENCE] Load member offset into object P119
                 MOV       R5,       R2	; [REFERENCE] Store reference to P119.V101
                 MOV       TR,       FP	; [StoringRegister][R] Storing SymId R1004: node.root
                 ADI       TR,      -20	; [StoringRegister][R] Shift to right place in memory
                 STR       R5,     (TR)	; [StoringRegister][R] R1004

		; Create Boolean Assembly
                 MOV       R2,       FP	; [LoadRegister][P] Load P118(key) from the stack
                 ADI       R2,      -12	; [LoadRegister][P]
                 LDR       R2,     (R2)	
                 MOV       R5,       FP	; [LoadRegister][R] Load R1004(node.root) from the stack
                 ADI       R5,      -20	; [LoadRegister][R] 
                 LDR       R5,     (R5)	; [LoadRegister][R] Load the object address
                 LDR       R5,     (R5)	; [LoadRegister][R] Load the value 
                 MOV      R10,       R2	; [BOOLEAN]: LT Operation
                 CMP      R10,       R5	; [BOOLEAN]: key<node.root
                 BLT      R10,       L2	; [BOOLEAN]: key<node.root GOTO L2
                 SUB      R10,      R10	; [BOOLEAN]: Set R10 to FALSE
                 JMP       L3		; [BOOLEAN]: jmp L3
L2                 SUB      R10,      R10	; [BOOLEAN]: Set R10 to TRUE
                 ADI      R10,        1	; [BOOLEAN]: TRUE
 L3		MOV	  R0,	   R0	; Label No Op
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1005: key<node.root
                 ADI       TR,      -24	; [StoringRegister][T] Shift to right place in memory
                 STR      R10,     (TR)	; [StoringRegister][T]

		; Create ControlFlow Assembly
                 MOV       R2,       FP	; [LoadRegister][T] Load T1005(key<node.root) from the stack
                 ADI       R2,      -24	; [LoadRegister][T]
                 LDR       R2,     (R2)	
                 BRZ       R2, SKIPELSE4	; [CONTROLFLOW] BRZ Operation

		; Create Reference Assembly
                 MOV       R2,       FP	; [LoadRegister][P] Load P119(node) from the stack
                 ADI       R2,      -16	; [LoadRegister][P]
                 LDR       R2,     (R2)	
                 ADI       R2,        4	; [REFERENCE] Load member offset into object P119
                 MOV       R5,       R2	; [REFERENCE] Store reference to P119.V102
                 MOV       TR,       FP	; [StoringRegister][R] Storing SymId R1006: node.left
                 ADI       TR,      -28	; [StoringRegister][R] Shift to right place in memory
                 STR       R5,     (TR)	; [StoringRegister][R] R1006

		; Create Boolean Assembly
                 MOV       R2,       FP	; [LoadRegister][R] Load R1006(node.left) from the stack
                 ADI       R2,      -28	; [LoadRegister][R] 
                 LDR       R2,     (R2)	; [LoadRegister][R] Load the object address
                 LDR       R2,     (R2)	; [LoadRegister][R] Load the value 
                 LDR       R5,     G106	; [LoadRegister] Load Global: 0
                 MOV      R10,       R2	; [BOOLEAN]: EQ Operation
                 CMP      R10,       R5	; [BOOLEAN]: node.left==null
                 BRZ      R10,       L4	; [BOOLEAN]: node.left==null GOTO L4
                 SUB      R10,      R10	; [BOOLEAN]: Set R10 to FALSE
                 JMP       L5		; [BOOLEAN]: jmp L5
L4                 SUB      R10,      R10	; [BOOLEAN]: Set R10 to TRUE
                 ADI      R10,        1	; [BOOLEAN]: TRUE
 L5		MOV	  R0,	   R0	; Label No Op
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1007: node.left==null
                 ADI       TR,      -32	; [StoringRegister][T] Shift to right place in memory
                 STR      R10,     (TR)	; [StoringRegister][T]

		; Create ControlFlow Assembly
                 MOV       R2,       FP	; [LoadRegister][T] Load T1007(node.left==null) from the stack
                 ADI       R2,      -32	; [LoadRegister][T]
                 LDR       R2,     (R2)	
                 BRZ       R2,  SKIPIF3	; [CONTROLFLOW] BRZ Operation

		; Create Reference Assembly
                 MOV       R2,       FP	; [LoadRegister][P] Load P119(node) from the stack
                 ADI       R2,      -16	; [LoadRegister][P]
                 LDR       R2,     (R2)	
                 ADI       R2,        4	; [REFERENCE] Load member offset into object P119
                 MOV       R5,       R2	; [REFERENCE] Store reference to P119.V102
                 MOV       TR,       FP	; [StoringRegister][R] Storing SymId R1008: node.left
                 ADI       TR,      -36	; [StoringRegister][R] Shift to right place in memory
                 STR       R5,     (TR)	; [StoringRegister][R] R1008

		; Create Object Malloc Assembly
                 MOV       R2,       HF	; [NEWI][MEMORY] Grab Heap pointer
                 ADI       HF,       12	; [NEWI][MEMORY] NEWI
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1010: sizeofctor
                 ADI       TR,      -44	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Func 'iNode' Assembly
                 MOV       R2,       SP	; [FRAME] Check for Stack Overflow
                 ADI       R2,      -12	
                 CMP       R2,       SL	
                 BLT       R2, STOVERFLOW	
                 MOV       R2,       FP	; [FRAME] Create M104 Activation Record, store PFP
                 MOV       FP,       SP	; [FRAME] Move Stack Pointer to Frame Pointer (push a stack frame)
                 ADI       SP,       -4	; [FRAME] 
                 STR       R2,     (SP)	; [FRAME] Storing Previous Frame Pointer
                 ADI       SP,       -4	; [FRAME] Shift to 'this' spot
                 MOV       TR,       R2	; [FRAME][this] Copy Previous Frame Pointer
                 ADI       TR,      -44	; [FRAME][this] move to the 'this' pointer from the PFP using offset: -44
                 LDR       TR,     (TR)	; [FRAME][this] retrieve the 'this' pointer from the PFP
                 STR       TR,     (SP)	; [FRAME][this] Store it on the activation record
                 ADI       SP,       -4	; [FRAME][this] Move to next available spot after 'this'

		; Create Push Assembly
                 MOV       R2,       FP	; [PUSH] Get Current FP
                 ADI       R2,       -4	; [PUSH] Get Previous Frame Pointer
                 LDR       R2,     (R2)	; [PUSH] Load Previous Frame Pointer address
                 ADI       R2,      -12	; [PUSH] Move to Param P118 memory location: key
                 LDR       R2,     (R2)	; [PUSH] Load Param
                 STR       R2,     (SP)	; [PUSH] Store Parameter in current Stack Frame
                 ADI       SP,       -4	; [PUSH] Increment SP to next avaliable stack location

		; Create Func 'iNode' Assembly
                 MOV       R2,       PC	; [CALL] M104 Activation Record
                 ADI       R2,       40	; [CALL] 
                 STR       R2,     (FP)	; [CALL] 
                 JMP     M104		; [CALL] Calling iNode function

		; Create Peek Assembly
                 MOV       R2,       SP	; [PEEK] Get Return Value
                 LDR       R2,     (R2)	; [PEEK] Load Return Value
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1009: ctor
                 ADI       TR,      -40	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Move Assembly
                 MOV       R5,       FP	; [LoadRegister][T] Load T1009(ctor) from the stack
                 ADI       R5,      -40	; [LoadRegister][T]
                 LDR       R5,     (R5)	
                 MOV       R2,       R5	; [MOVE] Operation
                 MOV       TR,       FP	; [StoringRegister][R] Storing SymId R1008: node.left
                 ADI       TR,      -36	; [StoringRegister][R] Shift to right place in memory
                 LDR       TR,     (TR)	; [StoringRegister][R] Loading the address for R1008 on the stack
                 STR       R2,     (TR)	; [StoringRegister][R] R1008

		; Create Return Assembly
                 LDR      R10,     G116	; [LoadRegister] Load Global: 1
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 STR      R10,     (SP)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; Create ControlFlow Assembly
                 JMP SKIPELSE4		; [CONTROLFLOW] JMP Operation

		; Create Reference Assembly
SKIPIF3                 MOV       R2,       FP	; [LoadRegister][P] Load P119(node) from the stack
                 ADI       R2,      -16	; [LoadRegister][P]
                 LDR       R2,     (R2)	
                 ADI       R2,        4	; [REFERENCE] Load member offset into object P119
                 MOV       R5,       R2	; [REFERENCE] Store reference to P119.V102
                 MOV       TR,       FP	; [StoringRegister][R] Storing SymId R1011: node.left
                 ADI       TR,      -48	; [StoringRegister][R] Shift to right place in memory
                 STR       R5,     (TR)	; [StoringRegister][R] R1011

		; Create Func 'insert' Assembly
                 MOV       R2,       SP	; [FRAME] Check for Stack Overflow
                 ADI       R2,      -12	
                 CMP       R2,       SL	
                 BLT       R2, STOVERFLOW	
                 MOV       R2,       FP	; [FRAME] Create M117 Activation Record, store PFP
                 MOV       FP,       SP	; [FRAME] Move Stack Pointer to Frame Pointer (push a stack frame)
                 ADI       SP,       -4	; [FRAME] 
                 STR       R2,     (SP)	; [FRAME] Storing Previous Frame Pointer
                 ADI       SP,       -4	; [FRAME] Shift to 'this' spot
                 MOV       TR,       R2	; [FRAME][this] Copy Previous Frame Pointer
                 ADI       TR,       -8	; [FRAME][this] move to the 'this' pointer from the PFP
                 LDR       TR,     (TR)	; [FRAME][this] retrieve the 'this' pointer from the PFP
                 STR       TR,     (SP)	; [FRAME][this] Store it on the activation record
                 ADI       SP,       -4	; [FRAME][this] Move to next available spot after 'this'

		; Create Push Assembly
                 MOV       R2,       FP	; [PUSH] Get Current FP
                 ADI       R2,       -4	; [PUSH] Get Previous Frame Pointer
                 LDR       R2,     (R2)	; [PUSH] Load Previous Frame Pointer address
                 ADI       R2,      -12	; [PUSH] Move to Param P118 memory location: key
                 LDR       R2,     (R2)	; [PUSH] Load Param
                 STR       R2,     (SP)	; [PUSH] Store Parameter in current Stack Frame
                 ADI       SP,       -4	; [PUSH] Increment SP to next avaliable stack location

		; Create Push Assembly
                 MOV       R2,       FP	; [PUSH] Get Current FP
                 ADI       R2,       -4	; [PUSH] Get Previous Frame Pointer
                 LDR       R2,     (R2)	; [PUSH] Load Previous Frame Pointer address
                 ADI       R2,      -48	; [PUSH] Move to Param R1011 memory location: node.left
                 LDR       R2,     (R2)	; [PUSH] Load Param
                 LDR       R2,     (R2)	; [PUSH] [R] Load Param
                 STR       R2,     (SP)	; [PUSH] Store Parameter in current Stack Frame
                 ADI       SP,       -4	; [PUSH] Increment SP to next avaliable stack location

		; Create Func 'insert' Assembly
                 MOV       R2,       PC	; [CALL] M117 Activation Record
                 ADI       R2,       40	; [CALL] 
                 STR       R2,     (FP)	; [CALL] 
                 JMP     M117		; [CALL] Calling insert function

		; Create Peek Assembly
                 MOV       R2,       SP	; [PEEK] Get Return Value
                 LDR       R2,     (R2)	; [PEEK] Load Return Value
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1012: insert()
                 ADI       TR,      -52	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Return Assembly
                 MOV      R10,       FP	; [LoadRegister][T] Load T1012(insert()) from the stack
                 ADI      R10,      -52	; [LoadRegister][T]
                 LDR      R10,    (R10)	
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 STR      R10,     (SP)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; Create ControlFlow Assembly
                 JMP SKIPELSE9		; [CONTROLFLOW] JMP Operation

		; Create Reference Assembly
SKIPELSE4                 MOV       R2,       FP	; [LoadRegister][P] Load P119(node) from the stack
                 ADI       R2,      -16	; [LoadRegister][P]
                 LDR       R2,     (R2)	
                 ADI       R2,        0	; [REFERENCE] Load member offset into object P119
                 MOV       R5,       R2	; [REFERENCE] Store reference to P119.V101
                 MOV       TR,       FP	; [StoringRegister][R] Storing SymId R1013: node.root
                 ADI       TR,      -56	; [StoringRegister][R] Shift to right place in memory
                 STR       R5,     (TR)	; [StoringRegister][R] R1013

		; Create Boolean Assembly
                 MOV       R2,       FP	; [LoadRegister][P] Load P118(key) from the stack
                 ADI       R2,      -12	; [LoadRegister][P]
                 LDR       R2,     (R2)	
                 MOV       R5,       FP	; [LoadRegister][R] Load R1013(node.root) from the stack
                 ADI       R5,      -56	; [LoadRegister][R] 
                 LDR       R5,     (R5)	; [LoadRegister][R] Load the object address
                 LDR       R5,     (R5)	; [LoadRegister][R] Load the value 
                 MOV      R10,       R2	; [BOOLEAN]: GT Operation
                 CMP      R10,       R5	; [BOOLEAN]: key>node.root
                 BGT      R10,       L6	; [BOOLEAN]: key>node.root GOTO L6
                 SUB      R10,      R10	; [BOOLEAN]: Set R10 to FALSE
                 JMP       L7		; [BOOLEAN]: jmp L7
L6                 SUB      R10,      R10	; [BOOLEAN]: Set R10 to TRUE
                 ADI      R10,        1	; [BOOLEAN]: TRUE
 L7		MOV	  R0,	   R0	; Label No Op
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1014: key>node.root
                 ADI       TR,      -60	; [StoringRegister][T] Shift to right place in memory
                 STR      R10,     (TR)	; [StoringRegister][T]

		; Create ControlFlow Assembly
                 MOV       R2,       FP	; [LoadRegister][T] Load T1014(key>node.root) from the stack
                 ADI       R2,      -60	; [LoadRegister][T]
                 LDR       R2,     (R2)	
                 BRZ       R2, SKIPELSE8	; [CONTROLFLOW] BRZ Operation

		; Create Reference Assembly
                 MOV       R2,       FP	; [LoadRegister][P] Load P119(node) from the stack
                 ADI       R2,      -16	; [LoadRegister][P]
                 LDR       R2,     (R2)	
                 ADI       R2,        8	; [REFERENCE] Load member offset into object P119
                 MOV       R5,       R2	; [REFERENCE] Store reference to P119.V103
                 MOV       TR,       FP	; [StoringRegister][R] Storing SymId R1015: node.right
                 ADI       TR,      -64	; [StoringRegister][R] Shift to right place in memory
                 STR       R5,     (TR)	; [StoringRegister][R] R1015

		; Create Boolean Assembly
                 MOV       R2,       FP	; [LoadRegister][R] Load R1015(node.right) from the stack
                 ADI       R2,      -64	; [LoadRegister][R] 
                 LDR       R2,     (R2)	; [LoadRegister][R] Load the object address
                 LDR       R2,     (R2)	; [LoadRegister][R] Load the value 
                 LDR       R5,     G106	; [LoadRegister] Load Global: 0
                 MOV      R10,       R2	; [BOOLEAN]: EQ Operation
                 CMP      R10,       R5	; [BOOLEAN]: node.right==null
                 BRZ      R10,       L8	; [BOOLEAN]: node.right==null GOTO L8
                 SUB      R10,      R10	; [BOOLEAN]: Set R10 to FALSE
                 JMP       L9		; [BOOLEAN]: jmp L9
L8                 SUB      R10,      R10	; [BOOLEAN]: Set R10 to TRUE
                 ADI      R10,        1	; [BOOLEAN]: TRUE
 L9		MOV	  R0,	   R0	; Label No Op
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1016: node.right==null
                 ADI       TR,      -68	; [StoringRegister][T] Shift to right place in memory
                 STR      R10,     (TR)	; [StoringRegister][T]

		; Create ControlFlow Assembly
                 MOV       R2,       FP	; [LoadRegister][T] Load T1016(node.right==null) from the stack
                 ADI       R2,      -68	; [LoadRegister][T]
                 LDR       R2,     (R2)	
                 BRZ       R2,  SKIPIF7	; [CONTROLFLOW] BRZ Operation

		; Create Reference Assembly
                 MOV       R2,       FP	; [LoadRegister][P] Load P119(node) from the stack
                 ADI       R2,      -16	; [LoadRegister][P]
                 LDR       R2,     (R2)	
                 ADI       R2,        8	; [REFERENCE] Load member offset into object P119
                 MOV       R5,       R2	; [REFERENCE] Store reference to P119.V103
                 MOV       TR,       FP	; [StoringRegister][R] Storing SymId R1017: node.right
                 ADI       TR,      -72	; [StoringRegister][R] Shift to right place in memory
                 STR       R5,     (TR)	; [StoringRegister][R] R1017

		; Create Object Malloc Assembly
                 MOV       R2,       HF	; [NEWI][MEMORY] Grab Heap pointer
                 ADI       HF,       12	; [NEWI][MEMORY] NEWI
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1019: sizeofctor
                 ADI       TR,      -80	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Func 'iNode' Assembly
                 MOV       R2,       SP	; [FRAME] Check for Stack Overflow
                 ADI       R2,      -12	
                 CMP       R2,       SL	
                 BLT       R2, STOVERFLOW	
                 MOV       R2,       FP	; [FRAME] Create M104 Activation Record, store PFP
                 MOV       FP,       SP	; [FRAME] Move Stack Pointer to Frame Pointer (push a stack frame)
                 ADI       SP,       -4	; [FRAME] 
                 STR       R2,     (SP)	; [FRAME] Storing Previous Frame Pointer
                 ADI       SP,       -4	; [FRAME] Shift to 'this' spot
                 MOV       TR,       R2	; [FRAME][this] Copy Previous Frame Pointer
                 ADI       TR,      -80	; [FRAME][this] move to the 'this' pointer from the PFP using offset: -80
                 LDR       TR,     (TR)	; [FRAME][this] retrieve the 'this' pointer from the PFP
                 STR       TR,     (SP)	; [FRAME][this] Store it on the activation record
                 ADI       SP,       -4	; [FRAME][this] Move to next available spot after 'this'

		; Create Push Assembly
                 MOV       R2,       FP	; [PUSH] Get Current FP
                 ADI       R2,       -4	; [PUSH] Get Previous Frame Pointer
                 LDR       R2,     (R2)	; [PUSH] Load Previous Frame Pointer address
                 ADI       R2,      -12	; [PUSH] Move to Param P118 memory location: key
                 LDR       R2,     (R2)	; [PUSH] Load Param
                 STR       R2,     (SP)	; [PUSH] Store Parameter in current Stack Frame
                 ADI       SP,       -4	; [PUSH] Increment SP to next avaliable stack location

		; Create Func 'iNode' Assembly
                 MOV       R2,       PC	; [CALL] M104 Activation Record
                 ADI       R2,       40	; [CALL] 
                 STR       R2,     (FP)	; [CALL] 
                 JMP     M104		; [CALL] Calling iNode function

		; Create Peek Assembly
                 MOV       R2,       SP	; [PEEK] Get Return Value
                 LDR       R2,     (R2)	; [PEEK] Load Return Value
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1018: ctor
                 ADI       TR,      -76	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Move Assembly
                 MOV       R5,       FP	; [LoadRegister][T] Load T1018(ctor) from the stack
                 ADI       R5,      -76	; [LoadRegister][T]
                 LDR       R5,     (R5)	
                 MOV       R2,       R5	; [MOVE] Operation
                 MOV       TR,       FP	; [StoringRegister][R] Storing SymId R1017: node.right
                 ADI       TR,      -72	; [StoringRegister][R] Shift to right place in memory
                 LDR       TR,     (TR)	; [StoringRegister][R] Loading the address for R1017 on the stack
                 STR       R2,     (TR)	; [StoringRegister][R] R1017

		; Create Return Assembly
                 LDR      R10,     G116	; [LoadRegister] Load Global: 1
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 STR      R10,     (SP)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; Create ControlFlow Assembly
                 JMP SKIPELSE8		; [CONTROLFLOW] JMP Operation

		; Create Reference Assembly
SKIPIF7                 MOV       R2,       FP	; [LoadRegister][P] Load P119(node) from the stack
                 ADI       R2,      -16	; [LoadRegister][P]
                 LDR       R2,     (R2)	
                 ADI       R2,        8	; [REFERENCE] Load member offset into object P119
                 MOV       R5,       R2	; [REFERENCE] Store reference to P119.V103
                 MOV       TR,       FP	; [StoringRegister][R] Storing SymId R1020: node.right
                 ADI       TR,      -84	; [StoringRegister][R] Shift to right place in memory
                 STR       R5,     (TR)	; [StoringRegister][R] R1020

		; Create Func 'insert' Assembly
                 MOV       R2,       SP	; [FRAME] Check for Stack Overflow
                 ADI       R2,      -12	
                 CMP       R2,       SL	
                 BLT       R2, STOVERFLOW	
                 MOV       R2,       FP	; [FRAME] Create M117 Activation Record, store PFP
                 MOV       FP,       SP	; [FRAME] Move Stack Pointer to Frame Pointer (push a stack frame)
                 ADI       SP,       -4	; [FRAME] 
                 STR       R2,     (SP)	; [FRAME] Storing Previous Frame Pointer
                 ADI       SP,       -4	; [FRAME] Shift to 'this' spot
                 MOV       TR,       R2	; [FRAME][this] Copy Previous Frame Pointer
                 ADI       TR,       -8	; [FRAME][this] move to the 'this' pointer from the PFP
                 LDR       TR,     (TR)	; [FRAME][this] retrieve the 'this' pointer from the PFP
                 STR       TR,     (SP)	; [FRAME][this] Store it on the activation record
                 ADI       SP,       -4	; [FRAME][this] Move to next available spot after 'this'

		; Create Push Assembly
                 MOV       R2,       FP	; [PUSH] Get Current FP
                 ADI       R2,       -4	; [PUSH] Get Previous Frame Pointer
                 LDR       R2,     (R2)	; [PUSH] Load Previous Frame Pointer address
                 ADI       R2,      -12	; [PUSH] Move to Param P118 memory location: key
                 LDR       R2,     (R2)	; [PUSH] Load Param
                 STR       R2,     (SP)	; [PUSH] Store Parameter in current Stack Frame
                 ADI       SP,       -4	; [PUSH] Increment SP to next avaliable stack location

		; Create Push Assembly
                 MOV       R2,       FP	; [PUSH] Get Current FP
                 ADI       R2,       -4	; [PUSH] Get Previous Frame Pointer
                 LDR       R2,     (R2)	; [PUSH] Load Previous Frame Pointer address
                 ADI       R2,      -84	; [PUSH] Move to Param R1020 memory location: node.right
                 LDR       R2,     (R2)	; [PUSH] Load Param
                 LDR       R2,     (R2)	; [PUSH] [R] Load Param
                 STR       R2,     (SP)	; [PUSH] Store Parameter in current Stack Frame
                 ADI       SP,       -4	; [PUSH] Increment SP to next avaliable stack location

		; Create Func 'insert' Assembly
                 MOV       R2,       PC	; [CALL] M117 Activation Record
                 ADI       R2,       40	; [CALL] 
                 STR       R2,     (FP)	; [CALL] 
                 JMP     M117		; [CALL] Calling insert function

		; Create Peek Assembly
                 MOV       R2,       SP	; [PEEK] Get Return Value
                 LDR       R2,     (R2)	; [PEEK] Load Return Value
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1021: insert()
                 ADI       TR,      -88	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Return Assembly
                 MOV      R10,       FP	; [LoadRegister][T] Load T1021(insert()) from the stack
                 ADI      R10,      -88	; [LoadRegister][T]
                 LDR      R10,    (R10)	
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 STR      R10,     (SP)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; Create ControlFlow Assembly
                 JMP SKIPELSE9		; [CONTROLFLOW] JMP Operation

		; Create Return Assembly
SKIPELSE8                 LDR      R10,     G124	; [LoadRegister] Load Global: 0
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 STR      R10,     (SP)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; Create Return Assembly
SKIPELSE9                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; Create Func 'print' Assembly
M125                 ADI       SP,        0	; [FUNC] Move SP to account for Locals and Temps
		; ; [FUNC] Function 'print' starts here


		; Create Move Immediate Assembly
                 LDR       R2,     G126	; [MOVEI] Loading global: G126
                 MOV       TR,       FP	; [StoringRegister][V] Getting the 'this' pointer's address
                 ADI       TR,       -8	; [StoringRegister][V] this
                 LDR       TR,     (TR)	; [StoringRegister][V] get the 'this' pointer's address into heap
                 ADI       TR,        4	; [StoringRegister][V] Move into heap to grab actual value
                 STR       R2,     (TR)	; [StoringRegister][V] Storing SymId V110: first

		; Create Write Assembly
                 MOV       R2,       FP	; [LoadRegister][V] Load up the this pointer
                 ADI       R2,       -8	; [LoadRegister][V] this
                 LDR       R2,     (R2)	; [LoadRegister][V] get the 'this' pointer's address into heap
                 ADI       R2,        4	; [LoadRegister][V] Move into heap to grab actual value
                 LDR       R2,     (R2)	; [LoadRegister][V] Get the actual value now
                 MOV       TR,       R2	; [WRITE] Operation
                 TRP        1		; [WRITE] Type integer(1)

		; Create Return Assembly
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; Create Func 'main' Assembly
M127                 ADI       SP,      -12	; [FUNC] Move SP to account for Locals and Temps
		; ; [FUNC] Function 'main' starts here


		; Create Object Malloc Assembly
                 MOV       R2,       HF	; [NEWI][MEMORY] Grab Heap pointer
                 ADI       HF,        8	; [NEWI][MEMORY] NEWI
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1023: sizeofctor
                 ADI       TR,      -20	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Func 'iTree' Assembly
                 MOV       R2,       SP	; [FRAME] Check for Stack Overflow
                 ADI       R2,      -12	
                 CMP       R2,       SL	
                 BLT       R2, STOVERFLOW	
                 MOV       R2,       FP	; [FRAME] Create M111 Activation Record, store PFP
                 MOV       FP,       SP	; [FRAME] Move Stack Pointer to Frame Pointer (push a stack frame)
                 ADI       SP,       -4	; [FRAME] 
                 STR       R2,     (SP)	; [FRAME] Storing Previous Frame Pointer
                 ADI       SP,       -4	; [FRAME] Shift to 'this' spot
                 MOV       TR,       R2	; [FRAME][this] Copy Previous Frame Pointer
                 ADI       TR,      -20	; [FRAME][this] move to the 'this' pointer from the PFP using offset: -20
                 LDR       TR,     (TR)	; [FRAME][this] retrieve the 'this' pointer from the PFP
                 STR       TR,     (SP)	; [FRAME][this] Store it on the activation record
                 ADI       SP,       -4	; [FRAME][this] Move to next available spot after 'this'

		; Create Func 'iTree' Assembly
                 MOV       R2,       PC	; [CALL] M111 Activation Record
                 ADI       R2,       40	; [CALL] 
                 STR       R2,     (FP)	; [CALL] 
                 JMP     M111		; [CALL] Calling iTree function

		; Create Peek Assembly
                 MOV       R2,       SP	; [PEEK] Get Return Value
                 LDR       R2,     (R2)	; [PEEK] Load Return Value
                 MOV       TR,       FP	; [StoringRegister][T] Storing SymId T1022: ctor
                 ADI       TR,      -16	; [StoringRegister][T] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][T]

		; Create Move Assembly
                 MOV       R5,       FP	; [LoadRegister][T] Load T1022(ctor) from the stack
                 ADI       R5,      -16	; [LoadRegister][T]
                 LDR       R5,     (R5)	
                 MOV       R2,       R5	; [MOVE] Operation
                 MOV       TR,       FP	; [StoringRegister][L] Storing SymId L128: test
                 ADI       TR,      -12	; [StoringRegister][L] Shift to right place in memory
                 STR       R2,     (TR)	; [StoringRegister][L]

		; Create Return Assembly
                 MOV       SP,       FP	; Check for Stack Underflow
                 MOV       R2,       SP	
                 CMP       R2,       SB	
                 BGT       R2, STUNDERFLOW	
                 LDR       R2,     (FP)	; [RETURN] Start the return process
                 MOV       R5,       FP	; [RETURN]
                 ADI       R5,       -4	; [RETURN]
                 LDR       FP,     (R5)	; [RETURN]
                 JMR       R2		; [RETURN] Return to calling function

		; ; If we hit any of this code we have a real problem

STOVERFLOW                 LDR       R2,   OFSIZE	
                 LDA       R1, OVERFLOW	
PRTOVERFLOW                 LDB       TR,     (R1)	
                 TRP        3		
                 ADI       R2,       -1	
                 ADI       R1,        1	
                 BNZ       R2, PRTOVERFLOW	
                 TRP        0		

STUNDERFLOW                 LDR       R2,   UPSIZE	
                 LDA       R1, UNDERFLOW	
PRTUNDERFLOW                 LDB       TR,     (R1)	
                 TRP        3		
                 ADI       R2,       -1	
                 ADI       R1,        1	
                 BNZ       R2, PRTUNDERFLOW	
                 TRP        0		

DEBUG                 LDB       TR,       LF	
                 TRP        3		
                 SUB       TR,       TR	
                 ADI       TR,       25	
                 TRP        1		
                 TRP        0		

;end
