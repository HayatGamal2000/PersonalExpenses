module BIT_SYNC #(parameter NUM_STAGES=2,BUS_WIDTH=1)
(
input  wire [BUS_WIDTH-1:0] ASYNC,
input  wire                 CLK,
input  wire                 RST,
output reg  [BUS_WIDTH-1:0] SYNC
);

reg [NUM_STAGES-1:0] Stages [BUS_WIDTH-1:0]; 
integer i;

always@(posedge CLK or negedge RST)
begin
  if(!RST)
    begin
    for(i=0;i<BUS_WIDTH;i=i+1)
    begin
    Stages[i]<='b0;
    SYNC<='b0;
  end
  end
  else
    begin
      for(i=0;i<BUS_WIDTH;i=i+1)
      begin
        Stages[i][0] <= ASYNC[i];
        {SYNC[i],Stages[i][NUM_STAGES-1:1]}<= Stages[i];
        end
      end   
end

endmodule

