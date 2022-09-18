module Decoder_Unit (
  input      wire   [1:0]      ALU_FUN,
  output     reg               Arith_Enable,
  output     reg               Logic_Enable,
  output     reg               CMP_Enable,
  output     reg               Shift_Enable                
  );
  
  always @ (*)
  begin
    Arith_Enable = 0;
    Logic_Enable = 0;
    CMP_Enable = 0;
    Shift_Enable = 0;
    
    case(ALU_FUN)
      2'b00:
      begin
        Arith_Enable = 1;
        Logic_Enable = 0;
        CMP_Enable = 0;
        Shift_Enable = 0;
      end
      2'b01:
      begin
        Arith_Enable = 0;
        Logic_Enable = 1;
        CMP_Enable = 0;
        Shift_Enable = 0;
      end
      2'b10:
      begin
        Arith_Enable = 0;
        Logic_Enable = 0;
        CMP_Enable = 1;
        Shift_Enable = 0;
      end
      2'b11:
      begin
        Arith_Enable = 0;
        Logic_Enable = 0;
        CMP_Enable = 0;
        Shift_Enable = 1;
      end
      default
      begin
        Arith_Enable = 0;
        Logic_Enable = 0;
        CMP_Enable = 0;
        Shift_Enable = 0;
      end
    endcase
  end
endmodule
