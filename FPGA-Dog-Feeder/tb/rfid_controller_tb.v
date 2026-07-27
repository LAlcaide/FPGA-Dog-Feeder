`timescale 1ns/1ps

module rfid_controller_tb;

    reg clk;
    reg [1:0] rfid;
    reg clearrfidreq;

    wire [1:0] rfidreg;
    wire clearrfiddone;

    rfid_controller DUT (
        .clk(clk),
        .rfid(rfid),
        .clearrfidreq(clearrfidreq),
        .rfidreg(rfidreg),
        .clearrfiddone(clearrfiddone)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin

        // Test Case 1: Initial State
        rfid = 2'b00;
        clearrfidreq = 1'b0;

        repeat (2) @(posedge clk);

        // Test Case 2: Read RFID Tag 01
        rfid = 2'b01;

        @(posedge clk);

        // Test Case 3: Attempt to Overwrite RFID Register
        rfid = 2'b10;

        @(posedge clk);

        // Test Case 4: Clear RFID Register
        clearrfidreq = 1'b1;

        @(posedge clk);

        // Test Case 5: Release Clear Request
        clearrfidreq = 1'b0;
        rfid = 2'b00;

        @(posedge clk);

        // Test Case 6: Read RFID Tag 10
        rfid = 2'b10;

        @(posedge clk);

        // End Simulation
        repeat (2) @(posedge clk);

        $stop;

    end

endmodule
