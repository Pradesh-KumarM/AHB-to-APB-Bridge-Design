module ahb_master(
    input hclk,hresetn,hreadyout,
    input[31:0] hrdata,
    output reg[31:0] haddr,hwdata,
    output reg hwrite,hreadyin,
    output reg[1:0] htrans
);

reg[2:0] hburst;
reg[2:0] hsize;
integer i,j;

task single_write();
begin
  @(posedge hclk) #1;
  begin
    hwrite=1; htrans=2'd2; hsize=0; hburst=0; hreadyin=1; haddr=32'h80000001;
  end
  @(posedge hclk) #1;
  begin
    htrans=2'd0; hwdata=8'h80;
  end
end
endtask

task single_read();
begin
  @(posedge hclk)
  begin
    hwrite=0; htrans=2'd2; hsize=0; hburst=0; hreadyin=1; haddr=32'h80000001;
  end
  @(posedge hclk) #1; begin htrans=2'd0; end
end
endtask

task burst_write();
begin
  @(posedge hclk) #1
  begin
    hwrite=1'b1; htrans=2'd2; hsize=0; hburst=3'd3; hreadyin=1; haddr=32'h80000001;
  end
  @(posedge hclk) #1;
  begin
    haddr=haddr+1'b1; hwdata={$random}%256; htrans=2'd3;
  end
  for(i=0;i<2;i=i+1) begin
    @(posedge hclk); #1 haddr=haddr+1; hwdata={$random}%256; htrans=2'd3;
  end
  @(posedge hclk); #1 begin hwdata={$random}%256; htrans=2'd0; end
end
endtask

task wrap_write();
begin
  @(posedge hclk) #1
  begin
    hwrite=1'b1; htrans=2'b10; hsize=1; hburst=3; hreadyin=1; haddr=32'h80000048;
  end
  @(posedge hclk) #1
  begin
    htrans=2'b11; haddr={haddr[31:3],haddr[2:1]+1'b1,haddr[0]}; hwdata={$random}%256;
  end
  for(j=0;j<2;j=j+1) begin
    @(posedge hclk) #1; htrans=2'b11;
    haddr={haddr[31:3],haddr[2:1]+1'b1,haddr[0]}; hwdata={$random}%256;
  end
  @(posedge hclk) #1 begin htrans=2'b00; hwdata={$random}%256; end
end
endtask

endmodule
