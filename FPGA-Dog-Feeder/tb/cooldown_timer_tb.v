`timescale 1ns/1ps

module cooldown_timer_tb;

    reg clk;
    reg dogstart;
    
    wire cooldown_done;

    cooldown_timer DUT (
        .clk(clk),
        .dogstart(dogstart),
        .cooldown_done(cooldown_done)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        dogstart = 0;

        // Wait 100 ns
        #110;

        // Start cooldown
        dogstart = 1;
        #20;
        dogstart = 0;

        // Wait long enough to observe behavior
        #1500;

        // Finish simulation
        $stop;
    end

endmodule
