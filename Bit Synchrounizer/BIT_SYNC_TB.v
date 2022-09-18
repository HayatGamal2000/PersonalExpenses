module BIT_SYNC_TB();
//TB Parameters
parameter BUS_WIDTH_TB = 2;
parameter NUM_STAGES_TB = 4;
parameter CLK_Period = 10;
//TB Signals
 reg  [BUS_WIDTH_TB-1:0] ASYNC_TB; 
 reg                     CLK_TB;   
 reg                     RST_TB;  
 wire [BUS_WIDTH_TB-1:0] SYNC_TB;
 
 integer    BIT_NUM;
//initial block
initial
 begin
   
   $dumpfile("BIT_SYNC.vcd");
   $dumpvars;
   
   initialize();
   
   reset();
   ASYNC_TB='b11;
   for(BIT_NUM=1;BIT_NUM<=BUS_WIDTH_TB;BIT_NUM=BIT_NUM+1)
   begin
     check_out(ASYNC_TB[BIT_NUM-1],BIT_NUM);
   end
   #100
   $stop;
 end
//********TASKS********
//Signals initialization task
task initialize;
  begin
    CLK_TB='b1;
    RST_TB='b1;
    ASYNC_TB='b0;
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
//Check OUT TASK
task check_out ;
  input reg        async;
  input integer    bit_number;
  
  integer i;
  
  reg [NUM_STAGES_TB:0] gener_out ;
  
  begin 
    for (i=0;i<=NUM_STAGES_TB;i=i+1)
    begin
      #CLK_Period gener_out[i]=SYNC_TB;
    end
    if(gener_out[NUM_STAGES_TB]==async)
      begin
      $display("Test case for bit %d is passed",bit_number);
      $display("Latency = %d",i-1);
    end
  else
       $display("Test case for bit %d is failed",bit_number);
  end
endtask
//////Clock Generation//////  
always #5 CLK_TB = ~CLK_TB;
//instantation
BIT_SYNC #(.BUS_WIDTH(BUS_WIDTH_TB),.NUM_STAGES(NUM_STAGES_TB)) DUT (
.ASYNC(ASYNC_TB),
.CLK(CLK_TB), 
.RST(RST_TB), 
.SYNC(SYNC_TB) 
);
endmodule
