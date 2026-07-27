`timescale 1ns/1ps

module feeding_controller_tb;

    reg clk;
    reg clearrfiddone;
    reg resetFoodLog;

    reg [1:0] rfidreg;
    reg [1:0] loadcell;
    reg [1:0] cloadcell;
    reg [1:0] wloadcell;
    reg [1:0] wcloadcell;

    wire clearrfidreq;
    wire [3:0] fdismotor;
    wire [3:0] wdismotor;
    wire [2:0] eatenreg;

    wire [1:0] loadcellreg;
    wire [1:0] cloadcellreg;
    wire [1:0] wloadcellreg;
    wire [1:0] wcloadcellreg;

    // Device Under Test (DUT)
    feeding_controller DUT (
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

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin

        // Test Case 1: Initial State
        rfidreg        = 2'b00;
        loadcell       = 2'b00;
        cloadcell      = 2'b00;
        wloadcell      = 2'b00;
        wcloadcell     = 2'b00;
        clearrfiddone  = 0;
        resetFoodLog   = 0;

        repeat (12) @(posedge clk);

        // Test Case 2: Verify Load Cell Routing
        loadcell   = 2'b10;
        cloadcell  = 2'b11;
        wloadcell  = 2'b01;
        wcloadcell = 2'b10;

        repeat (15) @(posedge clk);

        // Test Case 3: Trigger Food Dispense
        rfidreg = 2'b01;

        repeat (35) @(posedge clk);

        // Simulate dog eating
        loadcell = 2'b01;

        repeat (15) @(posedge clk);

        // Acknowledge RFID clear request
        clearrfiddone = 1;

        repeat (2) @(posedge clk);

        clearrfiddone = 0;

        repeat (10) @(posedge clk);

        // Test Case 4: Trigger Water Dispense
        wloadcell = 2'b00;

        repeat (15) @(posedge clk);

        // Simulate full water bowl
        wloadcell = 2'b11;

        repeat (120) @(posedge clk);

        // Test Case 5: Reset Food Log
        resetFoodLog = 1;

        repeat (2) @(posedge clk);

        resetFoodLog = 0;

        repeat (20) @(posedge clk);

        // End Simulation
        $stop;

    end

endmodule
