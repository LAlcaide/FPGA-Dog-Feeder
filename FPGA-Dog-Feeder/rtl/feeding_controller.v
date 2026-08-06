`default_nettype none
module feeding_controller(clk, fdismotor, rfidreg, eatenreg, loadcell, cloadcell, clearrfiddone, clearrfidreq, resetFoodLog, wloadcell, wcloadcell, wdismotor, loadcellreg, cloadcellreg, wloadcellreg, wcloadcellreg);
	input clk, clearrfiddone, resetFoodLog;
	input [1:0] rfidreg, loadcell, cloadcell, wloadcell, wcloadcell;
	
	output clearrfidreq;
	output [3:0] fdismotor, wdismotor;
	output [2:0] eatenreg;
	output [1:0] loadcellreg, cloadcellreg, wloadcellreg, wcloadcellreg;
	
	reg [31:0] loadcelldel, wloadcelldel, wcloadcelldel, cloadcelldel;

	food_controller FOOD_INST(
		.clk(clk), 
		.fdismotor(fdismotor), 
		.rfidreg(rfidreg), 
		.eatenreg(eatenreg), 
		.loadcellreg(loadcellreg),  
		.loadcell(loadcell),  
		.clearrfiddone(clearrfiddone), 
		.clearrfidreq(clearrfidreq),
		.resetFoodLog(resetFoodLog)
	);
	
	water_controller WATER_INST(
		.clk(clk),
		.wdismotor(wdismotor),
		.wloadcellreg(wloadcellreg)
	);
	
	loadcell_controller LOADCELL_INST(
		.clk(clk), 
		.loadcell(loadcell), 
		.cloadcell(cloadcell), 
		.wloadcell(wloadcell), 
		.wcloadcell(wcloadcell), 
		.loadcellreg(loadcellreg), 
		.cloadcellreg(cloadcellreg), 
		.wloadcellreg(wloadcellreg), 
		.wcloadcellreg(wcloadcellreg)
	);
	
endmodule
