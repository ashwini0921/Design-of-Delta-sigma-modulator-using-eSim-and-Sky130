module ashwini_delay1bit(Clk,in,out);
input Clk;
input [3 : 0] in;
output [1 : 0] out;
reg [1 : 0] out = 0; 
reg [1 : 0] out_old=0;
 always @(posedge(Clk) or negedge(Clk))
 begin
    out<=out_old;
        if(in >=8 )
          out_old<=3;
       else if(in >=4)
          out_old<=2;
       else if(in >=2)
          out_old<=1;
       else
          out_old<=0;
 end       
 
endmodule