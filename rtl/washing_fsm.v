module washing_fsm(

    input clk,
    input reset,
    input start,
    input pause,
    input [3:0] mode,
    input timer_done,

    output reg [2:0] state,
    output reg [2:0] next_state_out,
    output reg load_timer,
    output reg enable_timer
);

parameter IDLE    = 3'd0;
parameter FILL    = 3'd1;
parameter PRESOAK = 3'd2;
parameter WASH    = 3'd3;
parameter DRAIN   = 3'd4;
parameter RINSE1  = 3'd5;
parameter SPIN    = 3'd6;
parameter DONE    = 3'd7;

parameter NORMAL        = 4'd0;
parameter QUICK_WASH    = 4'd1;
parameter SUPER_CLEAN   = 4'd2;
parameter DELICATES     = 4'd3;
parameter BEDSHEET      = 4'd4;
parameter JEANS         = 4'd5;
parameter DRAIN_SPIN    = 4'd6;
parameter RINSE_SPIN    = 4'd7;
parameter TUB_CLEAN     = 4'd8;
parameter ECO_TUB_CLEAN = 4'd9;
parameter PRESOAK_WASH  = 4'd10;

reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin

    next_state = state;

    case(state)

        IDLE: begin
            if (start) begin
                if (mode == DRAIN_SPIN)
                    next_state = DRAIN;
                else if (mode == RINSE_SPIN)
                    next_state = RINSE1;
                else
                    next_state = FILL;
            end
        end

        FILL: begin
            if (timer_done) begin
                if (mode == SUPER_CLEAN || mode == BEDSHEET || mode == JEANS || mode == PRESOAK_WASH)
                    next_state = PRESOAK;
                else
                    next_state = WASH;
            end
        end

        PRESOAK: begin
            if (timer_done)
                next_state = WASH;
        end

        WASH: begin
            if (timer_done)
                next_state = DRAIN;
        end

        DRAIN: begin
            if (timer_done) begin
                if (mode == DRAIN_SPIN)
                    next_state = SPIN;
                else if (mode == ECO_TUB_CLEAN)
                    next_state = DONE;
                else
                    next_state = RINSE1;
            end
        end

        RINSE1: begin
            if (timer_done)
                next_state = SPIN;
        end

        SPIN: begin
            if (timer_done)
                next_state = DONE;
        end

        DONE: begin
            next_state = IDLE;
        end

    endcase

    next_state_out = next_state;

end

always @(*) begin

    load_timer = 0;
    enable_timer = 1;

    if (timer_done)
        load_timer = 1;

    if (pause)
        enable_timer = 0;

end

endmodule
