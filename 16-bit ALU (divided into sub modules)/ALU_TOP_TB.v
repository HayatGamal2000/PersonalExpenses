module ALU_TOP_TB ();
  
//TB Parameters
parameter OP_DATA_WIDTH_TB = 16;
parameter Arith_OUT_WIDTH_TB = OP_DATA_WIDTH_TB + OP_DATA_WIDTH_TB;
parameter Logic_OUT_WIDTH_TB = OP_DATA_WIDTH_TB;
parameter Shift_OUT_WIDTH_TB = OP_DATA_WIDTH_TB;
parameter CMP_OUT_WIDTH_TB = 3;
  
//Clock Period
parameter CLK_PERIOD = 10 ,
          HIGH_PERIOD = 0.6 * CLK_PERIOD ,
          LOW_PERIOD = 0.4 * CLK_PERIOD;
  
//TB Signals
  reg   [OP_DATA_WIDTH_TB-1:0]      A_TB;
  reg   [OP_DATA_WIDTH_TB-1:0]      B_TB;
  reg   [3:0]                       ALU_FUN_TB;
  reg                               CLK_TB;
  reg                               RST_TB;
  wire  [Arith_OUT_WIDTH_TB-1:0]    Arith_OUT_TB;
  wire                              Carry_OUT_TB;
  wire                              Arith_Flag_TB;
  wire  [Logic_OUT_WIDTH_TB-1:0]    Logic_OUT_TB;
  wire                              Logic_Flag_TB;
  wire  [CMP_OUT_WIDTH_TB-1:0]      CMP_OUT_TB;
  wire                              CMP_Flag_TB;
  wire  [Shift_OUT_WIDTH_TB-1:0]    Shift_OUT_TB;
  wire                              Shift_Flag_TB ; 

//concatenate flags
wire  [4:0]    Flags ;

assign Flags = {Carry_OUT_TB, Arith_Flag_TB, Logic_Flag_TB, CMP_Flag_TB, Shift_Flag_TB};

initial 
  begin
  $dumpfile("ALU.vcd");
  $dumpvars;
  
//initial values
CLK_TB = 1'b0;
RST_TB = 1;
A_TB = 30;
B_TB =10;

  $display ("**** TEST CASE 1 ****");
ALU_FUN_TB = 4'b0000;
#CLK_PERIOD
#CLK_PERIOD


if(Arith_OUT_TB == 'd40 && Flags == 5'b01000 )
  $display ("Addition IS PASSED");
else
  $display ("Addition IS FAILED");
  
  
$display("**** TEST CASE 2 ****");
ALU_FUN_TB = 4'b0001;
#CLK_PERIOD

if(Arith_OUT_TB == 'd20 && Flags == 5'b01000 )
  $display ("Subtraction IS PASSED");
else
  $display ("Subtraction IS FAILED");  


$display("**** TEST CASE 3 ****");
ALU_FUN_TB = 4'b0010;
#CLK_PERIOD

if(Arith_OUT_TB == 'd300 && Flags == 5'b01000 )
  $display ("Multiblication IS PASSED");
else
  $display ("Multiblication IS FAILED"); 


$display("**** TEST CASE 4 ****");
ALU_FUN_TB = 4'b0011;
#CLK_PERIOD

if(Arith_OUT_TB == 'd3 && Flags == 5'b01000 )
  $display ("Division IS PASSED");
else
  $display ("Division IS FAILED"); 


$display("**** TEST CASE 5 ****");
ALU_FUN_TB = 4'b0100;
#CLK_PERIOD

if(Logic_OUT_TB == 'b1010 && Flags == 5'b00100 )
  $display ("ANDING IS PASSED");
else
  $display ("ANDING IS FAILED"); 
  
  
  $display("**** TEST CASE 6 ****");
ALU_FUN_TB = 4'b0101;
#CLK_PERIOD

if(Logic_OUT_TB == 'b11110 && Flags == 5'b00100 )
  $display ("ORING IS PASSED");
else
  $display ("ORING IS FAILED"); 
  
  $display("**** TEST CASE 7 ****");
ALU_FUN_TB = 4'b0110;
#CLK_PERIOD

if(Logic_OUT_TB == 'hfff5 && Flags == 5'b00100 )
  $display ("NANDING IS PASSED");
else
  $display ("NANDING IS FAILED"); 
  
  
  $display("**** TEST CASE 8 ****");
ALU_FUN_TB = 4'b0111;
#CLK_PERIOD

