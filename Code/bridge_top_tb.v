module bridge_top_tb();
 reg hclk,hresetn,hwrite,hreadyin;
 reg [1:0]htrans;
 reg [31:0]haddr,hwdata,prdata;
 wire penable,pwrite,hreadyout;
 wire [2:0]pselx;
 wire [31:0]paddr,pwdata;
 wire [31:0]hrdata;
 wire [1:0]hresp;
 bridge_top DUT(.hclk(hclk),.hresetn(hresetn),.hwrite(hwrite),.hreadyin(hreadyin),.hwdata(hwdata),.haddr(haddr),.prdata(prdata),.htrans(htrans),.pwrite(pwrite),.penable(penable),.hreadyout(hreadyout),.pselx(pselx),.paddr(paddr),.pwdata(pwdata),.hrdata(hrdata),.hresp(hresp));

 initial
 begin
 hclk=0;
 forever #10 hclk=~hclk;
 end
 task r();
 begin
 @(posedge hclk)
 hresetn=1'b1;
 @(posedge hclk)
 hresetn=1'b0;
 end
 endtask
 task in1(input a,b);
 begin
 hwrite=a;
 hreadyin=b;
 end
 endtask
 task in2(input [2:0]c, input [31:0]d,e,f);
 begin
 htrans=c;
 haddr=d;
 hwdata=e;
 prdata=f;
 end
 endtask

 initial
 begin
 r;
 in1(1'b1,1'b1);
 in2(3'b010,32'h82000000,32'h557,32'h928);
 #40
 r;
 in1(1'b0,1'b1);
 in2(3'b100,32'h86000000,32'h995,32'h386);
 #90 $finish;

$monitor("Hclk=%b,Hresetn=%b,Hwrite=%b,Hreadyin=%b,Htrans=%b,Haddr=%h,Hwdata=%h,Prdata=%h,Penable=%b,Pwrite=%b,Psel=%b,Paddr=%h,Pwdata=%h,Hrdata=%h,Hresp=%b,Hreadyout=%b",
hclk,hresetn,hwrite,hreadyin,htrans,haddr,hwdata,prdata,penable,pwrite,pselx,paddr,pwdata,hrdata,hresp,hreadyout);
 end
endmodule
