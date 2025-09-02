module ahbslaveinterface(
    hclk,hresetn,hwrite,hreadyin,htrans,haddr,hwdata,prdata,
    valid,haddr1,haddr2,hwdata1,hwdata2,hrdata,hwritereg,temp_selx,hresp
);

input [1:0] htrans;
input [31:0] haddr,hwdata,prdata;
input hclk;
input hreadyin;
input hresetn;
input hwrite;
output reg valid;
output reg [2:0] temp_selx;
output [1:0] hresp;
output reg [31:0] haddr1,haddr2,hwdata1,hwdata2;
output [31:0] hrdata;
output reg hwritereg;

always@(*)
begin
  valid=1'b0;
  if (hreadyin==1 && (htrans==2'b10 || htrans==2'b11) && (haddr>=32'h80000000 && haddr<32'h8c000000))
    valid=1'b1;
  else
    valid=1'b0;
end

always@(*)
begin
  if (haddr>=32'h80000000 && haddr<32'h84000000)
    temp_selx=3'b001;
  else if (haddr>=32'h84000000 && haddr<32'h88000000)
    temp_selx=3'b010;
  else if (haddr>=32'h88000000 && haddr<32'h8c000000)
    temp_selx=3'b011;
  else
    temp_selx=3'b000;
end

always@(posedge hclk)
begin
  if(~hresetn) begin
    haddr1<=32'b0;
    haddr2<=32'b0;
  end else begin
    haddr1<=haddr;
    haddr2<=haddr1;
  end
end

always@(posedge hclk)
begin
  if(~hresetn) begin
    hwdata1<=32'b0;
    hwdata2<=32'b0;
  end else begin
    hwdata1<=hwdata;
    hwdata2<=hwdata1;
  end
end

always@(posedge hclk)
begin
  if(~hresetn)
    hwritereg<=1'b0;
  else
    hwritereg<=hwrite;
end

assign hresp=2'b0;
assign hrdata=prdata;

endmodule
