module DATA_SYNC_TB ();
//TB Parameters
parameter NUM_STAGES_TB=2;
parameter DATA_WIDTH_TB=8;
//TB Signals 
 reg   [DATA_WIDTH_TB-1:0]  unsync_bus_TB; 
 reg                        bus_enable_TB;  
 reg                        CLK_TB;         
 reg                        RST_TB;         
 wire  [DATA_WIDTH_TB-1:0]  sync_bus_TB;    
 wire                       enable_pulse_TB;  
 
 parameter ClOCK_Period  = 10;
 parameter check_data_delay = (NUM_STAGES_TB+2)*ClOCK_Period;
  
 //initial block
initial
 begin
   
   $dumpfile("BIT_SYNC.vcd");
   $dumpvars;
   
   initialize();
   
   reset();
   //asserting enable and inserting data
   bus_enable_TB=1'b1;
   unsync_bus_TB='b101101;
   //deasserting anable after one clock cycle
   #ClOCK_Period
   bus_enable_TB=1'b0;
   //checking data after four clock cycles from inserting data
   #check_data_delay //there was one clock cycle for enable deassertion
   if(sync_bus_TB == 'b101101 )
     $display("data is synchronized");
   else
     $display("data is not synchronized");
   
   #20
   
   //asserting enable and inserting data
   bus_enable_TB=1'b1;
   unsync_bus_TB='b11011011;
   //deasserting anable after one clock cycle
   #ClOCK_Period
   bus_enable_TB=1'b0;
   //checking data after four clock cycles from inserting data
   #check_data_delay //there was one clock cycle for enable deassertion
   if(sync_bus_TB == 'b11011011 )
     $display("data is synchronized");
   else
     $display("data is not synchronized");
  
   #100
   $stop;
 end
//********TASKS********
//Signals initialization task
task initialize;
  begin
    CLK_TB='b1;
    RST_TB='b1;
    bus_enable_TB='b0;
    unsync_bus_TB='b0;
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
//instantiation
DATA_SYNC #(.NUM_STAGES(NUM_STAGES_TB),.DATA_WIDTH(DATA_WIDTH_TB)) DUT(
.unsync_bus(unsync_bus_TB), 
.bus_enable(bus_enable_TB), 
.CLK(CLK_TB),        
.RST(RST_TB),        
.sync_bus(sync_bus_TB),   
.enable_pulse(enable_pulse_TB)
);
endmodule
