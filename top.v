module top(
    input CLK,
    output USBPU,
    output PIN_1,
    output PIN_2,
    output PIN_3,
    output PIN_4,
);
    assign USBPU = 0; // disable USB
    wire clk1hz;

    dclk d0(.clk16mhz(CLK), .clk1hz(clk1hz));
    counter c0(.clk(clk1hz), .count({PIN_4, PIN_3, PIN_2, PIN_1}));
endmodule





module counter(
    input clk,
    output reg [3:0] count,
);
    always @(posedge clk) begin
        count <= count + 1;
    end
endmodule





module dclk(
    input clk16mhz,
    output reg clk1hz,
);
    reg [25:0] counter;
    always @(posedge clk16mhz) begin
        counter <= counter + 1;
        if (counter == 8_000_000) begin
            counter <= 0;
            clk1hz <= ~clk1hz;
        end
    end
endmodule
