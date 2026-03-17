module mode_timer_lookup(

    input [3:0] mode,
    input [2:0] state,

    output reg [9:0] time_value

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


always @(*) begin

    time_value = 10'd0;

    case(mode)

        NORMAL: begin
            case(state)
                FILL:   time_value = 10;
                WASH:   time_value = 30;
                DRAIN:  time_value = 4;
                RINSE1: time_value = 10;
                SPIN:   time_value = 12;

                default: time_value = 10'd0;
            endcase
        end

        QUICK_WASH: begin
            case(state)
                FILL:   time_value = 6;
                WASH:   time_value = 14;
                DRAIN:  time_value = 4;
                RINSE1: time_value = 6;
                SPIN:   time_value = 8;

                default: time_value = 10'd0;
            endcase
        end

        SUPER_CLEAN: begin
            case(state)
                FILL:    time_value = 12;
                PRESOAK: time_value = 20;
                WASH:    time_value = 40;
                DRAIN:   time_value = 6;
                RINSE1:  time_value = 14;
                SPIN:    time_value = 16;

                default: time_value = 10'd0;
            endcase
        end

        DELICATES: begin
            case(state)
                FILL:   time_value = 8;
                WASH:   time_value = 14;
                DRAIN:  time_value = 4;
                RINSE1: time_value = 8;
                SPIN:   time_value = 5;

                default: time_value = 10'd0;
            endcase
        end

        BEDSHEET: begin
            case(state)
                FILL:    time_value = 12;
                PRESOAK: time_value = 18;
                WASH:    time_value = 30;
                DRAIN:   time_value = 6;
                RINSE1:  time_value = 12;
                SPIN:    time_value = 12;

                default: time_value = 10'd0;
            endcase
        end
  
        JEANS: begin
            case(state)
                FILL:    time_value = 10;
                PRESOAK: time_value = 16;
                WASH:    time_value = 32;
                DRAIN:   time_value = 6;
                RINSE1:  time_value = 12;
                SPIN:    time_value = 14;

                default: time_value = 10'd0;
            endcase
        end

        DRAIN_SPIN: begin
            case(state)
                DRAIN: time_value = 6;
                SPIN:  time_value = 10;

                default: time_value = 10'd0;
            endcase
        end

        RINSE_SPIN: begin
            case(state)
                FILL:   time_value = 8;
                RINSE1: time_value = 10;
                SPIN:   time_value = 10;

                default: time_value = 10'd0;
            endcase
        end

        TUB_CLEAN: begin
            case(state)
                FILL:   time_value = 10;
                WASH:   time_value = 40;
                DRAIN:  time_value = 6;
                RINSE1: time_value = 12;
                SPIN:   time_value = 10;

                default: time_value = 10'd0;
            endcase
        end

        ECO_TUB_CLEAN: begin
            case(state)
                FILL:  time_value = 10;
                WASH:  time_value = 50;
                DRAIN: time_value = 6;

                default: time_value = 10'd0;
            endcase
        end

        PRESOAK_WASH: begin
            case(state)
                FILL:    time_value = 10;
                PRESOAK: time_value = 20;
                WASH:    time_value = 24;
                DRAIN:   time_value = 6;
                RINSE1:  time_value = 10;
                SPIN:    time_value = 10;

                default: time_value = 10'd0;
            endcase
        end

    endcase

end

endmodule