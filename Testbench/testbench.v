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

always #5 clk = ~clk;

function [8*10:1] get_state_name;
    input [2:0] state;
    begin
        case(state)
            3'd0: get_state_name = "IDLE";
            3'd1: get_state_name = "FILL";
            3'd2: get_state_name = "PRESOAK";
            3'd3: get_state_name = "WASH";
            3'd4: get_state_name = "DRAIN";
            3'd5: get_state_name = "RINSE1";
            3'd6: get_state_name = "SPIN";
            3'd7: get_state_name = "DONE";
            default: get_state_name = "UNKNOWN";
        endcase
    end
endfunction

always @(posedge clk) begin
    $display("T=%0t | %-8s | T_rem=%3d | WV=%b MW=%b MS=%b DP=%b DL=%b BZ=%b",
        $time,
        get_state_name(dut.state),
        time_remaining,
        water_valve,
        motor_wash,
        motor_spin,
        drain_pump,
        door_lock,
        buzzer
    );
end

integer i;

initial begin

    clk = 0;
    reset = 1;
    start = 0;
    pause = 0;
    mode = 0;

    $display("\n==== STARTING SIMULATION ====");

    #10 reset = 0;

    for (i = 0; i <= 4; i = i + 1) begin

        mode = i;
        $display("\n==== MODE = %0d ====", mode);

        #10 start = 1;
        #10 start = 0;

        #300;

        $display("---- PAUSE ----");
        pause = 1;
        #50;

        $display("---- RESUME ----");
        pause = 0;

        #300;

    end

    $display("\n==== END SIMULATION ====");
    $finish;

end

endmodule