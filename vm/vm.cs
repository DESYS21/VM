using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vm
{
    class Program
    {
        static void Main(string[] args)
        {
            //Variables
            #region Variables
            const int INCREMENTOR = 4;
            const int REGISTER_SIZE = 15;
            const int THREAD_SIZE = 6;
            const int PC = 10;
            const int FP = 11;
            const int SP = 12;
            const int SB = 13;
            const int SL = 14;
            const int ADD = 10;
            const int SUB = 11;
            const int MUL = 12;
            const int DIV = 13;
            const int MOV = 14;
            const int LDB = 15;
            const int LDR = 16;
            const int TRP = 17;
            const int ADI = 18;
            const int LDA = 19;
            const int LDRR = 20;
            const int STR = 21;
            const int STB = 22;
            const int JMP = 23;
            const int JMR = 24;
            const int BNZ = 25;
            const int BGT = 26;
            const int BLT = 27;
            const int BRZ = 28;
            const int CMP = 29;
            const int LDBR = 30;
            const int RUN = 31;
            const int END = 32;
            const int BLK = 33;
            const int LCK = 34;
            const int ULK = 35;
            int[] lineToExe;
            int[] register = new int[REGISTER_SIZE];
            int[] threads = new int[THREAD_SIZE];
            int currentThread = 0;
            int threadCount = 0;
            int threadBase;
            int threadScheduler = 0;
            bool blockMain = false;
            int lockedMutex = -1;
            int command;
            int arg1;
            int arg2;
            bool run = true;
            StringBuilder buffer = new StringBuilder(30);
            #endregion

            Assembler asm = new Assembler(args[0]);
            asm.runAssembler();

            register[PC] = asm.getStartOfPC();
            register[SB] = asm.getStartOfSB() - 10000;//Room for Thread Stack
            register[SL] = asm.getStartOfSL();
            threadBase = asm.getStartOfSB();

            //Start Program. VM
            while (run)
            {
                //Manage Threads here
                #region Threads
                if (lockedMutex < 0)//If it does then keep processing the currentThread
                {
                    if ((currentThread > 0 && threadScheduler > 2) || (blockMain && currentThread == 0))
                    {
                        saveRegisters(currentThread, threadBase, ref register, ref asm);

                        if (currentThread < THREAD_SIZE)
                        {
                            bool threadNotFound = true;
                            currentThread++;
                            //Check to see if the next thread number has been started
                            while (currentThread < THREAD_SIZE)
                            {
                                if (threads.Contains(currentThread))
                                {
                                    threadNotFound = false;
                                    break;
                                }
                                else
                                    currentThread++;
                            }

                            if (threadNotFound && blockMain)
                            {
                                for (int i = 1; i < threads.Length; i++)
                                {
                                    if (threads.Contains(i))
                                    {
                                        currentThread = i;
                                        threadNotFound = false;
                                        break;
                                    }
                                }
                            }

                            if (threadNotFound)
                            {
                                blockMain = false;
                                currentThread = 0;
                            }
                        }
                        else
                        {
                            currentThread = 0;
                        }

                        loadRegisters(currentThread, threadBase, ref register, ref asm);
                        threadScheduler = 0;
                    }
                    else
                    {
                        threadScheduler++;
                    }
                }
                #endregion

                lineToExe = asm.getLineToExe(register[PC]);
                command = lineToExe[0];
                arg1 = lineToExe[1];
                arg2 = lineToExe[2];
                
                switch (command)
                {
                    #region ADD
                    case ADD:
                        register[arg1] = register[arg1] + register[arg2];
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region ADI
                    case ADI:
                        register[arg1] = register[arg1] + arg2;
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region SUB
                    case SUB:
                        register[arg1] = register[arg1] - register[arg2];
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region MUL
                    case MUL:
                        register[arg1] = register[arg1] * register[arg2];
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region DIV
                    case DIV:
                        register[arg1] = register[arg1] / register[arg2];
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region MOV
                    case MOV:
                        register[arg1] = register[arg2];
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region LDB
                    case LDB:
                        register[arg1] = asm.getByteData(arg2);
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region LDBR
                    case LDBR:
                        register[arg1] = asm.getByteData(register[arg2]);
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region LDA
                    case LDA:
                        register[arg1] = arg2;
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region LDR
                    case LDR:
                        register[arg1] = asm.getData(arg2);
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region LDRR
                    case LDRR:
                        register[arg1] = asm.getData(register[arg2]);
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region STR
                    case STR:
                        asm.storeData(register[arg1], register[arg2]);
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region STB
                    case STB:
                        asm.storeByte(register[arg1], register[arg2]);
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region JMP
                    case JMP:
                        register[PC] = asm.getJumpPC(arg1);
                        break;
                    #endregion
                    #region JMR
                    case JMR:
                        register[PC] = register[arg1];
                        break;
                    #endregion
                    #region BNZ
                    case BNZ:
                        if (register[arg1] != 0)
                            register[PC] = asm.getJumpPC(arg2);
                        else
                            register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region BGT
                    case BGT:
                        if (register[arg1] > 0)
                            register[PC] = asm.getJumpPC(arg2);
                        else
                            register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region BLT
                    case BLT:
                        if (register[arg1] < 0)
                            register[PC] = asm.getJumpPC(arg2);
                        else
                            register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region BRZ
                    case BRZ:
                        if (register[arg1] == 0)
                            register[PC] = asm.getJumpPC(arg2);
                        else
                            register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region CMP
                    case CMP:
                        if (register[arg1] == register[arg2])
                            register[arg1] = 0;
                        else if (register[arg1] > register[arg2])
                            register[arg1] = 1;
                        else if (register[arg1] < register[arg2])
                            register[arg1] = -1;
                        register[PC] += (INCREMENTOR * 3);
                        break;
                    #endregion
                    #region TRP
                    case TRP:
                        if (arg1 == 1)
                        {
                            Console.Write("{0}", register[0]);
                        }
                        else if (arg1 == 3)
                        {
                            if (register[0] <= 0)
                            {
                                char val = Convert.ToChar(register[0] * -1);
                                if (val == 0)
                                    val = '0';
                                if (val == '0')
                                    Console.Write("{0}", val);
                                else
                                    Console.Write("-{0}", val);
                            }
                            else
                            {
                                Console.Write("{0}", Convert.ToChar(register[0]));
                            }
                        }
                        else if (arg1 == 4)
                        {
                            register[0] = int.Parse(Console.ReadLine());
                        }
                        else if (arg1 == 0)
                            run = false;
                        register[PC] += (INCREMENTOR * 2);
                        break;
                    #endregion
                    #region RUN
                    case RUN:
                        threadCount++;
                        if (threadCount >= THREAD_SIZE)
                        {
                            Console.WriteLine("Too many threads have started. You can only have {0} threads.", THREAD_SIZE);
                            run = false;
                        }
                        else
                        {
                            //Set PC to next instruction before saving
                            register[PC] += (INCREMENTOR * 3);
                            //Save current Threads registers
                            saveRegisters(currentThread, threadBase, ref register, ref asm);

                            //Start new Thread
                            register[PC] = asm.getJumpPC(arg2);
                            currentThread = threadCount;

                            threads[currentThread] = currentThread;
                            register[arg1] = threads[currentThread];
                            currentThread = register[arg1];
                        }
                        break;
                    #endregion
                    #region END
                    case END:
                        threads[currentThread] = 0;
                        threadScheduler = 100;
                        register[PC] += (INCREMENTOR * 1);
                        break;
                    #endregion
                    #region BLK
                    case BLK:
                        blockMain = true;
                        register[PC] += (INCREMENTOR * 1);
                        break;
                    #endregion
                    #region LCK
                    case LCK:
                        lockedMutex = currentThread;
                        register[PC] += (INCREMENTOR * 1);
                        break;
                    #endregion
                    #region ULK
                    case ULK:
                        lockedMutex = -1;
                        register[PC] += (INCREMENTOR * 1);
                        break;
                    #endregion
                }
            }
        }

        public static void saveRegisters(int threadNum, int tBase, ref int[] register, ref Assembler asm)
        {
            const int THREAD_MEM_SIZE = 1000;
            int stackPointer = tBase - 4;//Make room to store something
 
            if (threadNum != 0)
                stackPointer = tBase - (THREAD_MEM_SIZE * threadNum);

            //Iterate through registers
            for (int i = 0; i < register.Length; i++)
            {
                asm.storeData(register[i], stackPointer);
                stackPointer -= 4;
            }            
        }

        public static void loadRegisters(int threadNum, int tBase, ref int[] register, ref Assembler asm)
        {
            const int THREAD_MEM_SIZE = 1000;
            int stackPointer = tBase - 4;

            if (threadNum != 0)
                stackPointer = tBase - (THREAD_MEM_SIZE * threadNum);

            //Iterate through registers
            for (int i = 0; i < register.Length; i++)
            {
                register[i] = asm.getData(stackPointer);
                stackPointer -= 4;
            }
        }
    }
}
