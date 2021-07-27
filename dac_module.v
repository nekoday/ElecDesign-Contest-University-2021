module dac_module
(
	CLK, Wave_Data, DAC_CLK, DA_Data_Out, SW_VPP
);

   input CLK;
	input [9:0]Wave_Data;
	input SW_VPP;
   output DAC_CLK; 
   output [9:0]DA_Data_Out;
	
	wire [7:0]a_ver1;
	wire [7:0]a_ver2;
	reg [17:0]amp_dat;
	reg [9:0]r_data_out;
	
	always@(posedge DAC_CLK) begin
		if (SW_VPP) begin
			amp_dat <= Wave_Data * a_ver1;
			r_data_out <= amp_dat[17:8] + 10'b01_1001_0000;
		end
		else begin
			amp_dat <= Wave_Data * a_ver2;
			r_data_out <= amp_dat[17:8] + 10'b01_0000_0000;
		end
	end
	
   assign DAC_CLK = CLK;
	assign a_ver1 = 8'b0101_1010;
	//assign a_ver1 = 8'b0001_0000;
	assign a_ver2 = 8'b1000_0000;
	assign DA_Data_Out = r_data_out;
	
	
endmodule
