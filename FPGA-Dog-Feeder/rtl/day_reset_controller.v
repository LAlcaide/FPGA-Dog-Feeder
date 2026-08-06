module day_reset_controller(clk, reset, resetFoodLog);
	input clk, reset;
	
	output reg resetFoodLog;
	
	reg [31:0] resetdel;
	
	localparam ONE_SECOND = 32'd50000000;

	initial begin
		{resetdel, resetFoodLog}<=0;
	end

	always @(posedge clk) begin
		//DAY RESET CONTROLLER
		//DAY RESET TRIGGERED BY ESP
		if(@posedge reset) begin
			resetdel<=resetdel+1;
			if(resetdel>(ONE_SECOND-1)*3) begin
				resetFoodLog<=1;  
				resetdel<=0;  
			end
		end
		else begin
			resetFoodLog<=0;
			resetdel<=0;
		end		
	end
endmodule
