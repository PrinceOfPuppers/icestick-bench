
module animation_tmod (
    input CLK,
    input TR10, TR9, TR8, TR7,
    output D0, D1, D2, D3, D4,
    output BR10, BR9, BR8, BR7, BR6, BR5, BR4, BR3, TR5, TR4
);
    wire [19:0] sclks;
    clockDiv #(.PWR_2(20)) c_mod(.clk(CLK), .reset(TR7), .sclks(sclks));
    wire aniClk = sclks[19];
    wire buttonClk = sclks[16];

    assign D0 = 0;
    assign D1 = 0;
    assign D2 = 0;
    assign D3 = 0;
    assign D4 = 0;

    reg [5:0] PC = 0;

    reg [9:0] MEM [0:41];

    initial begin
        MEM[0]  = 10'b0011111100;
        MEM[1]  = 10'b1001111001;
        MEM[2]  = 10'b0100110010;
        MEM[3]  = 10'b0010000100;
        MEM[4]  = 10'b0001001000;
        MEM[5]  = 10'b0000110000;
        MEM[6]  = 10'b0001001000;
        MEM[7]  = 10'b0010000100;
        MEM[8]  = 10'b0100110010;
        MEM[9]  = 10'b1001111001;
        MEM[10] = 10'b0011111100;
        MEM[11] = 10'b0111001110;
        MEM[12] = 10'b1110000111;
        MEM[13] = 10'b1100000011;
        MEM[14] = 10'b1000000001;
        MEM[15] = 10'b1100000011;
        MEM[16] = 10'b1110000111;
        MEM[17] = 10'b1110000111;
        MEM[18] = 10'b0111001110;
        MEM[19] = 10'b0001111000;

        MEM[20] = 10'b1010101010;
        MEM[21] = 10'b0101010101;
        MEM[22] = 10'b1010101010;
        MEM[23] = 10'b0101010101;
        MEM[24] = 10'b0010101010;
        MEM[25] = 10'b0001010101;
        MEM[26] = 10'b0000101010;
        MEM[27] = 10'b1000010101;
        MEM[28] = 10'b1100001010;
        MEM[29] = 10'b1110000101;
        MEM[30] = 10'b1111000010;
        MEM[31] = 10'b1111100001;
        MEM[32] = 10'b1111110000;
        MEM[33] = 10'b1111111000;
        MEM[34] = 10'b1111111110;
        MEM[35] = 10'b1111111111;
        MEM[36] = 10'b1111111111;
        MEM[37] = 10'b1111111110;
        MEM[38] = 10'b1011101110;
        MEM[39] = 10'b1010101110;
        MEM[40] = 10'b1010101010;
    end
    reg block = 0;
    wire [5:0] offset;
    assign offset = block*20;

    wire b0;
    button d0_mod(.clk(CLK), .sclk(buttonClk), .i(TR9), .o(b0));

    assign {BR10, BR9, BR8, BR7, BR6, BR5, BR4, BR3, TR5, TR4} = MEM[PC + offset];

    always @(posedge aniClk) begin;
        PC <= (TR10 || PC==20) ? 0 : (PC+1);
    end

    always @(posedge b0) begin
        block <= block+1;
    end

endmodule
