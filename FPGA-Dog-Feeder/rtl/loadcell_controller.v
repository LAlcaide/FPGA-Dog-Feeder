module loadcell_controller(clk, loadcell, cloadcell, wloadcell, wcloadcell, loadcellreg, cloadcellreg, wloadcellreg, wcloadcellreg);
	input clk;
	input [1:0] loadcell, cloadcell, wloadcell, wcloadcell;

	output reg [1:0] loadcellreg, cloadcellreg, wloadcellreg, wcloadcellreg;
	
	reg [31:0] loadcelldel, wloadcelldel, wcloadcelldel, cloadcelldel;
	
	localparam ONE_SECOND = 32'd50000000;
	
	//LOADCELL SAMPLE PERIOD
	localparam LOADCELL_SAMPLE_PERIOD = 5000000;
	
	initial begin
		//COUNTERS
		{loadcelldel, wloadcelldel, wcloadcelldel, cloadcelldel} <= 0;
		//REGISTERS
		{loadcellreg, cloadcellreg, wloadcellreg, wcloadcellreg} <= 0;
		
	end


	always @(posedge clk) begin
	
		//FOOD COMPARTMENT LOADCELL
		cloadcelldel<=cloadcelldel+1;
		if(cloadcelldel>=ONE_SECOND-1) begin
			cloadcellreg<=cloadcell;
			cloadcelldel<=0;
		end
	
		//FOOD LOADCELL
		loadcelldel<=loadcelldel+1;
		if(loadcelldel>=LOADCELL_SAMPLE_PERIOD-1) begin
			loadcellreg<=loadcell;
			loadcelldel<=0;
		end
		
		//WATER LOADCELL
		wloadcelldel<=wloadcelldel+1;
		if(wloadcelldel>=ONE_SECOND-1) begin
			wloadcellreg<=wloadcell;
			wloadcelldel<=0;
		end
		
		//WATER COMPARTMENT LOADCELL
		wcloadcelldel<=wcloadcelldel+1;
		if(wcloadcelldel>=ONE_SECOND-1) begin
			wcloadcellreg<=wcloadcell;
			wcloadcelldel<=0;
		end
	end
	
endmodule
