`default_nettype none
module rfid_controller (
input wire clk, clearrfidreq, 
input wire [1:0] rfid, 
output reg [1:0] rfidreg, 
output reg clearrfiddone);
	initial begin
		//RFID
		rfidreg<=0;
		//REQUESTS
		clearrfiddone<=0;
	end
	
	always @(posedge clk) begin
	//RFID Controller
		if(clearrfidreq) begin
			rfidreg<=0;
			clearrfiddone<=1;
		end
		else begin
			clearrfiddone<=0;
			if(rfid!=0 && rfidreg==0)
				rfidreg<=rfid;
		end
	end
endmodule
