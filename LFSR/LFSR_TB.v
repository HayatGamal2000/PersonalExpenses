`timescale 1us/1ns

module LFSR_TB ();
  
//DUT signals
reg [3:0]    Seed_TB;
reg          RST_TB; 
reg          CLK_TB;
wire         OUT_TB;
wire         Valid_TB;


initial
begin
  //initial values
  CLK_TB=1;
  RST_TB=1;
  Seed_TB=4'b1001;
  
  #0.5
  RST_TB=0;
  #1
  RST_TB=1;
  
  #9
  if(OUT_TB&&Valid_TB)
    $display("***Test Case 1 PASSED");
  else
    $display("***Test Case 1 FAILED"); 
  #1
  if(OUT_TB&&Valid_TB)
    $display("***Test Case 2 PASSED");
  else
    $display("***Test Case 2 FAILED") ;
  #1
    if(!OUT_TB&&Valid_TB)
    $display("***Test Case 3 PASSED");
  else
    $display("***Test Case 3 FAILED") ;  
    #1
   if(!OUT_TB&&Valid_TB)
    $display("***Test Case 4 PASSED");
  else
    $display("***Test Case 4 FAILED") ;
  
  #100
  $stop;
end

//Clock Generation
always #0.5 CLK_TB=~ CLK_TB;

//instansiation
LFSR DUT(
 .Seed(Seed_TB), 
 .RST(RST_TB),  
 .CLK(CLK_TB),  
 .OUT(OUT_TB),
 .Valid(Valid_TB)
);


endmodule
