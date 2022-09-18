module ALU (
  input  wire [15:0] A,B,
  input  wire [3:0]  ALU_FUN,
  input  wire        CLK,
  output reg  [15:0] ALU_OUT,
  output wire       Arith_flag,Logic_flag,CMP_flag,Shift_flag
  );
  
  reg [15:0] D;
  
  always @ (*)
  begin
    case(ALU_FUN)
      4'b0000: begin
        D = (A + B) ;
      end
      4'b0001: begin
        D = A - B ;
      end
      4'b0010: begin
        D = A * B ;
      end
      4'b0011: begin
        D = A / B ;
      end
      4'b0100: begin
        D = A & B ;
      end
      4'b0101: begin
        D = A | B ;
      end
      4'b0110: begin
        D = ~(A & B) ;
      end
      4'b0111: begin
        D = ~(A | B) ;
      end
      4'b1000:  begin
        D = A ^ B ;
      end
      4'b1001: begin
        D = (A ~^ B) ;
      end
      4'b1010: begin
        if (A==B)
          begin
            D = 16'd1;
          end
        else
          begin
            D = 16'd0;
          end
      end
      4'b1011: begin
        if (A>B)
          begin
            D  = 16'd2;
          end
        else
          begin
            D  = 16'd0;
          end
      end
      4'b1100: begin
        if (A<B)
          begin
            D = 16'd3;
          end
        else
          begin
            D = 16'd0;
          end
      end
      4'b1101: begin
        D = A>>1 ;
      end
      4'b1110: begin
        D = A<<1 ;
      end
      default: begin
        D = 16'b0;  
      end
    endcase         
  end
  
  always@(posedge CLK) 
  begin
    ALU_OUT <= D;
  end 
  
  assign Arith_flag = (ALU_FUN == 4'b0000 || ALU_FUN == 4'b0001 || ALU_FUN == 4'b0010 || ALU_FUN == 4'b0011 );
  assign Logic_flag = (ALU_FUN == 4'b0100 || ALU_FUN == 4'b0101 || ALU_FUN == 4'b0110 || ALU_FUN == 4'b0111 || ALU_FUN == 4'b1000 || ALU_FUN == 4'b1001);
  assign CMP_flag = (ALU_FUN == 4'b1010 || ALU_FUN == 4'b1011 || ALU_FUN == 4'b1100);
  assign Shift_flag = (ALU_FUN == 4'b1110 || ALU_FUN == 4'b1101);
endmodule

