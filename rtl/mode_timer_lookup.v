module mode_timer_lookup(

    input  [3:0] mode,
    input  [2:0] state,

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
                FILL:   time_value = 10'd10;
                WASH:   time_value = 10'd30;
                DRAIN:  time_value = 10'd4;
                RINSE1: time_value = 10'd10;
                SPIN:   time_value = 10'd12;
                default: ;
            endcase
        end

        QUICK_WASH: begin
            case(state)
                FILL:   time_value = 10'd6;
                WASH:   time_value = 10'd14;
                DRAIN:  time_value = 10'd4;
                RINSE1: time_value = 10'd6;
                SPIN:   time_value = 10'd8;
                default: ;
            endcase
        end

        SUPER_CLEAN: begin
            case(state)
                FILL:    time_value = 10'd12;
                PRESOAK: time_value = 10'd20;
                WASH:    time_value = 10'd40;
                DRAIN:   time_value = 10'd6;
                RINSE1:  time_value = 10'd14;
                SPIN:    time_value = 10'd16;
                default: ;
            endcase
        end

        DELICATES: begin
            case(state)
                FILL:   time_value = 10'd8;
                WASH:   time_value = 10'd14;
                DRAIN:  time_value = 10'd4;
                RINSE1: time_value = 10'd8;
                SPIN:   time_value = 10'd5;
                default: ;
            endcase
        end

        BEDSHEET: begin
            case(state)
                FILL:    time_value = 10'd12;
                PRESOAK: time_value = 10'd18;
                WASH:    time_value = 10'd30;
                DRAIN:   time_value = 10'd6;
                RINSE1:  time_value = 10'd12;
                SPIN:    time_value = 10'd12;
                default: ;
            endcase
        end

        JEANS: begin
            case(state)
                FILL:    time_value = 10'd10;
                PRESOAK: time_value = 10'd16;
                WASH:    time_value = 10'd32;
                DRAIN:   time_value = 10'd6;
                RINSE1:  time_value = 10'd12;
                SPIN:    time_value = 10'd14;
                default: ;
            endcase
        end

        DRAIN_SPIN: begin
            case(state)
                DRAIN: time_value = 10'd6;
                SPIN:  time_value = 10'd10;
                default: ;
            endcase
        end

        RINSE_SPIN: begin
            case(state)
                FILL:   time_value = 10'd8;
                RINSE1: time_value = 10'd10;
                SPIN:   time_value = 10'd10;
                default: ;
            endcase
        end

        TUB_CLEAN: begin
            case(state)
                FILL:   time_value = 10'd10;
                WASH:   time_value = 10'd40;
                DRAIN:  time_value = 10'd6;
                RINSE1: time_value = 10'd12;
                SPIN:   time_value = 10'd10;
                default: ;
            endcase
        end

        ECO_TUB_CLEAN: begin
            case(state)
                FILL:  time_value = 10'd10;
                WASH:  time_value = 10'd50;
                DRAIN: time_value = 10'd6;
                default: ;
            endcase
        end

        PRESOAK_WASH: begin
            case(state)
                FILL:    time_value = 10'd10;
                PRESOAK: time_value = 10'd20;
                WASH:    time_value = 10'd24;
                DRAIN:   time_value = 10'd6;
                RINSE1:  time_value = 10'd10;
                SPIN:    time_value = 10'd10;
                default: ;
            endcase
        end

        default: time_value = 10'd0;

    endcase

end

endmodule
