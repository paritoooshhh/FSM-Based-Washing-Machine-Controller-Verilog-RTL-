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

top_controller uut (
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

always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;
    start = 0;
    pause = 0;
    mode = 0;

    // reset pulse
    #10;
    reset = 0;

    $display("---- NORMAL MODE ----");
    mode = 4'd0;  // NORMAL
    start = 1;

    #20;
    start = 0;

    #400;

    $display("---- QUICK WASH ----");
    mode = 4'd1;  // QUICK
    start = 1;

    #20;
    start = 0;

    #300;

    $display("---- DRAIN SPIN ----");
    mode = 4'd6;
    start = 1;

    #20;
    start = 0;

    #200;

    $display("---- PAUSE TEST ----");
    mode = 4'd0;
    start = 1;

    #20;
    start = 0;

    #50;
    pause = 1;   // pause
    #50;
    pause = 0;   // resume

    #300;

    $display("Simulation Finished");
    $stop;

end

initial begin
    $monitor("Time=%0t | mode=%0d | state=%0d | time_left=%0d | valve=%b wash=%b spin=%b drain=%b lock=%b buzzer=%b",
        $time, mode, uut.fsm_inst.state, time_remaining,
        water_valve, motor_wash, motor_spin, drain_pump, door_lock, buzzer);
end

endmodule