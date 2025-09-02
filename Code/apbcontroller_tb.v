module apbcontroller_tb();
 reg hclk,hresetn,hwrite,valid,hwritereg;
 reg [2:0]tempsel;
 reg [31:0]haddr,hwdata,prdata,haddr1,haddr2,hwdata1,hwdata2;
 reg penable_temp,pwrite_temp,hreadyout_temp;
 reg [2:0]psel_temp;
 reg [31:0]paddr_temp,pwdata_temp;
 wire penable,pwrite,hreadyout;
 wire [2:0]psel;
 wire [31:0]paddr,pwdata;
 apbcontroller DUT(.hclk(hclk),.hresetn(hresetn),.valid(valid),.hwrite(hwrite),.hwritereg(hwritereg),.tempsel(tempsel),.haddr(haddr),.hwdata(hwdata),.prdata(prdata),.haddr1(haddr1),.hwdata1(hwdata1),.haddr2(haddr2),.hwdata2(hwdata2),.paddr(paddr),.pwdata(pwdata),.pwrite(pwrite),.penable(penable),.hreadyout(hreadyout),.psel(psel));
 initial
 begin
 hclk=0;
 forever #10 hclk=~hclk;
 end
 task r();
 begin
 @(negedge hclk)
 hresetn=1'b0;
 @(negedge hclk)
 hresetn=1'b1;
 end
 endtask
 task in1(input a,b,c,p,q,r);
 begin
 @(negedge hclk)
 hwrite=a;
 valid=b;
 hwritereg=c;
 penable_temp=p;
 pwrite_temp=q;
 hreadyout_temp=r;
 end
 endtask
 task in2(input [2:0]d,x, input [31:0]e,f,g,h,i,j,k,y,z);
 begin
 tempsel=d;
 haddr=e;
 hwdata=f;
 prdata=g;
 haddr1=h;
 haddr2=i;
 hwdata1=j;
 hwdata2=k;
 psel_temp=x;
 paddr_temp=y;
 pwdata_temp=z;
 end
 endtask
 initial
 begin
 r;
 in1(1'b1,1'b0,1'b1,1'b0,1'b1,1'b1);
 in2(3'b001,3'b100,32'h82000000,32'h554,32'h624,32'h552,32'h736,32'h225,32'h489,32'h378,32'h492);
 #30
 r;
 in1(1'b1,1'b1,1'b1,1'b0,1'b1,1'b1);
 in2(3'b100,3'b010,32'h86000000,32'h267,32'h865,32'h933,32'h658,32'h448,32'h526,32'h446,32'h786);
 #50 $finish;

$monitor("Hclk=%b,Hresetn=%b,Hwrite=%b,valid=%b,Hwritereg=%b,tempselx=%b,Haddr=%h,Hwdata=%h,Prdata=%h,Haddr1=%h,Haddr2=%h,Hwdata1=%h,Hwdata2=%h,Penable_temp=%b,Pwrite_temp=%b,Hreadyout_temp=%b,Psel_temp=%b,Paddr_temp=%h,Pwdata_temp=%h,Penable=%b,Pwrite=%b,Hreadyout=%b,Psel=%b,Paddr=%h,Pwdata=%h",
hclk,hresetn,hwrite,valid,hwritereg,tempsel,haddr,hwdata,prdata,haddr1,haddr2,hwdata1,hwdata2,penable_temp,pwrite_temp,hreadyout_temp,psel_temp,paddr_temp,
pwdata_temp,penable,pwrite,hreadyout,psel,paddr,pwdata);
 end
endmodule
