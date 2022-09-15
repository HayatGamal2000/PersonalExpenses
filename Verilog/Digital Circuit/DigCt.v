module DigCt 
(IN1,IN2,IN3,IN4,IN5,CLK,OUT1,OUT2,OUT3);

input IN1;
input IN2;
input IN3;
input IN4;
input IN5;
input CLK;
output OUT1;
output OUT2;
output OUT3;

reg OUT1,OUT2,OUT3;
reg a,b,c;

always @(IN1 or IN2 or IN3)
    begin
      a= ~(IN3 & (~(IN1 | IN2)));
    end
always @(posedge CLK)
    begin
      OUT1 <= a;
    end
always @(IN2 or IN3)
    begin
      b= ~(IN3 & IN2 );
    end
always @(posedge CLK)
    begin
      OUT2 <= b;
    end
always @(IN3 or IN4 or IN5)
    begin
      c= IN5 | (IN3|(~IN4));
    end
always @(posedge CLK)
    begin
      OUT1 <= a;
    end
endmodule
