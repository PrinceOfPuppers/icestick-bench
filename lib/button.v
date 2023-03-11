module button(input clk, sclk, i, output o);
    // debounce
    reg [2:0] counter;
    wire db;

    always @(posedge sclk) begin
        if (i) begin
            counter <= counter == '1 ? counter : counter + 1;
        end
        else begin
            counter <= 0;
        end
    end
    assign db = counter == '1; 

    // sync
    reg r1,r2;
    always @(posedge clk) begin
        r1 <= db;
        r2 <= r1;
    end
    assign o = r2;
endmodule

module buttonPulse(input clk, sclk, i, output o);
    // debounce
    reg [2:0] counter;
    wire db;

    always @(posedge sclk) begin
        if (i) begin
            counter <= counter == '1 ? counter : counter + 1;
        end
        else begin
            counter <= 0;
        end
    end
    assign db = counter == '1; 

    // sync and ltp
    reg r1,r2,r3;
    always @(posedge clk) begin
        r1 <= db;
        r2 <= r1;
        r3 <= r2;
    end
    assign o = ~r3 & r2;
endmodule


module clockDiv #(parameter PWR_2 = 17)(
    input clk,
    input reset,
    output sclk
);
    reg [PWR_2-1:0] r;

    always @(posedge clk) begin
        r <= r + 1;
    end

    assign sclk = r[PWR_2-1];
endmodule
