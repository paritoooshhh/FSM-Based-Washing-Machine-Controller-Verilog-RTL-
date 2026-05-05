module actuator_control(

    input [2:0] state,

    output reg water_valve,
    output reg motor_wash,
    output reg motor_spin,
    output reg drain_pump,
    output reg door_lock,
    output reg buzzer
);

parameter IDLE    = 3'd0;
parameter FILL    = 3'd1;
parameter PRESOAK = 3'd2;
parameter WASH    = 3'd3;
parameter DRAIN   = 3'd4;
parameter RINSE1  = 3'd5;
parameter SPIN    = 3'd6;
parameter DONE    = 3'd7;

always @(*) begin

    water_valve = 0;
    motor_wash  = 0;
    motor_spin  = 0;
    drain_pump  = 0;
    door_lock   = 0;
    buzzer      = 0;

    case (state)

        IDLE: begin
        end

        FILL: begin
            water_valve = 1;
            door_lock   = 1;
        end

        PRESOAK,
        WASH: begin
            motor_wash = 1;
            door_lock  = 1;
        end

        DRAIN: begin
            drain_pump = 1;
            door_lock  = 1;
        end

        RINSE1: begin
            water_valve = 1;
            motor_wash  = 1;
            door_lock   = 1;
        end

        SPIN: begin
            motor_spin = 1;
            door_lock  = 1;
        end

        DONE: begin
            buzzer    = 1;
            door_lock = 0;
        end

        default: begin
            water_valve = 0;
            motor_wash  = 0;
            motor_spin  = 0;
            drain_pump  = 0;
            door_lock   = 0;
            buzzer      = 0;
        end

    endcase

end

endmodule
