module bridge_top(
    hclk,hresetn,hwrite,hreadyin,hwdata,haddr,prdata,htrans,
    pwrite,penable,hreadyout,pselx,paddr,pwdata,hrdata,hresp
);

input hclk,hresetn,hwrite,hreadyin;
input[1:0] htrans;
input[31:0] haddr,hwdata,prdata;
output penable,pwrite,hreadyout;
output[1:0] hresp;
output[2:0] pselx;
output[31:0] paddr,pwdata;
output[31:0] hrdata;

wire valid,hwritereg;
wire [31:0] haddr1,haddr2,hwdata1,hwdata2;
wire [2:0] temp_selx;

ahbslaveinterface AHB_S(
    hclk,hresetn,hwrite,hreadyin,htrans,haddr,hwdata,prdata,
    valid,haddr1,haddr2,hwdata1,hwdata2,hrdata,hwritereg,temp_selx,hresp
);

apbcontroller APB_C(
    hclk,hresetn,valid,hwrite,hwritereg,temp_selx,
    haddr,hwdata,prdata,haddr1,hwdata1,haddr2,hwdata2,
    paddr,pwdata,pwrite,penable,hreadyout,pselx
);

endmodule
