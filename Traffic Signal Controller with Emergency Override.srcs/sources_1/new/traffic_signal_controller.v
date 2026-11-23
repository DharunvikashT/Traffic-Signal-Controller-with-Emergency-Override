module traffic_signal_controller (
    input  wire       clk,
    input  wire       reset,
    input  wire       pedestrian_req,
    input  wire       emergency,

    output reg        red,
    output reg        yellow,
    output reg        green,
    output reg        pedestrian_walk
);

    // State encoding
    localparam RED    = 2'b00;
    localparam GREEN  = 2'b01;
    localparam YELLOW = 2'b10;
    localparam EMERGENCY = 2'b11;

    reg [1:0] state, next_state;

    // Counter for timing
    reg [3:0] count;

    // State register and counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RED;
            count <= 4'd0;
        end
        else begin
            state <= next_state;

            if (state != next_state)
                count <= 4'd0;
            else
                count <= count + 1'b1;
        end
    end

    // Next-state logic
    always @(*) begin
        next_state = state;

        // Emergency has highest priority
        if (emergency) begin
            next_state = EMERGENCY;
        end
        else begin
            case (state)

                RED: begin
                    if (count >= 4'd3)
                        next_state = GREEN;
                end

                GREEN: begin
                    if (pedestrian_req)
                        next_state = YELLOW;
                    else if (count >= 4'd5)
                        next_state = YELLOW;
                end

                YELLOW: begin
                    if (count >= 4'd2)
                        next_state = RED;
                end

                EMERGENCY: begin
                    next_state = RED;
                end

                default:
                    next_state = RED;

            endcase
        end
    end

    // Output logic
    always @(*) begin

        // Default outputs
        red = 1'b0;
        yellow = 1'b0;
        green = 1'b0;
        pedestrian_walk = 1'b0;

        case (state)

            RED: begin
                red = 1'b1;
                pedestrian_walk = 1'b1;
            end

            GREEN: begin
                green = 1'b1;
            end

            YELLOW: begin
                yellow = 1'b1;
            end

            EMERGENCY: begin
                red = 1'b1;
            end

            default: begin
                red = 1'b1;
            end

        endcase
    end

endmodule