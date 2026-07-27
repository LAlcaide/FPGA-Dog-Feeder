`timescale 1ns/1ps

module loadcell_controller_tb;

    reg clk;

    reg [1:0] loadcell;
    reg [1:0] cloadcell;
    reg [1:0] wloadcell;
    reg [1:0] wcloadcell;

    wire [1:0] loadcellreg;
    wire [1:0] cloadcellreg;
    wire [1:0] wloadcellreg;
    wire [1:0] wcloadcellreg;

    loadcell_controller DUT (
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

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin

        // Test Case 1: Initial State
        loadcell   = 2'b00;
        cloadcell  = 2'b00;
        wloadcell  = 2'b00;
        wcloadcell = 2'b00;

        repeat (2) @(posedge clk);

        // Test Case 2: Food Bowl Load Cell
        loadcell = 2'b01;
        repeat (7) @(posedge clk);

        loadcell = 2'b10;
        repeat (7) @(posedge clk);

        loadcell = 2'b11;
        repeat (7) @(posedge clk);

        loadcell = 2'b00;
        repeat (7) @(posedge clk);

        // Test Case 3: Food Compartment Load Cell
        cloadcell = 2'b01;
        repeat (12) @(posedge clk);

        cloadcell = 2'b10;
        repeat (12) @(posedge clk);

        cloadcell = 2'b11;
        repeat (12) @(posedge clk);

        cloadcell = 2'b00;
        repeat (12) @(posedge clk);

        // Test Case 4: Water Bowl Load Cell
        wloadcell = 2'b01;
        repeat (12) @(posedge clk);

        wloadcell = 2'b10;
        repeat (12) @(posedge clk);

        wloadcell = 2'b11;
        repeat (12) @(posedge clk);

        wloadcell = 2'b00;
        repeat (12) @(posedge clk);

        // Test Case 5: Water Compartment Load Cell
        wcloadcell = 2'b01;
        repeat (12) @(posedge clk);

        wcloadcell = 2'b10;
        repeat (12) @(posedge clk);

        wcloadcell = 2'b11;
        repeat (12) @(posedge clk);

        wcloadcell = 2'b00;
        repeat (12) @(posedge clk);

        // End Simulation
        repeat (5) @(posedge clk);

        $stop;

    end

endmodule
