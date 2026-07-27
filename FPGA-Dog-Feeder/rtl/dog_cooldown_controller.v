module dog_cooldown_controller(clk, dogstart, cooldown_done);
	input clk;
	input [2:0] dogstart;
	output [2:0] cooldown_done;
	
	wire [2:0] cooldown_done_internal;
	genvar i;
	
	generate
		for(i=0; i < 3; i=i+1) begin: TIMER_GEN
			cooldown_timer TIMER_INST(
				.clk(clk),
				.dogstart(dogstart[i]),
				.cooldown_done(cooldown_done_internal[i])
			);
		end
	endgenerate
	
	assign cooldown_done = cooldown_done_internal;

endmodule