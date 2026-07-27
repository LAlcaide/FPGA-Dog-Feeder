`timescale 1ns/1ps

module water_controller_tb;

    reg clk;
    reg [1:0] wloadcellreg;

    wire [3:0] wdismotor;

    water_controller DUT (
        .clk(clk),
        .wloadcellreg(wloadcellreg),
        .wdismotor(wdismotor)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin

        // Test Case 1: Initial State
        wloadcellreg = 2'b11;

        repeat (2) @(posedge clk);

        // Test Case 2: Empty Water Bowl
        wloadcellreg = 2'b00;

        repeat (15) @(posedge clk);

        // Test Case 3: Bowl Filled Before Timeout
        wloadcellreg = 2'b11;

        repeat (15) @(posedge clk);

        // Test Case 4: Empty Water Bowl Again
        wloadcellreg = 2'b00;

        repeat (120) @(posedge clk);

        // Test Case 5: Refill After Timeout
        wloadcellreg = 2'b11;

        repeat (20) @(posedge clk);

        // End Simulation
        $stop;

    end

endmodule
