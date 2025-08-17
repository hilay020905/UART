`timescale 1ns / 1ps

// Top-level UART module
module uart_top (
    input wire [7:0] data_in,
    input wire write_enable,
    input wire clk_50mhz,
    output wire serial_tx,
    output wire tx_active,
    input wire serial_rx,
    output wire rx_data_ready,
    input wire rx_clear_ready,
    output wire [7:0] data_out
);

    wire rx_clock_enable, tx_clock_enable;

    baud_rate_generator baud_gen (
        .clk_50mhz(clk_50mhz),
        .rx_clock_enable(rx_clock_enable),
        .tx_clock_enable(tx_clock_enable)
    );

    uart_transmitter tx_unit (
        .data_in(data_in),
        .write_enable(write_enable),
        .clk_50mhz(clk_50mhz),
        .clock_enable(tx_clock_enable),
        .serial_tx(serial_tx),
        .tx_active(tx_active)
    );

    uart_receiver rx_unit (
        .serial_rx(serial_rx),
        .rx_data_ready(rx_data_ready),
        .rx_clear_ready(rx_clear_ready),
        .clk_50mhz(clk_50mhz),
        .clock_enable(rx_clock_enable),
        .data_out(data_out)
    );

endmodule