module Register_File (
  input   wire [15:0]     WrData,
  input   wire [2:0]      Address,
  input   wire            WrEn,
  input   wire            RdEn,
  input   wire            CLK,
  input   wire            RST,
  output  reg  [15:0]     RdData
  );
  
  reg [7:0] mem[0:15];
  integer i;
  
  always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
      for(i=0 ; i<16 ; i=i+1)
      begin
        mem [i] <= 16'b0;
      end
    end
  else
    begin
      if(WrEn)
        mem [Address] <= WrData;
      else if (RdEn)
        RdData <= mem [Address];    
  end
  end
  
endmodule

