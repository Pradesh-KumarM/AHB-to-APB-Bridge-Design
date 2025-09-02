module ahbslaveinterface_tb();
 reg hclk,hresetn;
 reg hwrite,hreadyin;
 reg [1:0]htrans;
 reg [31:0]haddr,hwdata,prdata;
 wire valid;
 wire [31:0]haddr1,haddr2,hwdata1,hwdata2;
 wire [31:0]hrdata;
 wire hwritereg;
 wire [2:0]temp_selx;
 wire[1:0]hresp;
 ahbslaveinterface DUT(.hclk(hclk),.hresetn(hresetn),.hwrite(hwrite),.hreadyin(hreadyin),.htrans(htrans),.haddr(haddr),.hwdata(hwdata),.prdata(prdata),.valid(valid),.haddr1(haddr1),.haddr2(haddr2),.hwdata1(hwdata1),.hwdata2(hwdata2),.hrdata(hrdata),.hwritereg(hwritereg),.temp_selx(temp_selx),.hresp(hresp));
 initial
 begin
 hclk=0;
 forever #100 hclk=~hclk;
 end
 task r();
 begin
 @(negedge hclk)
 hresetn=1'b0;
 @(negedge hclk)
 hresetn=1'b1;
 end
 endtask
 task in1(input a,b);
 begin
 @(negedge hclk)
 hwrite=a;
 hreadyin=b;
 end
 endtask
 task in2(input [1:0]c, input [31:0]d,e,f);
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
 in2(2'b10,32'h80001000,32'h526,32'h624);
 #100 r;
 in1(1'b0,1'b0);
 in2(2'b11,32'h82000000,32'h664,32'h522);
 #600 $finish;
$monitor("Hclk=%b,Hresetn=%b,Hwrite=%b,Hreadyin=%b,Htrans=%b,Haddr=%h,Hwdata=%h,Prdata=%h,valid=%b,Haddr1=%h,Haddr2=%h,Hwdata1=%h,Hwdata2=%h,Hrdata=%h,Hwritereg=%b,tempselx=%b,Hresp=%b",
hclk,hresetn,hwrite,hreadyin,htrans,haddr,hwdata,prdata,valid,haddr1,haddr2,hwdata1,hwdata2,hrdata,hwritereg,temp_selx,hresp);
 end
endmodule
