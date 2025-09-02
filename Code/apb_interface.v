module apb_interface(
    pwrite,penable,pselx,paddr,pwdata,
    pwrite_out,penable_out,psel_out,paddr_out,pwdata_out,prdata
);

input penable,pwrite;
input [2:0]pselx;
input [31:0]paddr,pwdata;
output penable_out,pwrite_out;
output [2:0]psel_out;
output [31:0]paddr_out,pwdata_out;
output reg[31:0]prdata;

assign penable_out=penable;
assign pwrite_out=pwrite;
assign psel_out=pselx;
assign paddr_out=paddr;
assign pwdata_out=pwdata;

always @(*)
begin
  if(penable && ~pwrite)
    prdata={$random}%256;
  else
    prdata=0;
end

endmodule
