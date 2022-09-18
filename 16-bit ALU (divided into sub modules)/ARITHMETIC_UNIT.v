module ARITHMETIC_UNIT #(parameter IN_DATA_WIDTH =16, 
                         parameter OUT_DATA_WIDTH = 16)
  (
  input   wire   [IN_DATA_WIDTH-1:0]          A,
  input   wire   [IN_DATA_WIDTH-1:0]          B,
  input   wire   [1:0]                        ALU_FUN,
  input   wire                                CLK,
  input   wire                                RST,
  input   wire                                Arith_Enable,
  output  reg    [OUT_DATA_WIDTH-1:0]          Arith_OUT,
  output  reg                                 Carry_OUT,
  output  reg                                 Arith_Flag                  
  );
  
  always @ (posedge CLK or negedge RST)
  begin
    Arith_OUT <= 'b0 ;
    if (!RST)
      begin
        Arith_OUT <= 'b0;
        Arith_Flag <= 1'b0;
      end
    else
      begin
    if(Arith_Enable)
      begin
        case(ALU_FUN)
          2'b00:
          begin
          Arith_OUT <= A+B;
          end
          2'b01:
          begin
          Arith_OUT <= A-B;
          end
          2'b10:
          begin
          Arith_OUT <= A*B;
          end
          2'b11:
          begin
          Arith_OUT <= A/B;
          end
        endcase
      end
      else
        begin
          Arith_OUT <= 'b0 ;
        end
        Carry_OUT <= Arith_OUT[IN_DATA_WIDTH];
        Arith_Flag <= Arith_Enable;
      end
      end
  
  
endmodule
