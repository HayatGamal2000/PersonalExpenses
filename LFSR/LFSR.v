module LFSR (
input  wire [3:0]    Seed,
input  wire          RST,
input  wire          CLK,
output reg          OUT,
output reg          Valid
);


reg  [3:0] LFSR_Counter ;
reg  [3:0] LFSR;
wire [3:0] Taps;
wire En;
integer i;

assign Taps = 4'b1000;

always @ (posedge CLK or negedge RST)
begin
  if(!RST)
    begin
      LFSR <= Seed;
      LFSR_Counter <=4'b0;
      OUT<=0;
      Valid<=0;
    end
else if(En)
  begin
     Valid<= 0;
    if(LFSR_Counter==4'b1100)
      begin
      LFSR_Counter<=4'b1;
      end
    else
      begin
      LFSR_Counter<=LFSR_Counter+1;
      end
 
    for(i=3;i>=0;i=i-1)
    begin
      if(Taps[i])
        LFSR[i]<=LFSR[i-1]^(LFSR[i-2]^LFSR[i-3]);
      else
        LFSR[i]<=LFSR[i+1];
    end
  end
else
  begin
  {OUT,LFSR[3:1]}<=LFSR;
  Valid<= 1;
  LFSR_Counter<=LFSR_Counter+1;
end
end

assign En = (4'b1000 <= LFSR_Counter && LFSR_Counter<=4'b1011 )? 0 : 1;
    
endmodule
