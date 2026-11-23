`timescale 1ns/1ps

module tb_traffic_signal_controller;

    reg clk;
    reg reset;
    reg pedestrian_req;
    reg emergency;

    wire red;
    wire yellow;
    wire green;
    wire pedestrian_walk;

    // Instantiate DUT
    traffic_signal_controller DUT (
        .clk(clk),
        .reset(reset),
        .pedestrian_req(pedestrian_req),
        .emergency(emergency),
        .red(red),
        .yellow(yellow),
        .green(green),
        .pedestrian_walk(pedestrian_walk)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // Initialize
        clk = 0;
        reset = 1;
        pedestrian_req = 0;
        emergency = 0;

        // Reset
        #20;
        reset = 0;

        // Normal operation
        #100;

        // Pedestrian request
        pedestrian_req = 1;
        #20;
        pedestrian_req = 0;

        // Normal operation
        #50;

        // Emergency vehicle
        emergency = 1;
        #30;
        emergency = 0;

        // Continue normal operation
        #100;

        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | Reset=%b Emergency=%b Pedestrian=%b | R=%b Y=%b G=%b Walk=%b",
                 $time, reset, emergency, pedestrian_req,
                 red, yellow, green, pedestrian_walk);
    end

endmodule
