`timescale 1ns/1ps

module tb_top_controller;

reg clk;
reg reset;
reg start;
reg pause;
reg [3:0] mode;

wire [9:0] time_remaining;
wire water_valve;
wire motor_wash;
wire motor_spin;
wire drain_pump;
wire door_lock;
wire buzzer;

// DUT
top_controller dut(
    .clk(clk),
    .reset(reset),
    .start(start),
    .pause(pause),
    .mode(mode),

    .time_remaining(time_remaining),
    .water_valve(water_valve),
    .motor_wash(motor_wash),
    .motor_spin(motor_spin),
    .drain_pump(drain_pump),
    .door_lock(door_lock),
    .buzzer(buzzer)
);

// Clock generation
always #5 clk = ~clk;

// Smooth monitoring
always @(posedge clk) begin
    $display("T=%0t | State=%0d | Time=%0d | WV=%b MW=%b MS=%b DP=%b DL=%b BZ=%b",
        $time,
        dut.state,
        time_remaining,
        water_valve,
        motor_wash,
        motor_spin,
        drain_pump,
        door_lock,
        buzzer
    );
end

initial begin

    $dumpfile("wave.vcd");
    $dumpvars(0, tb_top_controller);

    clk = 0;
    reset = 1;
    start = 0;
    pause = 0;
    mode = 0;

    // Reset
    #20 reset = 0;

    // =========================
    // TEST 1: NORMAL MODE (Full Cycle)
    // =========================
    mode = 4'd0;   // NORMAL
    #10 start = 1;
    #10 start = 0;

    // Let full cycle complete
    #1500;

    // =========================
    // TEST 2: QUICK WASH
    // =========================
    mode = 4'd1;
    #20 start = 1;
    #10 start = 0;

    #1000;

    // =========================
    // TEST 3: SUPER CLEAN (with PRESOAK)
    // =========================
    mode = 4'd2;
    #20 start = 1;
    #10 start = 0;

    #2000;

    // =========================
    // TEST 4: DRAIN + SPIN
    // =========================
    mode = 4'd6;
    #20 start = 1;
    #10 start = 0;

    #600;

    // =========================
    // TEST 5: RINSE + SPIN
    // =========================
    mode = 4'd7;
    #20 start = 1;
    #10 start = 0;

    #800;

    $finish;
end

endmodule