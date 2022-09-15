module DigCt(
  input wire IN1,IN2,IN3,IN4,IN5,CLK,
  output reg OUT1,OUT2,OUT3
 );
 
 reg A,B,C,D1,D2,D3;
 
 always @(*)
 begin
  A = ~(IN1 | IN2);
  D1 = ~(A & IN3);  
 end
 
  always @(*)
 begin
  D2 = ~(IN2 & IN3);  
 end
 
  always @(*)
 begin
  B = ~ IN4 ;
  C = IN3 | B ;
  D3 = C | IN5 ;  
 end
 
  always @(posedge CLK)
 begin
  OUT1 <= D1 ;
  OUT2 <= D2 ;
  OUT3 <= D3 ;
 end
endmodule


