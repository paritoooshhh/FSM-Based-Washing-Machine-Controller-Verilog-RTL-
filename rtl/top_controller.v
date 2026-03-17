module top_controller(

    input clk,
    input reset,
    input start,
    input pause,
    input [3:0] mode,

    output [9:0] time_remaining,
    output water_valve,
    output motor_wash,
    output motor_spin,
    output drain_pump,
    output door_lock,
    output buzzer
);

wire [2:0] state;
wire [2:0] next_state;
wire load_timer;
wire enable_timer;
wire timer_done;
wire [9:0] load_value;

washing_fsm fsm_inst(
    .clk(clk),
    .reset(reset),
    .start(start),
    .pause(pause),
    .mode(mode),
    .timer_done(timer_done),

    .state(state),
    .next_state_out(next_state),
    .load_timer(load_timer),
    .enable_timer(enable_timer)
);

mode_timer_lookup lookup_inst(
    .mode(mode),
    .state(next_state),  
    .time_value(load_value)
);

timer_counter timer_inst(
    .clk(clk),
    .reset(reset),
    .load(load_timer),
    .enable(enable_timer),
    .load_value(load_value),

    .time_remaining(time_remaining),
    .timer_done(timer_done)
);

actuator_control act_inst(
    .state(state),

    .water_valve(water_valve),
    .motor_wash(motor_wash),
    .motor_spin(motor_spin),
    .drain_pump(drain_pump),
    .door_lock(door_lock),
    .buzzer(buzzer)
);

endmodule