module uart_receiver (
    input wire serial_rx,
    output reg rx_data_ready,
    input wire rx_clear_ready,
    input wire clk_50mhz,
    input wire clock_enable,
    output reg [7:0] data_out
);

    parameter RX_START_STATE = 2'b00;
    parameter RX_DATA_STATE  = 2'b01;
    parameter RX_STOP_STATE  = 2'b10;

    reg [1:0] state = RX_START_STATE;
    reg [3:0] sample_counter = 0;
    reg [3:0] bit_index = 0;
    reg [7:0] data_buffer = 8'b0;

    initial begin
        rx_data_ready = 0;
        data_out = 8'b0;
    end

    always @(posedge clk_50mhz) begin
        if (rx_clear_ready)
            rx_data_ready <= 0;

        if (clock_enable) begin
            case (state)
                RX_START_STATE: begin
                    if (!serial_rx || sample_counter != 0)
                        sample_counter <= sample_counter + 4'b1;

                    if (sample_counter == 15) begin
                        state <= RX_DATA_STATE;
                        bit_index <= 0;
                        sample_counter <= 0;
                        data_buffer <= 0;
                    end
                end
                RX_DATA_STATE: begin
                    sample_counter <= sample_counter + 4'b1;
                    if (sample_counter == 4'h8) begin
                        data_buffer[bit_index[2:0]] <= serial_rx;
                        bit_index <= bit_index + 4'b1;
                    end
                    if (bit_index == 8 && sample_counter == 15)
                        state <= RX_STOP_STATE;
                end
                RX_STOP_STATE: begin
                    if (sample_counter == 15 || (sample_counter >= 8 && !serial_rx)) begin
                        state <= RX_START_STATE;
                        data_out <= data_buffer;
                        rx_data_ready <= 1'b1;
                        sample_counter <= 0;
                    end else begin
                        sample_counter <= sample_counter + 4'b1;
                    end
                end
                default: begin
                    state <= RX_START_STATE;
                end
            endcase
        end
    end

endmodule