module cooldown_timer(clk, dogstart, cooldown_done);
	input clk, dogstart;
	
	output cooldown_done;
	
	reg [15:0] cooldown;
	reg [31:0] drescntr;
	
	localparam ONE_SECOND        = 32'd50000000;
	localparam DOG_COOLDOWN_TIME = 16'd28800;
	
	initial begin
		//COUNTERS 
		{cooldown, drescntr} =0;
	end
	always @(posedge clk) begin
		//DOG COOLDOWN CONTROLLER
		if(dogstart && cooldown == 0) begin
			cooldown<=DOG_COOLDOWN_TIME;
			drescntr<=0;
		end
		//DOG RESET
		if(cooldown != 0) begin
			drescntr<=drescntr+1;
			if(drescntr>=ONE_SECOND - 1) begin
				cooldown<=cooldown-1; 
				drescntr<=0;
			end
		end
	end
	
	assign cooldown_done = (cooldown == 0);
endmodule
