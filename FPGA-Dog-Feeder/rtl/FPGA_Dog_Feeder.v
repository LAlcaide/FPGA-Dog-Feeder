module FPGA_Dog_Feeder(clk, reset, dispense, loadcell, wloadcell, wdispense, eaten, rfidout, wloadcellout, loadcellout, wcloadcell, cloadcell, wcloadcellout, cloadcellout, rfid);

//PORTS
input clk, reset;
input [1:0] wloadcell, loadcell, wcloadcell, cloadcell, rfid;
output [2:0] eaten;
output [3:0] dispense, wdispense;
output [1:0] rfidout, wloadcellout, loadcellout, wcloadcellout, cloadcellout;
//REGISTERS

//COUNTERS
reg [31:0] resetdel;
//MOTORS
wire [3:0] fdismotor, wdismotor;
//RFID & LOADCELL
wire [1:0] wloadcellreg, loadcellreg, wcloadcellreg, cloadcellreg;
//DOG EATEN
wire [2:0] eatenreg;
//TRIGGERS
wire resetFoodLog;
wire clearrfidreq;

wire clearrfiddone;
wire [1:0] rfidreg;

localparam ONE_SECOND = 32'd50000000;

rfid_controller RFID_INST(
	.clk(clk),
	.rfid(rfid),        
	.rfidreg(rfidreg),
	.clearrfidreq(clearrfidreq),
	.clearrfiddone(clearrfiddone)
);

feeding_controller FEEDING_INST(
	.clk(clk),
	.fdismotor(fdismotor),
	.rfidreg(rfidreg),
	.eatenreg(eatenreg),
	.loadcell(loadcell), 
	.cloadcell(cloadcell),
	.clearrfiddone(clearrfiddone), 
	.clearrfidreq(clearrfidreq), 
	.resetFoodLog(resetFoodLog), 
	.wloadcell(wloadcell), 
	.wcloadcell(wcloadcell),
	.wdismotor(wdismotor),
	.loadcellreg(loadcellreg), 
	.cloadcellreg(cloadcellreg), 
	.wloadcellreg(wloadcellreg), 
	.wcloadcellreg(wcloadcellreg)
);

day_reset_controller RESET_INST(
	.clk(clk),
	.reset(reset),
	.resetFoodLog(resetFoodLog)
);

assign dispense = fdismotor; //FOOD DISPENSE MOTORS
assign wdispense = wdismotor; // WATER DISPENSE MOTORS
assign eaten = eatenreg; // EATEN
assign rfidout = rfidreg; //RFID
assign wloadcellout = wloadcellreg; //WATER LOAD CELL
assign loadcellout = loadcellreg; //FOOD LOAD CELL
assign wcloadcellout = wcloadcellreg; //WATER COMPARTMENT LOAD CELL
assign cloadcellout = cloadcellreg; //FOOD COMPARTMENT LOAD CELL

endmodule