if(Logic_OUT_TB == 'hffe1 && Flags == 5'b00100 )
  $display ("NORING IS PASSED");
else
  $display ("NORING IS FAILED"); 
  
  
  $display("**** TEST CASE 9 ****");
ALU_FUN_TB = 4'b1000;
#CLK_PERIOD

if(CMP_OUT_TB == 3'b0 && Flags == 5'b00010 )
  $display ("NOP IS PASSED");
else
  $display ("NOP IS FAILED"); 
  
  
  $display("**** TEST CASE 10 ****");
A_TB = 30;
B_TB =30;
ALU_FUN_TB = 4'b1001;
#CLK_PERIOD

if(CMP_OUT_TB == 3'b1 && Flags == 5'b00010 )
  $display ("Equalitty Operation IS PASSED");
else
  $display ("Equalitty Operation IS FAILED");
  
  
  $display("**** TEST CASE 11 ****");
A_TB = 30;
B_TB =10;
ALU_FUN_TB = 4'b1010;
#CLK_PERIOD

if(CMP_OUT_TB == 3'b10 && Flags == 5'b00010 )
  $display ("Greater Than Operation IS PASSED");
else
  $display ("Greater Than Operation IS FAILED");
  
  
  $display("**** TEST CASE 12 ****");
A_TB = 10;
B_TB =30;
ALU_FUN_TB = 4'b1011;
#CLK_PERIOD

if(CMP_OUT_TB == 3'b11&& Flags == 5'b00010 )
  $display ("Less Than Operation IS PASSED");
else
  $display ("Less Than Operation IS FAILED");
  
  
  $display ("**** TEST CASE 13 ****");
A_TB = 30;
B_TB = 10;
ALU_FUN_TB = 4'b1100;
#CLK_PERIOD

if(Shift_OUT_TB == 'b1111&& Flags == 5'b00001 )
  $display ("A Shift Right IS PASSED");
else
  $display ("A Shift Right IS FAILED");
  
  
  $display ("**** TEST CASE 14 ****");
ALU_FUN_TB = 4'b1101;
#CLK_PERIOD

if(Shift_OUT_TB == 'b111100&& Flags == 5'b00001 )
  $display ("A Shift Left IS PASSED");
else
  $display ("A Shift Left IS FAILED");
  

  $display ("**** TEST CASE 15 ****");
ALU_FUN_TB = 4'b1110;
#CLK_PERIOD

if(Shift_OUT_TB == 'b101 && Flags == 5'b00001 )
  $display ("B Shift Right IS PASSED");
else
  $display ("B Shift Right IS FAILED");
  

  $display ("**** TEST CASE 16 ****");
ALU_FUN_TB = 4'b1111;
#CLK_PERIOD

if(Shift_OUT_TB == 'b10100 && Flags == 5'b00001 )
  $display ("B Shift Left IS PASSED");
else
  $display ("B Shift Left IS FAILED");
  
  
  $display ("**** TEST CASE 17 ****");
RST_TB = 0;
#CLK_PERIOD

if(Arith_OUT_TB == 'b0 && Logic_OUT_TB == 'b0 && Shift_OUT_TB == 'b0 && CMP_OUT_TB == 'b0 && Arith_Flag_TB == Logic_Flag_TB == CMP_Flag_TB == Shift_Flag_TB == 1'b0)
  $display ("RST IS PASSED");
else
  $display ("RST IS FAILED");
  
#300 $finish;  
end

//Clock generator with 100 KHZ (10us)
always
begin
  #LOW_PERIOD CLK_TB = ~CLK_TB;
  #HIGH_PERIOD CLK_TB = ~CLK_TB;
end

//instnsiation
ALU_TOP #(.OP_DATA_WIDTH(OP_DATA_WIDTH_TB)) DUT (
.A(A_TB),
.B(B_TB),
.ALU_FUN(ALU_FUN_TB),
.CLK(CLK_TB),
.RST(RST_TB),
.Arith_OUT(Arith_OUT_TB),
.Carry_OUT(Carry_OUT_TB),
.Arith_Flag(Arith_Flag_TB),
.Logic_OUT(Logic_OUT_TB),
.Logic_Flag(Logic_Flag_TB),
.CMP_OUT(CMP_OUT_TB),
.CMP_Flag(CMP_Flag_TB),
.Shift_OUT(Shift_OUT_TB),
.Shift_Flag(Shift_Flag_TB)
);

  
endmodule
