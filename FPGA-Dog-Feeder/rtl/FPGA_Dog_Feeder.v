`default_nettype none
module FPGA_Dog_Feeder(clk, reset, dispense, loadcell, wloadcell, wdispense, eaten, rfidout, wloadcellout, loadcellout, wcloadcell, cloadcell, wcloadcellout, cloadcellout, rfid);
//PORTS
input wire clk, reset;
input wire [1:0] wloadcell, loadcell, wcloadcell, cloadcell, rfid;
//DOG EATEN
output wire [2:0] eaten;
//MOTORS
output wire [3:0] dispense, wdispense;
//LOAD CELLS
output wire [1:0] rfidout, wloadcellout, loadcellout, wcloadcellout, cloadcellout;

//COUNTERS
reg [31:0] resetdel;

//TRIGGERS
wire resetFoodLog;
wire clearrfidreq;

wire clearrfiddone;

localparam ONE_SECOND = 32'd50000000;

rfid_controller RFID_INST(
	.clk(clk),
	.rfid(rfid),        
	.rfidreg(rfidout),
	.clearrfidreq(clearrfidreq),
	.clearrfiddone(clearrfiddone)
);

feeding_controller FEEDING_INST(
	.clk(clk),
	.fdismotor(dispense),
	.rfidreg(rfidout),
	.eatenreg(eaten),
	.loadcell(loadcell), 
	.cloadcell(cloadcell),
	.clearrfiddone(clearrfiddone), 
	.clearrfidreq(clearrfidreq), 
	.resetFoodLog(resetFoodLog), 
	.wloadcell(wloadcell), 
	.wcloadcell(wcloadcell),
	.wdismotor(wdispense),
	.loadcellreg(loadcellout), 
	.cloadcellreg(cloadcellout), 
	.wloadcellreg(wloadcellout), 
	.wcloadcellreg(wcloadcellout)
);

day_reset_controller RESET_INST(
	.clk(clk),
	.reset(reset),
	.resetFoodLog(resetFoodLog)
);

endmodule
