module KW_crl
( clk,rst,rx_data,kw,kwr_en,s_w
);



  input clk;
  input rst;
  input [7:0] rx_data;
  input kwr_en;
  output [31:0] kw;
  output s_w;
  reg [31:0] kwr;
  reg [31:0] kwr_out;
  reg [3:0] state;
  reg s_w2;
  
always @ (posedge clk or negedge rst)
  begin
     if(!rst)
	     begin
	     kwr<= 31'd0;
		  state<= 4'd0;
		  kwr_out <= 31'd0;
		  end
	     else
		case(state)
		
		  4'd0:
		       begin
				 state <= state+ 1 ;
				 kwr[31:0] <= 0;
				 kwr_out[31:0] <= kwr_out[31:0];
				 s_w2 <= 0;
				 end
				 
		  4'd1:if(kwr_en)
		       begin
				 state <= state+ 1;
				 kwr[7:0] <= rx_data;
				 end
				 else 
				 state <= state;
				 
		  4'd2:if(kwr_en)
		       begin
				 state <= state +1;
				 kwr[15:8] <= rx_data;
				 end
				 else 
				 state <= state;
				 
		  4'd3:if(kwr_en)
		       begin
				 state <= state +1;
				 kwr[23:16] <= rx_data;
				 end
				 else 
				 state <= state;
				 
		  4'd4:if(kwr_en)
		       begin
				 state <= state +1;
				 kwr[31:24] <= rx_data;
				 end
				 else 
				 state <= state;
				 
		  4'd5:
		       begin
				 state <= 0;
				 kwr_out[31:0] <= kwr[31:0];
				 s_w2 <= 1;
             end
				 
		 endcase
		end
		 
assign kw = kwr_out;
assign s_w = s_w2;

endmodule