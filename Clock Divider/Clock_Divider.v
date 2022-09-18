module Clock_Divider 
(
input  wire             i_ref_clk,
input  wire             i_rst_n,
input  wire             i_clk_en,
input  wire   [4:0]     i_div_ratio,
output  reg             o_div_clk
);

reg [4:0] Counter;
reg       Divided_Clock;
reg [4:0] high;
reg [4:0] low;

always @ (posedge i_ref_clk or negedge i_rst_n)
begin
  high <= (i_div_ratio>>1)+1;
  low  <=  i_div_ratio>>1;
  Counter <= 5'b1;
  
  if(!i_rst_n)
    begin
      Divided_Clock <= 1'b0;
      Counter <= 5'b1;
    end
    else
      begin
        if (!i_div_ratio[0] && i_clk_en &&  i_div_ratio>5'b1 )
          begin
            if (Counter == (i_div_ratio>>1))
              begin
              Divided_Clock <= ! Divided_Clock;
              Counter <= 5'b1; 
              end
              else
                Counter <= Counter+1;
            end
        else if (i_div_ratio[0] && i_clk_en &&  i_div_ratio>5'b1 )
          begin
            if ((high == Counter && Divided_Clock ) ||  (low == Counter && !Divided_Clock))
              begin
              Divided_Clock <= ! Divided_Clock;
              Counter <= 5'b1; 
              end
              else
                Counter <= Counter+1;
            end
      end
      end
      
      always @(*)
      begin
        if(i_clk_en &&( i_div_ratio>5'b1 || !i_rst_n))
          o_div_clk = Divided_Clock;
          else
            o_div_clk = i_ref_clk;
        end
endmodule
