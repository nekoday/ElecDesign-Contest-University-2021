module LED_display_module
(
	CLK, RSTn, s_w, kw, LED_Out
);
     input CLK;
     input RSTn;	 
	  input s_w;
	  input [31:0] kw;
	   
     output [15:0]LED_Out;
	 
	  reg [15:0]rLED_Out;

	 always @ ( posedge CLK or negedge RSTn )
		if( !RSTn ) 
			rLED_Out <= 'd0;	 	
		else if( s_w == 1 )
			rLED_Out <= kw[15:0];
		else 
			rLED_Out <= rLED_Out;
			
	assign LED_Out = rLED_Out;
	
endmodule