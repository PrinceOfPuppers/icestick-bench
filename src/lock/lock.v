module lock #(parameter CODE_SIZE=8)(
    input clk,
    input b0, b1, enter, reset,
    input [CODE_SIZE-1:0] code, 
    output out,
    output [CODE_SIZE-1:0] currentOut
);

    reg [CODE_SIZE-1:0] current;
    reg locked;

    assign currentOut = current;
    assign out = locked;

    always @(posedge clk) begin
        if (reset) begin
            locked <= 1;
            current <= 0;
        end
        else if (enter) begin
            locked <= code != current;
            current <= 0;
        end
        else if (b0) begin
            //current <= current + 1;
            current <= current << 1;
        end
        else if (b1) begin
            current <= (current << 1) + 1;
        end
    end
endmodule


module tmod (
    input CLK,
    input TR10, TR9, TR8, TR7,
    output D0, D1, D2, D3, D4,
    output BR10, BR9, BR8, BR7, BR6, BR5, BR4, BR3, TR5, TR4
);
    wire sclk;
    clockDiv c_mod(.clk(CLK), .reset(TR7), .sclk(sclk));

    reg [9:0] code = 10'b1000000110;

    assign D0 = 0;
    assign D1 = 0;
    assign D2 = 0;
    assign D3 = 0;

    wire locked;
    assign D4 = locked;

    wire [9:0] current;
    assign {BR10, BR9, BR8, BR7, BR6, BR5, BR4, BR3, TR5, TR4} = current;

    wire b0, b1, b2, b3;
    buttonPulse d0_mod(.clk(CLK), .sclk(sclk), .i(TR10), .o(b0));
    buttonPulse d1_mod(.clk(CLK), .sclk(sclk), .i(TR9),  .o(b1));
    buttonPulse d2_mod(.clk(CLK), .sclk(sclk), .i(TR8),  .o(b2));
    buttonPulse d3_mod(.clk(CLK), .sclk(sclk), .i(TR7),  .o(b3));

    lock #(10) l(.clk(CLK), .b0(b0), .b1(b1), .enter(b2), .reset(b3), .code(code), .out(locked), .currentOut(current));

endmodule
