`timescale 1ns/1ps

module FPGA_Dog_Feeder_tb;

    reg clk;
    reg reset;

    reg [1:0] rfid;
    reg [1:0] loadcell;
    reg [1:0] cloadcell;
    reg [1:0] wloadcell;
    reg [1:0] wcloadcell;

    wire [3:0] dispense;
    wire [3:0] wdispense;
    wire [2:0] eaten;

    wire [1:0] rfidout;
    wire [1:0] loadcellout;
    wire [1:0] cloadcellout;
    wire [1:0] wloadcellout;
    wire [1:0] wcloadcellout;

    // Device Under Test (DUT)
    FPGA_Dog_Feeder DUT(
        .clk(clk),
        .reset(reset),
        .dispense(dispense),
        .loadcell(loadcell),
        .wloadcell(wloadcell),
        .wdispense(wdispense),
        .eaten(eaten),
        .rfidout(rfidout),
        .wloadcellout(wloadcellout),
        .loadcellout(loadcellout),
        .wcloadcell(wcloadcell),
        .cloadcell(cloadcell),
        .wcloadcellout(wcloadcellout),
        .cloadcellout(cloadcellout),
        .rfid(rfid)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin

        // Test Case 1: Initial State
        reset = 0;
        rfid = 2'b00;
        loadcell = 2'b01;
        cloadcell = 2'b11;
        wloadcell = 2'b11;
        wcloadcell = 2'b11;

        repeat (5) @(posedge clk);

        // Test Case 2: Water Bowl Empty
        wloadcell = 2'b00;

        repeat (40) @(posedge clk);

        wloadcell = 2'b11;

        repeat (20) @(posedge clk);

        // Test Case 3: Dog 1 Feeding
        rfid = 2'b01;

        repeat (35) @(posedge clk);

        loadcell = 2'b00;

        repeat (20) @(posedge clk);

        rfid = 2'b00;

        repeat (20) @(posedge clk);

        // Test Case 4: Day Reset
        reset = 1;

        repeat (35) @(posedge clk);

        reset = 0;

        repeat (20) @(posedge clk);

        // Test Case 5: Dog 2 Feeding
        loadcell = 2'b01;
        rfid = 2'b10;

        repeat (35) @(posedge clk);

        loadcell = 2'b00;

        repeat (20) @(posedge clk);

        rfid = 2'b00;

        repeat (30) @(posedge clk);

        // End Simulation
        $stop;

    end

endmodule
