module CMP_UNIT #(parameter IN_DATA_WIDTH =16, 
                         parameter OUT_DATA_WIDTH = 16)
  (
  input   wire   [IN_DATA_WIDTH-1:0]          A,
  input   wire   [IN_DATA_WIDTH-1:0]          B,
  input   wire   [1:0]                        ALU_FUN,
  input   wire                                CLK,
  input   wire                                RST,
  input   wire                                CMP_Enable,
  output  reg    [OUT_DATA_WIDTH-1:0]         CMP_OUT,
  output  reg                                 CMP_Flag                  
  );

always @ (posedge CLK or negedge RST)
  begin
    CMP_OUT <= 'b0;
    if (!RST)
      begin
        CMP_OUT <= 'b0;
      CMP_Flag <= 1'b0; 
      end
    else
      begin
    if(CMP_Enable)
      begin
        case(ALU_FUN)
          2'b00:
          begin
          CMP_OUT <= 'b0;
          end
          2'b01:
          begin
          if (A == B) 
             CMP_OUT <= 'b1;
          else
             CMP_OUT <= 'b0;
          end
          2'b10:
          begin
          if (A > B) 
             CMP_OUT <= 'b10;
          else
             CMP_OUT <= 'b0;
          end
          2'b11:
          begin
          if (A < B) 
             CMP_OUT <= 'b11;
          else
             CMP_OUT <= 'b0;
          end
        endcase
      end
      else
        begin
          CMP_OUT <= 'b0 ;
        end
          CMP_Flag <= CMP_Enable;
      end
    end
   
endmodule

