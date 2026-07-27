`timescale 1ns/1ps

module day_reset_controller_tb;

    reg clk;
    reg reset;

    wire resetFoodLog;

    day_reset_controller DUT (
        .clk(clk),
        .reset(reset),
        .resetFoodLog(resetFoodLog)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin

        // Test Case 1: Initial State
        reset = 0;

        repeat (5) @(posedge clk);

        // Test Case 2: Reset Held Low
        repeat (10) @(posedge clk);

        // Test Case 3: Reset Asserted (< 3 Seconds)
        reset = 1;

        repeat (20) @(posedge clk);
        
        reset = 0;

        // Test Case 4: Reset Asserted (> 3 Seconds)
        repeat (15) @(posedge clk);
        
        reset = 1;
        
        repeat (30) @(posedge clk);

        // Test Case 5: Reset Released
        reset = 0;

        repeat (10) @(posedge clk);

        // End Simulation
        $stop;

    end

endmodule
