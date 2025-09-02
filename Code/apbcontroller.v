module apbcontroller(
    hclk,hresetn,valid,hwrite,hwritereg,tempsel,
    haddr,hwdata,prdata,haddr1,hwdata1,haddr2,hwdata2,
    paddr,pwdata,pwrite,penable,hreadyout,psel
);

input hclk,hresetn,valid,hwrite,hwritereg;
input[2:0] tempsel;
input[31:0] haddr,hwdata,prdata,haddr1,hwdata1,haddr2,hwdata2;
output reg[31:0] paddr,pwdata;
output reg pwrite,penable,hreadyout;
output reg[2:0] psel;

parameter st_idle=3'b000,st_wwait=3'b001,st_writep=3'b010,st_wenablep=3'b011,
          st_write=3'b100,st_wenable=3'b101,st_read=3'b110,st_renable=3'b111;

reg[2:0] ps,ns;
reg[2:0] psel_temp;
reg penable_temp,hreadyout_temp,pwrite_temp;
reg[31:0] pwdata_temp,paddr_temp;

always@(posedge hclk)
  if(~hresetn) ps<=st_idle; else ps<=ns;

always@(ps,valid,hwrite,hwritereg)
begin
  ns=st_idle;
  case(ps)
    st_idle: begin   
      if(valid && hwrite) ns<=st_wwait;
      else if(valid && ~hwrite) ns<=st_read;
      else ns<=st_idle;
    end
    st_wwait: ns <= valid ? st_writep : st_write;
    st_writep: ns<=st_wenablep;
    st_wenablep: begin 
      if(valid && hwritereg) ns<=st_writep;
      else if(~valid && hwritereg) ns<=st_write;
      else if(~hwritereg) ns<=st_read;
    end
    st_write: ns <= valid ? st_wenablep : st_wenable;
    st_wenable: ns <= valid ? (hwrite?st_wwait:st_read) : st_idle;
    st_read: ns<=st_renable;
    st_renable: ns <= valid ? (hwrite?st_wwait:st_read) : st_idle;
    default: ns<=st_idle;
  endcase
end

always @(*)
begin
  case(ps)
    st_idle: if(valid && hwrite) begin
      psel_temp=3'b000; penable_temp=1'b0; hreadyout_temp=1'b1;
    end else if (valid && !hwrite) begin
      paddr_temp=haddr; pwrite_temp=hwrite; psel_temp=tempsel;
      penable_temp=1'b0; hreadyout_temp=1'b0;
    end else begin
      psel_temp=1'b0; penable_temp=1'b0; hreadyout_temp=1'b1;
    end
    st_wwait: begin
      paddr_temp=haddr; pwrite_temp=1; psel_temp=tempsel;
      pwdata_temp=hwdata; penable_temp=0; hreadyout_temp=0;
    end
    st_read, st_write, st_writep: begin
      penable_temp=1; hreadyout_temp=1;
    end
    st_renable: begin
      if (valid && ~hwrite) begin
        paddr_temp=haddr; pwrite_temp=hwrite; psel_temp=tempsel;
        penable_temp=0; hreadyout_temp=0;
      end else begin
        psel_temp=0; penable_temp=0; hreadyout_temp=1;
      end
    end
    st_wenablep: begin
      paddr_temp=haddr; pwrite_temp=hwrite; psel_temp=tempsel;
      pwdata_temp=hwdata; penable_temp=0; hreadyout_temp=0;
    end
    st_wenable: begin
      psel_temp=0; penable_temp=0; hreadyout_temp=0;
    end 
  endcase
end

always @(posedge hclk)
begin
  if (!hresetn) begin
    paddr<=32'b0; pwdata<=32'b0; pwrite<=1'b0; penable<=1'b0;
    psel<=3'b000; hreadyout<=1'b0;
  end else begin
    paddr<=paddr_temp; pwdata<=pwdata_temp; pwrite<=pwrite_temp;
    penable<=penable_temp; psel<=psel_temp; hreadyout<=hreadyout_temp;
  end
end 

endmodule
