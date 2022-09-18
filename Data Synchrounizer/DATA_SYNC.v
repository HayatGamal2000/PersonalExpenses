module DATA_SYNC #(parameter NUM_STAGES=2,
                             DATA_WIDTH = 8)
                             (
input  wire [DATA_WIDTH-1:0]  unsync_bus,
input  wire                   bus_enable,
input  wire                   CLK,
input  wire                   RST,
output reg  [DATA_WIDTH-1:0]  sync_bus,
output reg                    enable_pulse
);



wire [DATA_WIDTH-1:0] BIT_SYNC_OUT;
reg  [DATA_WIDTH-1:0] Pulse_Gen_FF_Out;
reg  [DATA_WIDTH-1:0] Pulse_Gen_Out;
reg  [DATA_WIDTH-1:0] Mux_Out;
wire [DATA_WIDTH-1:0] enable_data;

assign enable_data={16{bus_enable}};

always @(*)
begin
  if(Pulse_Gen_Out)
    Mux_Out = unsync_bus;
else
  begin
    Mux_Out = sync_bus;
  end
    Pulse_Gen_Out = BIT_SYNC_OUT & (~Pulse_Gen_FF_Out);
end

always @(posedge CLK or negedge RST)
begin
  if(!RST)
    begin
  Pulse_Gen_FF_Out <= 'b0;
  enable_pulse <= 'b0;
  sync_bus <= 'b0;
    end
  else
    begin
  Pulse_Gen_FF_Out <= BIT_SYNC_OUT;
  enable_pulse <= Pulse_Gen_Out;
  sync_bus <= Mux_Out;
end
end

//instantiation of Bit Synchronizer
BIT_SYNC #(.NUM_STAGES(NUM_STAGES),.BUS_WIDTH(DATA_WIDTH)) U_BIT_SYNC(
.ASYNC(enable_data),
.CLK(CLK),  
.RST(RST),  
.SYNC(BIT_SYNC_OUT)  
);
endmodule
