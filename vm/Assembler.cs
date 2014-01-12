using System;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vm
{
    class Assembler
    {
        //Variables
        #region Variables
        private const int SIZE_OF_MEM = (1000 * 1000 * 5);
        private const int SIZE_OF_RUNTIME_STACK = (SIZE_OF_MEM / 2);
        private const int INCREMENTOR = 4;
        private const int ADD = 10;
        private const int SUB = 11;
        private const int MUL = 12;
        private const int DIV = 13;
        private const int MOV = 14;
        private const int LDB = 15;
        private const int LDR = 16;
        private const int TRP = 17;
        private const int ADI = 18;
        private const int LDA = 19;
        private const int LDRR = 20;
        private const int STR = 21;
        private const int STB = 22;
        private const int JMP = 23;
        private const int JMR = 24;
        private const int BNZ = 25;
        private const int BGT = 26;
        private const int BLT = 27;
        private const int BRZ = 28;
        private const int CMP = 29;
        private const int LDBR = 30;
        private const int RUN = 31;
        private const int END = 32;
        private const int BLK = 33;
        private const int LCK = 34;
        private const int ULK = 35;
        private int pc;
        private int startOfCode;
        private int stackBase;
        private int stackLimit;
        private string fileName;
        private byte[] memory;
        int i;
        Hashtable labels;
        ArrayList jumpLabels;
        #endregion

        public Assembler(string fName)
        {
            pc = 0;
            startOfCode = 0;
            stackBase = SIZE_OF_MEM;
            stackLimit = SIZE_OF_RUNTIME_STACK;
            fileName = fName;
            memory = new byte[SIZE_OF_MEM];
            labels = new Hashtable();
            jumpLabels = new ArrayList();
        }

        public void runAssembler()
        {
            //function variables
            string line;
            string command;
            string[] lineArray;
            byte[] inputByteArray;
            ArrayList functions = getFunctions();
            ArrayList registers = getRegisters();

            //First Pass. Insert Data
            #region FirstPass
            string[] firstPass = System.IO.File.ReadAllLines(fileName);

            foreach (string entireLine in firstPass)
            {
                i = 0;
                if (entireLine.Contains(';'))
                {
                    line = entireLine.Substring(0, entireLine.IndexOf(";"));

                    lineArray = line.Split(' ');
                    if (!functions.Contains(lineArray[i].ToUpper()) && !functions.Contains(lineArray[i + 1].ToUpper()))
                    {
                        //If not ARR
                        if (notPartOfARR(lineArray[i]))
                        {
                            //Add Label to HashTable
                            labels.Add(lineArray[i++], pc);
                        }

                        if (lineArray[i].ToUpper().Equals(".INT"))
                        {
                            inputByteArray = BitConverter.GetBytes(Convert.ToInt32(lineArray[++i]));
                            Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                        }
                        else if (lineArray[i].ToUpper().Equals(".BYT"))
                        {
                            inputByteArray = BitConverter.GetBytes(Convert.ToChar(lineArray[++i]));
                            Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                        }

                        pc += INCREMENTOR;
                    }
                }
            }
            #endregion

            startOfCode = pc;

            //Second Pass
            #region SecondPass
            string[] secondPass = System.IO.File.ReadAllLines(fileName);

            foreach (string entireLine in secondPass)
            {
                if (entireLine.Contains(';'))
                {
                    line = entireLine.Substring(0, entireLine.IndexOf(";"));

                    i = 0;
                    lineArray = line.Split(' ');
                    if (functions.Contains(lineArray[i].ToUpper()) || functions.Contains(lineArray[i + 1].ToUpper()))
                    {
                        //If Labeled instruction
                        if (!functions.Contains(lineArray[i].ToUpper()))
                        {
                            labels.Add(lineArray[i], pc);
                            jumpLabels.Add(lineArray[i]);
                            i++;
                        }

                        //If LDR Label
                        if (lineArray[i].Equals("LDR") && registers.Contains(lineArray[i + 2]))
                        {
                            command = "LDRR";
                            i++;
                        }
                        else if (lineArray[i].Equals("LDB") && registers.Contains(lineArray[i + 2]))
                        {
                            command = "LDBR";
                            i++;
                        }
                        else
                        {
                            command = lineArray[i++];
                        }

                        switch (command.ToUpper())
                        {
                            #region ADD
                            case "ADD":
                                inputByteArray = BitConverter.GetBytes(ADD);//10
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region ADI
                            case "ADI":
                                inputByteArray = BitConverter.GetBytes(ADI);//18
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(Convert.ToInt32(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region SUB
                            case "SUB":
                                inputByteArray = BitConverter.GetBytes(SUB);//11
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region MUL
                            case "MUL":
                                inputByteArray = BitConverter.GetBytes(MUL);//12
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region DIV
                            case "DIV":
                                inputByteArray = BitConverter.GetBytes(DIV);//13
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region MOV
                            case "MOV":
                                inputByteArray = BitConverter.GetBytes(MOV);//14
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region LDB
                            case "LDB":
                                inputByteArray = BitConverter.GetBytes(LDB);//15
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(Convert.ToChar(labels[lineArray[i]]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region LDBR
                            case "LDBR":
                                inputByteArray = BitConverter.GetBytes(LDBR);//15
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region LDR
                            case "LDR":
                                inputByteArray = BitConverter.GetBytes(LDR);//16
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(Convert.ToInt32(labels[lineArray[i]]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region LDRR
                            case "LDRR":
                                inputByteArray = BitConverter.GetBytes(LDRR);//20
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region LDA
                            case "LDA":
                                inputByteArray = BitConverter.GetBytes(LDA);//19
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(Convert.ToInt32(labels[lineArray[i]]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region STR
                            case "STR":
                                inputByteArray = BitConverter.GetBytes(STR);//21
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region STB
                            case "STB":
                                inputByteArray = BitConverter.GetBytes(STB);//22
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region JMP
                            case "JMP":
                                inputByteArray = BitConverter.GetBytes(JMP);//23
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                if (!jumpLabels.Contains(lineArray[i]))
                                    jumpLabels.Add(lineArray[i]);
                                inputByteArray = BitConverter.GetBytes(jumpLabels.IndexOf(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region JMR
                            case "JMR":
                                inputByteArray = BitConverter.GetBytes(JMR);//24
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region BNZ
                            case "BNZ":
                                inputByteArray = BitConverter.GetBytes(BNZ);//25
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                if (!jumpLabels.Contains(lineArray[i]))
                                    jumpLabels.Add(lineArray[i]);
                                inputByteArray = BitConverter.GetBytes(jumpLabels.IndexOf(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region BGT
                            case "BGT":
                                inputByteArray = BitConverter.GetBytes(BGT);//26
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                if (!jumpLabels.Contains(lineArray[i]))
                                    jumpLabels.Add(lineArray[i]);
                                inputByteArray = BitConverter.GetBytes(jumpLabels.IndexOf(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region BLT
                            case "BLT":
                                inputByteArray = BitConverter.GetBytes(BLT);//27
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                if (!jumpLabels.Contains(lineArray[i]))
                                    jumpLabels.Add(lineArray[i]);
                                inputByteArray = BitConverter.GetBytes(jumpLabels.IndexOf(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region BRZ
                            case "BRZ":
                                inputByteArray = BitConverter.GetBytes(BRZ);//28
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                if (!jumpLabels.Contains(lineArray[i]))
                                    jumpLabels.Add(lineArray[i]);
                                inputByteArray = BitConverter.GetBytes(jumpLabels.IndexOf(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region CMP
                            case "CMP":
                                inputByteArray = BitConverter.GetBytes(CMP);//29
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region TRP
                            case "TRP":
                                inputByteArray = BitConverter.GetBytes(TRP);//17
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(Convert.ToInt32(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region RUN
                            case "RUN":
                                inputByteArray = BitConverter.GetBytes(RUN);//31
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                inputByteArray = BitConverter.GetBytes(regNum(lineArray[i++]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                pc += INCREMENTOR;
                                if (!jumpLabels.Contains(lineArray[i]))
                                    jumpLabels.Add(lineArray[i]);
                                inputByteArray = BitConverter.GetBytes(jumpLabels.IndexOf(lineArray[i]));
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region END
                            case "END":
                                inputByteArray = BitConverter.GetBytes(END);//32
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region BLK
                            case "BLK":
                                inputByteArray = BitConverter.GetBytes(BLK);//33
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region LCK
                            case "LCK":
                                inputByteArray = BitConverter.GetBytes(LCK);//34
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                            #region ULK
                            case "ULK":
                                inputByteArray = BitConverter.GetBytes(ULK);//35
                                Array.Copy(inputByteArray, 0, memory, pc, inputByteArray.Length);
                                break;
                            #endregion
                        }

                        pc += INCREMENTOR;
                    }
                }
            }
            #endregion
        }

        public int[] getLineToExe(int index)
        {
            int n = index;
            int[] retVal = new int[3];
            retVal[0] = BitConverter.ToInt32(memory, n);
            n += INCREMENTOR;
            retVal[1] = BitConverter.ToInt32(memory, n);
            n += INCREMENTOR;
            retVal[2] = BitConverter.ToInt32(memory, n);

            return retVal;
        }

        public int getByteData(int index)
        {
            return Convert.ToByte(memory[index]);
        }

        public int getData(int index)
        {
            return BitConverter.ToInt32(memory, index);
        }

        public int getJumpPC(int index)
        {
            return Convert.ToInt32(labels[jumpLabels[index]]);
        }

        public int getStartOfPC()
        {
            return startOfCode;
        }

        public int getStartOfSB()
        {
            return stackBase;
        }

        public int getStartOfSL()
        {
            return stackLimit;
        }

        public void storeData(int data, int index)
        {
            byte[] byteArray = BitConverter.GetBytes(data);
            Array.Copy(byteArray, 0, memory, index, byteArray.Length);
        }

        public void storeByte(int data, int index)
        {
            byte[] byteArray = BitConverter.GetBytes(Convert.ToChar(data));
            Array.Copy(byteArray, 0, memory, index, 1);
        }

        private ArrayList getFunctions()
        {
            ArrayList functions = new ArrayList();
            functions.Add("ADD");
            functions.Add("ADI");
            functions.Add("SUB");
            functions.Add("MUL");
            functions.Add("DIV");

            functions.Add("MOV");
            functions.Add("LDA");
            functions.Add("LDB");
            functions.Add("LDR");
            functions.Add("STR");
            functions.Add("STB");

            functions.Add("JMP");
            functions.Add("JMR");
            functions.Add("BNZ");
            functions.Add("BGT");
            functions.Add("BLT");
            functions.Add("BRZ");

            functions.Add("CMP");

            functions.Add("TRP");

            functions.Add("RUN");
            functions.Add("END");
            functions.Add("BLK");
            functions.Add("LCK");
            functions.Add("ULK");

            return functions;
        }

        private ArrayList getRegisters()
        {
            const int NUM_OF_REGS = 15;
            ArrayList registers = new ArrayList();

            for (int x = 0; x < NUM_OF_REGS; x++)
            {
                registers.Add("R" + x);
            }

            registers.Add("PC");
            registers.Add("FP");
            registers.Add("SP");
            registers.Add("SB");
            registers.Add("SL");

            return registers;
        }

        private int regNum(string register)
        {
            if (register.Equals("PC"))
                return 10;
            else if (register.Equals("FP"))
                return 11;
            else if (register.Equals("SP"))
                return 12;
            else if (register.Equals("SB"))
                return 13;
            else if (register.Equals("SL"))
                return 14;
            else
            {
                string reg = register.Substring(1, register.Length - 1);
                return Convert.ToInt32(reg);
            }
        }

        private bool notPartOfARR(string line)
        {
            if (line.Equals(".INT") || line.Equals(".BYT"))
                return false;
            else
                return true;
        }
    }
}