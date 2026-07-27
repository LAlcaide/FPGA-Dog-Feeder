module water_controller(clk, wdismotor,wloadcellreg);
	input clk;
	input [1:0] wloadcellreg;
	
	output reg [3:0] wdismotor;
	
	reg [31:0] wdiscntr;
	
	localparam ONE_SECOND = 32'd50000000, water_flow_timeout = ONE_SECOND * 10;
	
	//WATER STATES
	localparam 
	WATER_IDLE = 2'd0, 
	WATER_OPEN_VALVE = 2'd1, 
	WATER_WAIT_FLOW = 2'd2, 
	WATER_CLOSE_VALVE = 2'd3;

	reg [1:0] water_state;
	
	initial begin
		//WATER
		water_state<=WATER_IDLE;
	end
	
	always @(posedge clk) begin
		//WATER CONTROLLER
		//WATER DISPENSE
		case (water_state)
			WATER_IDLE: begin
				wdismotor<=0; 
				if(wloadcellreg==0) begin
					water_state<=WATER_OPEN_VALVE;
					wdiscntr<=0;
				end
			end
			WATER_OPEN_VALVE: begin
				wdismotor<=4'b0101;
				if(wdiscntr>=ONE_SECOND) begin
					water_state<=WATER_WAIT_FLOW;
					wdiscntr<=0;
				end
				else
					wdiscntr<=wdiscntr+1;
			end
			WATER_WAIT_FLOW: begin
				wdismotor<=0;
				if(wloadcellreg==3 || wdiscntr>=water_flow_timeout) begin
					water_state<=WATER_CLOSE_VALVE;
					wdiscntr<=0;
				end
				else
					wdiscntr<=wdiscntr+1;
			end
			WATER_CLOSE_VALVE: begin
				wdismotor<=4'b1010;
				if(wdiscntr>=ONE_SECOND) begin
					wdiscntr<=0;  
					water_state<=WATER_IDLE;
				end
				else
					wdiscntr<=wdiscntr+1;
			end
			default:
				water_state <= WATER_IDLE;
		endcase
	end

endmodule