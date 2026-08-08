`default_nettype none
module food_controller(
input wire clk, clearrfiddone, resetFoodLog,
input wire [1:0] rfidreg, loadcellreg, loadcell,
output reg clearrfidreq,
output reg [3:0] fdismotor,
output reg [2:0] eatenreg
);
	reg [2:0] dogstart;
	reg [31:0] fdiscntr;
	
	wire [2:0] cooldown_done;
	reg [2:0] cooldown_done_prev;
	
	integer i = 0;
	
	//FOOD STATES
	localparam
	FOOD_IDLE          = 3'd0,
	FOOD_OPEN_GATE     = 3'd1,
	FOOD_SETTLE        = 3'd2,
	FOOD_CLOSE_GATE    = 3'd3,
	FOOD_WAIT_EAT      = 3'd4,
	FOOD_CLEAR_RFID    = 3'd5;
	
	localparam ONE_SECOND = 32'd50000000;
	
	reg [2:0] food_state;
	
	//FOOD TIMEOUT
	localparam food_settle_timeout = ONE_SECOND*8,
	food_wait_timeout = ONE_SECOND*5;
	
	dog_cooldown_controller COOLDOWN_INST(
		.clk(clk),
		.dogstart(dogstart), 
		.cooldown_done(cooldown_done)
	);

	initial begin
		//COUNTERS 
		{fdiscntr}<=0;
		//MOTORS
		{fdismotor}<=0;
		//DOG EATEN
		{eatenreg, dogstart}<=0;
		//REQUESTS
		clearrfidreq<=0;
		//FOOD
		food_state<=FOOD_IDLE;
	end
	
	always @(posedge clk) begin
		//FOOD Controller
		dogstart<=0;
	
		case(food_state)
			FOOD_IDLE: begin
				fdismotor<=0;
				if(((rfidreg==2'b01 && eatenreg[0]==0)|| (rfidreg==2'b10 && eatenreg[1]==0) || (rfidreg==2'b11 && eatenreg[2]==0))&& loadcellreg!=3) begin
					fdiscntr<=0;
					food_state<=FOOD_OPEN_GATE;	
				end
				else if(((rfidreg==2'b01 && eatenreg[0]==0)|| (rfidreg==2'b10 && eatenreg[1]==0) || (rfidreg==2'b11 && eatenreg[2]==0))&& loadcellreg==3) begin
				  fdiscntr<=0;
					food_state<=FOOD_WAIT_EAT;	
				end
			end
			FOOD_OPEN_GATE: begin
				fdismotor<=4'b1001;
				if(fdiscntr>=ONE_SECOND-1) begin
					food_state<=FOOD_SETTLE;
					fdiscntr<=0;
				end
				else
					fdiscntr<=fdiscntr+1;
			end
			FOOD_SETTLE: begin
				fdismotor<=0;
				if(loadcellreg == 3 || fdiscntr>=food_settle_timeout) begin
					food_state<=FOOD_CLOSE_GATE;
					fdiscntr<=0;
				end
				else
					fdiscntr<=fdiscntr+1;
			end
			FOOD_CLOSE_GATE: begin
				fdismotor<=4'b0110;
				if(fdiscntr>=ONE_SECOND-1) begin
					food_state<=FOOD_WAIT_EAT;
					fdiscntr<=0;
				end
				else
					fdiscntr<=fdiscntr+1;
			end
			FOOD_WAIT_EAT: begin
				fdismotor<=0;
				if(fdiscntr>=food_wait_timeout && loadcellreg == loadcell) begin
					food_state<=FOOD_CLEAR_RFID;
					fdiscntr<=0;
				end
				else if(loadcellreg>loadcell) begin
					case(rfidreg)
						2'b01: begin
							dogstart<=3'b001;
							eatenreg[0]<=1;
						end	
						2'b10: begin
							dogstart<=3'b010;
							eatenreg[1]<=1;
						end
						2'b11: begin
							dogstart<=3'b100;
							eatenreg[2]<=1;
						end
					endcase
					food_state<=FOOD_CLEAR_RFID;
					fdiscntr<=0;
				end
				else
					fdiscntr<=fdiscntr+1;
			end
			FOOD_CLEAR_RFID: begin
				fdismotor<=0;
				if(clearrfiddone) begin
					clearrfidreq<=0;
					food_state<=FOOD_IDLE;
				end
				else
					clearrfidreq<=1;
			end
			default:
				food_state<=FOOD_IDLE;
		endcase
		
		cooldown_done_prev <= cooldown_done;

		for(i=0; i<3; i=i+1) begin
			if(!cooldown_done_prev[i] && cooldown_done[i])
				eatenreg[i]<=0;
		end
		
		if(resetFoodLog == 1)
		  eatenreg <= 0;
		
	end
endmodule
