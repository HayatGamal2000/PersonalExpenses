module RST_SYNC_TB ();
//TB parameters 
parameter NUM_STAGES_TB =4;
//TB Signals
 reg   RST_TB;   
 reg   CLK_TB;     
 wire  SYNC_RST_TB;
 
    
 parameter ClOCK_Period  = 10;
 parameter check_data_befor_edge = NUM_STAGES_TB*ClOCK_Period - 2;
 parameter check_data_after_edge = NUM_STAGES_TB*ClOCK_Period + 1;
 
 initial
 begin
   
   $dumpfile("RST_SYNC.vcd");
   $dumpvars;
   
   initialize();
   reset();
//checkiing asynchronous assertion
#1
 if(SYNC_RST_TB == 1'b0)
   $display("assertion of reset is asynchronized");
 else
   $display("asynchronized assertion of reset is failed");

 
 #check_data_befor_edge
  if(SYNC_RST_TB == 1'b0 )
   $display("deassertion of reset is ");
 else
   $display("synchronized deassertion of reset is failed");
 
  #check_data_after_edge
  if(SYNC_RST_TB == 1'b1)
   $display("synchronized");
 else
   $display("failed to be synchronized");
   
   #100
   $stop;
 end
 //********TASKS********
//Signals initialization task
task initialize;
  begin
    CLK_TB='b1;
    RST_TB='b1;
  end
endtask
//reset task
task reset;
  begin
    RST_TB ='b1;
    #10
    RST_TB ='b0;
    #10
    RST_TB ='b1;
  end
endtask
//////Clock Generation//////  
always #5 CLK_TB = ~CLK_TB;
////instantation 
RST_SYNC #(.NUM_STAGES(NUM_STAGES_TB)) DUT (
.RST(RST_TB),      
.CLK(CLK_TB),      
.SYNC_RST(SYNC_RST_TB)
);
endmodule
