module top_tb();

reg hclk,hresetn;
wire[31:0] haddr,hwdata,hrdata,paddr,pwdata,pwdata_out,paddr_out,prdata;
wire[1:0] hresp,htrans;
wire[2:0] temp_selx,pselx,psel_out;
wire hreadyout,hwrite,hreadyin,hwrite_reg1,hwrite_reg2,penable,pwrite_out,penable_out;

ahb_master ahb(hclk,hresetn,hreadyout,hrdata,haddr,hwdata,hwrite,hreadyin,htrans);
apb_interface apb(pwrite,penable,pselx,paddr,pwdata,pwrite_out,penable_out,psel_out,paddr_out,pwdata_out,prdata);
bridge_top bridge(hclk,hresetn,hwrite,hreadyin,hwdata,haddr,prdata,htrans,pwrite,penable,hreadyout,pselx,paddr,pwdata,hrdata,hresp);

initial
begin
hclk=1'b0;
forever #10 hclk=~hclk;
end

task reset();
begin
@(negedge hclk);
hresetn=1'b0;
@(negedge hclk);
hresetn=1'b1;
end
endtask

initial
begin
reset;
ahb.single_write();
#10
ahb.burst_write();
#20
ahb.single_read();
#30
ahb.wrap_write();
end
endmodule
