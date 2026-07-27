module feeding_controller(clk, fdismotor, rfidreg, eatenreg, loadcell, cloadcell, clearrfiddone, clearrfidreq, resetFoodLog, wloadcell, wcloadcell, wdismotor, loadcellreg, cloadcellreg, wloadcellreg, wcloadcellreg);
	input clk, clearrfiddone, resetFoodLog;
	input [1:0] rfidreg, loadcell, cloadcell, wloadcell, wcloadcell;
	
	output clearrfidreq;
	output [3:0] fdismotor, wdismotor;
	output [2:0] eatenreg;
	output [1:0] loadcellreg, cloadcellreg, wloadcellreg, wcloadcellreg;
	
	reg [31:0] loadcelldel, wloadcelldel, wcloadcelldel, cloadcelldel;
	wire [3:0] fdismotor_internal, wdismotor_internal;
	wire [2:0] eatenreg_internal;
	wire [1:0] loadcellreg_internal, cloadcellreg_internal, wloadcellreg_internal, wcloadcellreg_internal;
	wire clearrfidreq_internal;

	food_controller FOOD_INST(
		.clk(clk), 
		.fdismotor(fdismotor_internal), 
		.rfidreg(rfidreg), 
		.eatenreg(eatenreg_internal), 
		.loadcellreg(loadcellreg),  
		.loadcell(loadcell),  
		.clearrfiddone(clearrfiddone), 
		.clearrfidreq(clearrfidreq_internal),
		.resetFoodLog(resetFoodLog)
	);
	
	water_controller WATER_INST(
		.clk(clk),
		.wdismotor(wdismotor_internal),
		.wloadcellreg(wloadcellreg)
	);
	
	loadcell_controller LOADCELL_INST(
		.clk(clk), 
		.loadcell(loadcell), 
		.cloadcell(cloadcell), 
		.wloadcell(wloadcell), 
		.wcloadcell(wcloadcell), 
		.loadcellreg(loadcellreg_internal), 
		.cloadcellreg(cloadcellreg_internal), 
		.wloadcellreg(wloadcellreg_internal), 
		.wcloadcellreg(wcloadcellreg_internal)
	);
	
	assign fdismotor = fdismotor_internal;
	assign wdismotor = wdismotor_internal;
	assign eatenreg = eatenreg_internal;
	assign clearrfidreq = clearrfidreq_internal;
	assign loadcellreg = loadcellreg_internal;
	assign cloadcellreg = cloadcellreg_internal;
	assign wloadcellreg = wloadcellreg_internal;
	assign wcloadcellreg = wcloadcellreg_internal;
	
endmodule