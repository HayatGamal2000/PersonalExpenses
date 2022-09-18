module Clock_Divider_TB ();
  
reg             i_ref_clk_TB;
reg             i_rst_n_TB;
reg             i_clk_en_TB;
reg    [4:0]    i_div_ratio_TB;
wire            o_div_clk_TB;
  
 initial
 begin
   $dumpfile("ClK_Div.vcd");
   $dumpvars ;
   //initial values
  i_ref_clk_TB = 0 ;
  i_rst_n_TB = 0;
  i_clk_en_TB = 1;
  i_div_ratio_TB = 5'd1 ;
  
  $display ("*** Test Case 1 ***");
  #50
  
  
  $display ("*** Test Case 2 ***");
  i_rst_n_TB =1'b1;
  #50
  
  
  $display ("*** Test Case 3 ***");
  i_div_ratio_TB =5'd2 ;
  #100
  
  
  $display ("*** Test Case 4 ***");
  i_div_ratio_TB =5'd3 ;
  #200
  
  
  $display ("*** Test Case 5 ***");
  i_div_ratio_TB =5'd4 ;
  #200
  
    $display ("*** Test Case 6 ***");
  i_div_ratio_TB =5'd5 ;
  #200
  
      $display ("*** Test Case 7 ***");
  i_div_ratio_TB =5'd6;
  
      $display ("*** Test Case 8 ***");
  i_div_ratio_TB =5'd7 ;
  #200 
  
   $display ("*** Test Case 9 ***");
  i_clk_en_TB =0 ;
  #50
  
     $display ("*** Test Case 10 ***");
  i_clk_en_TB =1 ;
  i_div_ratio_TB=1;
  #50
  

  
  
#100
$finish;
 end 
  
//Generaing Block
always #6 i_ref_clk_TB = ~i_ref_clk_TB ;

//instansiation of module
Clock_Divider DUT (
.i_ref_clk(i_ref_clk_TB),
.i_rst_n(i_rst_n_TB),
.i_clk_en(i_clk_en_TB),
.i_div_ratio(i_div_ratio_TB),
.o_div_clk(o_div_clk_TB)
);
  
endmodule
