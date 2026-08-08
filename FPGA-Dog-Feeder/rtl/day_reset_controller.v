`default_nettype none
module day_reset_controller(clk, reset, resetFoodLog);
	input wire clk, reset;
	
	output reg resetFoodLog;
	
	reg [31:0] resetdel;
	reg fired;
	
	localparam ONE_SECOND = 32'd50000000;

	initial begin
		{resetdel, resetFoodLog, fired}<=0;
	end

	always @(posedge clk) begin
		//DAY RESET CONTROLLER
		//DAY RESET TRIGGERED BY ESP
		resetFoodLog<=0;
		if(!reset) begin
			resetdel<= 0;
            fired<= 0;
		end
		else if(!fired) begin
			if(resetdel>(ONE_SECOND-1)*3) begin
				resetFoodLog<=1;  
				fired<=1;  
				resetdel<= 0;
			end
			else
				resetdel<=resetdel+1;
		end
	end
endmodule
