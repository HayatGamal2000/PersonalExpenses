module ALU_TB ();
  
  reg   [15:0] A_tb,B_tb;
  reg   [3:0]  ALU_FUN_tb;
  reg          CLK_tb;
  wire  [15:0] ALU_OUT_tb;
  wire         Arith_flag_tb;
  wire         Logic_flag_tb;
  wire         CMP_flag_tb;
  wire         Shift_flag_tb;
  
  //initial block
initial 
  begin
    $dumpfile("ALU.vcd") ;
    $dumpvars ;
    //initial values
    A_tb = 16'd20 ;  
    B_tb = 16'd5 ;
    ALU_FUN_tb = 4'b0 ;
    CLK_tb = 1'b0 ;
 
    #6
    //Arthemetic test
    $display ("TEST CASE 1") ;  // test addition Function
    if (ALU_OUT_tb == 16'd25)
      $display ("TEST CASE 1 IS PASSED ") ;
    else
      $display ("TEST CASE 1 IS FAILED") ;
      
    $display (" TEST CASE 2") ;  // test subtraction Function
    #5
    ALU_FUN_tb =4'b0001;
    #5
    if (ALU_OUT_tb == 16'd15)
      $display ("TEST CASE 2 IS PASSED") ;
    else
      $display ("TEST CASE 2 IS FAILED") ;
      
    $display ("TEST CASE 3") ;  // test Multiblication Function
      #5
    ALU_FUN_tb =4'b0010;
    #5
    if(ALU_OUT_tb == 16'd100)
      $display ("TEST CASE 3 IS PASSED") ;
    else
      $display ("TEST CASE 3 IS FAILED") ;
      
    $display ("TEST CASE 4") ;  // test Arithmetic flag 
    if(Arith_flag_tb == 4'b1)
      $display ("TEST CASE 4 IS PASSED") ;
    else
      $display ("TEST CASE 4 IS FAILED ") ;
      
    $display ("TEST CASE 5") ;  // test Division Function
    #5
    ALU_FUN_tb =4'b0011;
    #5
    if(ALU_OUT_tb == 16'd4)
      $display ("TEST CASE 5 IS PASSED") ;
    else
      $display ("TEST CASE 5 IS FAILED") ;
      
    
  //Logic test
    $display ("TEST CASE 6") ;  // test AND Function
    #5
    ALU_FUN_tb =4'b0100;
    #5
    if (ALU_OUT_tb == 16'b100)
      $display ("TEST CASE 6 IS PASSED") ;
    else
      $display ("TEST CASE 6 IS FAILED") ;
      
    $display (" TEST CASE 7") ;  // test OR Function
    #5
    ALU_FUN_tb =4'b0101;
    #5
    if (ALU_OUT_tb == 16'b10101)
      $display ("TEST CASE 7 IS PASSED") ;
    else
      $display ("TEST CASE 7 IS FAILED") ;
    
    $display ("TEST CASE 8") ;  // test NAND Function
      #5
    ALU_FUN_tb =4'b0110;
    #5
    if(ALU_OUT_tb == 16'b1111111111111011)
      $display ("TEST CASE 8 IS PASSED") ;
    else
      $display ("TEST CASE 8 IS FAILED") ;
      
    $display ("TEST CASE 9") ;  // test NOR Function
    #5
    ALU_FUN_tb =4'b0111;
    #5
    if(ALU_OUT_tb == 16'b1111111111101010)
      $display ("TEST CASE 9 IS PASSED") ;
    else
      $display ("TEST CASE 9 IS FAILED") ;
      
      $display ("TEST CASE 10") ; //test Logic Flag
      if(Logic_flag_tb == 4'b1)
      $display ("TEST CASE 10 IS PASSED") ; 
    else
      $display ("TEST CASE 10 IS FAILED") ; 
      
      $display ("TEST CASE 11") ;  // test XOR Function 
    #5
    ALU_FUN_tb = 4'b1000;
    #5
    if(ALU_OUT_tb == 16'b10001)
      $display ("TEST CASE 11 IS PASSED") ; 
    else
      $display ("TEST CASE 11 IS FAILED") ; 
      
     $display ("TEST CASE 12") ;  // test XNOR Function 
    #5
    ALU_FUN_tb = 4'b1001;
    #5
    if(ALU_OUT_tb == 16'b1111111111101110)
      $display ("TEST CASE 12 IS PASSED") ; 
    else
      $display ("TEST CASE 12 IS FAILED") ; 
    
    //Comparator Test
    
     $display ("TEST CASE 13") ;  // test equal Function
    #5
    ALU_FUN_tb =4'b1010;
    #5
    if(ALU_OUT_tb == 16'd1)
      $display ("TEST CASE 13 IS FAILED") ;
    else
      $display ("TEST CASE 13 IS PASSED") ;
      
      $display ("TEST CASE 14") ; //test compare Flag
      if(CMP_flag_tb == 4'b1)
      $display ("TEST CASE 14 IS PASSED") ; 
    else
      $display ("TEST CASE 14 IS FAILED") ; 
      
    $display ("TEST CASE 15") ;  // test greater than Function 
    #5
    ALU_FUN_tb = 4'b1011;
    #5
    if(ALU_OUT_tb == 16'b10)
      $display ("TEST CASE 15 IS PASSED") ; 
    else
      $display ("TEST CASE 15 IS FAILED") ; 
      
    $display ("TEST CASE 16") ;  // test less than Function 
    #5
    ALU_FUN_tb = 4'b1100;
    #5
    if(ALU_OUT_tb == 16'b101)
      $display ("TEST CASE 16 IS FAILED") ; 
    else
      $display ("TEST CASE 16 IS PASSED") ; 
      
    //Shift test
    $display ("TEST CASE 17") ;  // test shift right Function 
    #5
    ALU_FUN_tb = 4'b1101;
    #5
    if(ALU_OUT_tb == 16'b1010)
      $display ("TEST CASE 17 IS PASSED") ; 
    else
      $display ("TEST CASE 17 IS FAILED") ; 
      
    $display ("TEST CASE 18") ;  // test shift left Function 
    #5
    ALU_FUN_tb = 4'b1110;
    #5
    if(ALU_OUT_tb == 16'b101000)
      $display ("TEST CASE 18 IS PASSED") ; 
    else
      $display ("TEST CASE 18 IS FAILED") ; 
      
    $display ("TEST CASE 19") ; //test shift Flag
      if(Shift_flag_tb == 4'b1)
      $display ("TEST CASE 19 IS PASSED") ; 
    else
      $display ("TEST CASE 19 IS FAILED") ; 
          
    #50
    $finish ;
  end
  
// Clock Generator  
  always #5 CLK_tb = !CLK_tb ;
    
    
// instaniate design instance 
  ALU DUT (
    .A(A_tb),
    .B(B_tb), 
    .ALU_FUN(ALU_FUN_tb), 
    .CLK(CLK_tb),
    .ALU_OUT(ALU_OUT_tb),
    .Arith_flag(Arith_flag_tb),
    .Logic_flag(Logic_flag_tb),
    .CMP_flag(CMP_flag_tb),
    .Shift_flag(Shift_flag_tb)
  );

  
endmodule
