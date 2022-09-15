module Up_Dn_Counter (
  input wire [0:4] IN,
  input wire Load,Up,Down,CLK,
  output wire High,Low,
  output reg [0:4] Counter
  );
  
  always @(posedge CLK)
  begin
    if(Load)
      begin
        Counter <= IN ;
      end
    else if(Down && (Counter !== 5'd0))
      begin
        Counter <= Counter - 5'd1;
      end
    else if (Up && (Counter !== 5'd31))
      begin
        Counter <= Counter + 5'd1;
      end
    else
      begin
        Counter <= Counter;
      end
  end
  
  assign High = (Counter ==5'd31);
  assign Low = (Counter == 5'd0);
endmodule

