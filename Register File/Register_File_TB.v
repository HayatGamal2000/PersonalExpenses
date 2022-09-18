module Register_File_TB ();
  
  reg [15:0]       WrData_TB;
  reg [2:0]        Address_TB;
  reg              WrEn_TB;
  reg              RdEn_TB;
  reg              CLK_TB;
  reg              RST_TB;
  wire  [15:0]     RdData_TB;
  
initial
begin
  $dumpfile ("Register_File.vdc");
  $dumpvars;
  
//initial values
CLK_TB = 1'b0;
RST_TB = 1'b0;
WrEn_TB =0;
RdEn_TB = 0;
Address_TB=0;

$display ("***Test Case 1***");
#10
RST_TB = 1;
WrEn_TB = 0;
RdEn_TB = 1;
#10
if(RdData_TB == 0)
  $display ("***Reset Case is passed***");
else
  $display ("***Reset Case is Failed***");
  
//write Data operation
#10
WrEn_TB = 1;
RdEn_TB = 0;
Address_TB = 3'b10;
WrData_TB =16'b100101;


//second write operation
#10
WrEn_TB = 1;
RdEn_TB = 0;
Address_TB = 3'b101;
WrData_TB =16'b110010100;

//read Data operations
#10
WrEn_TB = 0;
RdEn_TB = 1;
Address_TB = 3'b10;
$display ("***Test Case 2***");
#10

if(RdData_TB == 16'b100101)
  $display ("***First Read Case is passed***");
else
  $display ("***First Read Case is Failed***");
  
#10
WrEn_TB = 0;
RdEn_TB = 1;
Address_TB = 3'b101;
$display ("***Test Case 3***");

#10
if(RdData_TB == 16'b110010100)
  $display ("***Second Read Case is passed***");
else
  $display ("***Second Read Case is Failed***");

#50
$stop;

end
  
 //clock generation
  always #5 CLK_TB=~CLK_TB;
  
 //instansiation
 Register_File DUT (
.WrData(WrData_TB),
.Address(Address_TB),
.WrEn(WrEn_TB),
.RdEn(RdEn_TB),
.CLK(CLK_TB),
.RST(RST_TB),
.RdData(RdData_TB)
 ); 
  
  
endmodule
