module RST_SYNC #(parameter NUM_STAGES=1) (
  input  wire  RST,
  input  wire  CLK,
  output reg   SYNC_RST
);

reg [NUM_STAGES-1:0] Stages;

always @ (posedge CLK or negedge RST)
begin
  if(!RST)
    begin
      Stages <='b0;
      SYNC_RST <=1'b1;
    end
    else
      begin
        Stages[0] <= 1'b1;
        Stages[NUM_STAGES-1:1]<= Stages;
        end
end
  always @(*)
 begin
    SYNC_RST = Stages[NUM_STAGES-1] ; 
 end 
endmodule
