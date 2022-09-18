module ALU_TOP 
#(parameter OP_DATA_WIDTH = 16,
            Arith_OUT_WIDTH = OP_DATA_WIDTH + OP_DATA_WIDTH,
            Logic_OUT_WIDTH = OP_DATA_WIDTH,
            Shift_OUT_WIDTH = OP_DATA_WIDTH,
            CMP_OUT_WIDTH = 3
  )
  
  (
  input  wire  [OP_DATA_WIDTH-1:0]    A,
  input  wire  [OP_DATA_WIDTH-1:0]    B,
  input  wire  [3:0]                  ALU_FUN,
  input  wire                         CLK,
  input  wire                         RST,
  output wire  [Arith_OUT_WIDTH-1:0]  Arith_OUT,
  output wire                         Carry_OUT,
  output wire                         Arith_Flag,
  output wire  [Logic_OUT_WIDTH-1:0]  Logic_OUT,
  output wire                         Logic_Flag,
  output wire  [CMP_OUT_WIDTH-1:0]    CMP_OUT,
  output wire                         CMP_Flag,
  output wire  [Shift_OUT_WIDTH-1:0]  Shift_OUT,
  output wire                         Shift_Flag                    
  );
  
  //internal signals 
  wire      Arith_Enable;
  wire      Logic_Enable;
  wire      CMP_Enable;
  wire      Shift_Enable;
  
  //instiation of ALU Units
  
  Decoder_Unit U_decoder (
  .ALU_FUN(ALU_FUN[3:2]),
  .Arith_Enable(Arith_Enable),
  .Logic_Enable(Logic_Enable),
  .CMP_Enable(CMP_Enable),
  .Shift_Enable(Shift_Enable)
  );
  
  ARITHMETIC_UNIT #(.IN_DATA_WIDTH(OP_DATA_WIDTH),.OUT_DATA_WIDTH(Arith_OUT_WIDTH)) U_arithmatic_unit (
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN[1:0]),
  .CLK(CLK),
  .RST(RST),
  .Arith_Enable(Arith_Enable),
  .Arith_OUT(Arith_OUT),
  .Carry_OUT(Carry_OUT),
  .Arith_Flag(Arith_Flag)
  );
  
  LOGIC_UNIT #(.IN_DATA_WIDTH(OP_DATA_WIDTH),.OUT_DATA_WIDTH(Logic_OUT_WIDTH)) U_logic_unit (
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN[1:0]),
  .CLK(CLK),
  .RST(RST),
  .Logic_Enable(Logic_Enable),
  .Logic_OUT(Logic_OUT),
  .Logic_Flag(Logic_Flag)
  );
  
  CMP_UNIT #(.IN_DATA_WIDTH(OP_DATA_WIDTH),.OUT_DATA_WIDTH(CMP_OUT_WIDTH)) U_CMP_unit (
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN[1:0]),
  .CLK(CLK),
  .RST(RST),
  .CMP_Enable(CMP_Enable),
  .CMP_OUT(CMP_OUT),
  .CMP_Flag(CMP_Flag)
  );
  
  SHIFT_UNIT #(.IN_DATA_WIDTH(OP_DATA_WIDTH),.OUT_DATA_WIDTH(Shift_OUT_WIDTH)) U_shift_unit (
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN[1:0]),
  .CLK(CLK),
  .RST(RST),
  .Shift_Enable(Shift_Enable),
  .Shift_OUT(Shift_OUT),
  .Shift_Flag(Shift_Flag)
  );
  
endmodule