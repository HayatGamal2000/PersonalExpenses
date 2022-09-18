module LOGIC_UNIT #(parameter IN_DATA_WIDTH =16, 
                         parameter OUT_DATA_WIDTH = 16)
  (
  input   wire   [IN_DATA_WIDTH-1:0]          A,
  input   wire   [IN_DATA_WIDTH-1:0]          B,
  input   wire   [1:0]                        ALU_FUN,
  input   wire                                CLK,
  input   wire                                RST,
  input   wire                                Logic_Enable,
  output  reg    [OUT_DATA_WIDTH-1:0]         Logic_OUT,
  output  reg                                 Logic_Flag                  
  );

always @ (posedge CLK or negedge RST)
  begin
    Logic_OUT <= 'b0;
    if (!RST)
      begin
        Logic_OUT <= 'b0;
        Logic_Flag <= 1'b0;
      end
    else
      begin
    if(Logic_Enable)
      begin
        case(ALU_FUN)
          2'b00:
          begin
          Logic_OUT <= A&B;
          end
          2'b01:
          begin
          Logic_OUT <= A|B;
          end
          2'b10:
          begin
          Logic_OUT <= ~(A&B);
          end
          2'b11:
          begin
          Logic_OUT <= ~(A|B);
          end
        endcase
      end
      else
        begin
          Logic_OUT <= 'b0 ;
        end
          Logic_Flag <= Logic_Enable;
      end
      end
   
endmodule
