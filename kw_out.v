module kw_out
( rst,clk,kw,kw_out,s_w
);

  input rst;
  input clk;
  input [31:0] kw;
  input s_w;
  output [31:0] kw_out;
  
  reg [31:0] rkw_out; 
always @ (posedge clk or negedge rst)
       if( !rst ) 
			rkw_out <= 'd0;	 	
		else if( s_w == 1 )
			rkw_out <= kw;
		else 
			rkw_out <= rkw_out;
			
	assign kw_out = rkw_out;
	
endmodule