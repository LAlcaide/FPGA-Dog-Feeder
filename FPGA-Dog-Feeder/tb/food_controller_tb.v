`timescale 1ns/1ps

module food_controller_tb;

    reg clk;
    reg clearrfiddone;
    reg resetFoodLog;

    reg [1:0] rfidreg;
    reg [1:0] loadcellreg;
    reg [1:0] loadcell;

    wire [3:0] fdismotor;
    wire [2:0] eatenreg;
    wire clearrfidreq;

    food_controller DUT (
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

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin

        // Test Case 1: Initial State
        rfidreg = 2'b00;
        loadcellreg = 2'b01;
        loadcell = 2'b01;
        clearrfiddone = 0;
        resetFoodLog = 0;

        repeat (2) @(posedge clk);

        // Test Case 2: Dog 1 Feeding Cycle
        rfidreg = 2'b01;

        repeat (25) @(posedge clk);
        
        //Test Case 3: Food Bowl Full
        loadcell = 2'b11;
        loadcellreg = 2'b11;
        
        repeat (20) @(posedge clk);
        
        // Test Case 4: Dog Eats Food
        loadcell = 2'b01;
        loadcellreg = 2'b11;
        
        @(posedge clk)
        
        loadcellreg = 2'b01;

        repeat (2) @(posedge clk);

        // Test Case 4: RFID Clear Handshake
        clearrfiddone = 1;

        repeat (2) @(posedge clk);

        clearrfiddone = 0;
        rfidreg = 2'b00;

        repeat (10) @(posedge clk);

        // Test Case 5: Feeding Timeout (No Eating)
        rfidreg = 2'b10;

        repeat (5) @(posedge clk);

        loadcell = 2'b11;
        loadcellreg = 2'b11;

        repeat (70) @(posedge clk);

        clearrfiddone = 1;

        repeat (2) @(posedge clk);

        clearrfiddone = 0;
        rfidreg = 2'b00;

        repeat (10) @(posedge clk);

        // Test Case 6: Dog 3 Feeding Cycle
        rfidreg = 2'b11;
        
        repeat (20) @(posedge clk);
        
        loadcell = 2'b00;
        loadcellreg = 2'b11;
        
        @(posedge clk)
        
        loadcellreg = 2'b00;

        repeat (2) @(posedge clk);

        clearrfiddone = 1;

        repeat (2) @(posedge clk);

        clearrfiddone = 0;
        rfidreg = 2'b00;

        repeat (10) @(posedge clk);

        // Test Case 7: Reset Food Log
        resetFoodLog = 1;

        repeat (2) @(posedge clk);

        resetFoodLog = 0;

        repeat (20) @(posedge clk);

        // End Simulation
        $stop;

    end

endmodule
