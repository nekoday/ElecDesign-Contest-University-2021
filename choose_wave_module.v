module choose_wave_module
(
	CLK, RSTn, SW_Sin_In,  KW, Wave_Data
);
	 input CLK;
	 input RSTn;
	 input SW_Sin_In;
	 input [31:0]KW;
	
	 output [9:0]Wave_Data;

	 
	 reg [31:0]Cnt;
	 wire [9:0]addr;
	 
	 
	 
	always @ ( posedge CLK or negedge RSTn )
		begin
			if( !RSTn ) 
				Cnt <= 0;
			else if( Cnt == 32'hffff_ffff )
				Cnt <= 0;	
			else	
				Cnt <= Cnt + KW;
		end
		
	 assign addr = Cnt[31:22];

	 
	 wire [9:0]Sin_Out;		
	 reg [9:0]Wave_Out_r;
	 
	sinrom1	sinrom1_inst (
		.address ( addr ),
		.clock ( CLK ),
		.q ( Sin_Out )
	);
	
	always @ ( posedge CLK or negedge RSTn )
		begin
			if( !RSTn )
				Wave_Out_r <= 0;
			else if( SW_Sin_In == 1 )
				begin
					Wave_Out_r <= Sin_Out;
				end
			else
				Wave_Out_r <= 0;
		end
	
	assign Wave_Data = Wave_Out_r;


	 //assign Wave_Data = Sin_Out;
				
endmodule
