module rx_top
(
    CLK, RSTn, RX_Pin_In, RX_En_Sig, LED_Out,SW_Sin_In,DAC_CLK,DAC_DATA, SW_VPP
);

    input CLK;
	 input RSTn;			
	 input RX_Pin_In;		
	 input RX_En_Sig;
    input SW_Sin_In;	
	 input SW_VPP;
	 
	 output [15:0]LED_Out;
    output DAC_CLK;
	 output [9:0]DAC_DATA;	 

	 wire neg_sig;
	 wire BPS_CLK;
	 wire Count_Sig;
	 wire RX_Done_Sig;	
	 wire [7:0]RX_Data;
    wire [31:0] kw;
    wire s_w;	 
	 wire [31:0] kw_out;
	 wire [9:0] Wave_Data;
	 
	 wire c200;
	 wire c100;

	 
	/**********************************/
`define UART

`ifdef UART	 
	detect_module U1
	(
	   .CLK( CLK ),
		.RSTn( RSTn ),
		.RX_Pin_In( RX_Pin_In ),    // input - from top
		.neg_sig( neg_sig ) 			// output - to U3
	);
	
   /**********************************/

	rx_bps_module U2
	(
	   .CLK( CLK ),
		.RSTn( RSTn ),
		.Count_Sig( Count_Sig ),   // input - from U3
	   .BPS_CLK( BPS_CLK )        // output - to U3
	);	 
	
   /**********************************/
		 
	rx_control_module U3
	(
		.CLK( CLK ),
	   .RSTn( RSTn ),
			  
		.neg_sig( neg_sig ),      // input - from U1
		.RX_En_Sig( RX_En_Sig ),  // input - from top
		.RX_Pin_In( RX_Pin_In ),  // input - from top
		.BPS_CLK( BPS_CLK ),      // input - from U2
			  
	   .Count_Sig( Count_Sig ),    // output - to U2
		.RX_Data( RX_Data ),        // output - to U4
		.RX_Done_Sig( RX_Done_Sig ) // output - to U4		  
	 );
	 
	/************************************/
	KW_crl  U4( 
	.clk(CLK),
	.rst(RSTn),
	.rx_data(RX_Data),
	.kw(kw),
	.kwr_en(RX_Done_Sig),
	.s_w(s_w)
);


	LED_display_module U5
	(
		.CLK( CLK ) ,	
		.RSTn( RSTn ) ,	
		.s_w( s_w ) ,	// input - from U3 
		.kw ( kw ) ,	// input - from U3
		.LED_Out( LED_Out ) 	// output - to top
	);
`endif	  

	 choose_wave_module  U6
(
	  .CLK(CLK), 
	  .RSTn(RSTn), 
	  .SW_Sin_In(SW_Sin_In),  
	  .KW( kw ), 
	  .Wave_Data(Wave_Data)
); 

    dac_module  U7
(
	 .CLK(CLK), 
	 .Wave_Data(Wave_Data), 
	 .DAC_CLK(DAC_CLK), 
	 .DA_Data_Out(DAC_DATA),
	 .SW_VPP(SW_VPP)
);

pll_clk	pll_clk_inst (
	.inclk0 ( CLK ),
	.c0 ( c200 ),
	.c1 ( c100 )
);

//assign mCLK = CLK;
	/************************************/
	 	 
endmodule
