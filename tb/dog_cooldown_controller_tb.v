`timescale 1ns/1ps

module dog_cooldown_controller_tb;

    reg clk;
    reg [2:0] dogstart;

    wire [2:0] cooldown_done;

    dog_cooldown_controller DUT (
        .clk(clk),
        .dogstart(dogstart),
        .cooldown_done(cooldown_done)
    );
    
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    initial begin

        //------------------------------------------------
        // Test Case 1 : Initial State
        //------------------------------------------------
        dogstart = 3'b000;

        repeat (2) @(posedge clk);

        //------------------------------------------------
        // Test Case 2 : Start Dog 0 Cooldown
        //------------------------------------------------
        dogstart = 3'b001;

        @(posedge clk);
        dogstart = 3'b000;

        repeat (15) @(posedge clk);

        //------------------------------------------------
        // Test Case 3 : Start Dog 1 Cooldown
        //------------------------------------------------
        dogstart = 3'b010;

        @(posedge clk);
        dogstart = 3'b000;

        repeat (15) @(posedge clk);

        //------------------------------------------------
        // Test Case 4 : Start Dog 2 Cooldown
        //------------------------------------------------
        dogstart = 3'b100;

        @(posedge clk);
        dogstart = 3'b000;

        repeat (15) @(posedge clk);

        //------------------------------------------------
        // Test Case 5 : Start All Dogs Simultaneously
        //------------------------------------------------
        dogstart = 3'b111;

        @(posedge clk);
        dogstart = 3'b000;

        repeat (40) @(posedge clk);

        //------------------------------------------------
        // End Simulation
        //------------------------------------------------
        $stop;

    end

endmodule
