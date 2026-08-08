`default_nettype none
module FPGA_Dog_Feeder(
input wire clk, reset,
input wire [1:0] wloadcell, loadcell, wcloadcell, cloadcell, rfid,
output wire [2:0] eaten,
output wire [3:0] dispense, wdispense,
output wire [1:0] rfidout, wloadcellout, loadcellout, wcloadcellout, cloadcellout
);
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
	.clearrfiddone(clearrfiddone),
	.resetFoodLog(resetFoodLog), 
	.rfidreg(rfidout),
	.loadcell(loadcell), 
	.cloadcell(cloadcell), 
	.wloadcell(wloadcell), 
	.wcloadcell(wcloadcell),
	.clearrfidreq(clearrfidreq), 
	.fdismotor(dispense),
	.wdismotor(wdispense),
	.eatenreg(eaten),
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
