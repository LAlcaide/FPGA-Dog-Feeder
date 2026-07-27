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
    
    initial begin
        // Initialize inputs
        dogstart = 0;
        
        repeat (5) @(posedge clk);

        // Start cooldown
        dogstart = 1;
        @(posedge clk);
        dogstart = 0;

        // Wait long enough to observe behavior
        repeat (80) @(posedge clk);

        // Finish simulation
        $stop;
    end

endmodule
