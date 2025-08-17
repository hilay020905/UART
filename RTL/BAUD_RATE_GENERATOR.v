module baud_rate_generator (
    input wire clk_50mhz,
    output wire rx_clock_enable,
    output wire tx_clock_enable
);

    parameter RX_BAUD_DIVISOR = 50000000 / (115200 * 16); // Receiver clock enable divisor
    parameter TX_BAUD_DIVISOR = 50000000 / 115200;        // Transmitter clock enable divisor
    parameter RX_COUNTER_WIDTH = $clog2(RX_BAUD_DIVISOR);
    parameter TX_COUNTER_WIDTH = $clog2(TX_BAUD_DIVISOR);

    reg [RX_COUNTER_WIDTH-1:0] rx_counter = 0;
    reg [TX_COUNTER_WIDTH-1:0] tx_counter = 0;

    assign rx_clock_enable = (rx_counter == 0);
    assign tx_clock_enable = (tx_counter == 0);

    always @(posedge clk_50mhz) begin
        if (rx_counter == RX_BAUD_DIVISOR-1)
            rx_counter <= 0;
        else
            rx_counter <= rx_counter + 1;
    end

    always @(posedge clk_50mhz) begin
        if (tx_counter == TX_BAUD_DIVISOR-1)
            tx_counter <= 0;
        else
            tx_counter <= tx_counter + 1;
    end

endmodule