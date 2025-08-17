module uart_transmitter (
    input wire [7:0] data_in,
    input wire write_enable,
    input wire clk_50mhz,
    input wire clock_enable,
    output reg serial_tx,
    output wire tx_active
);

    parameter IDLE_STATE  = 2'b00;
    parameter START_STATE = 2'b01;
    parameter DATA_STATE  = 2'b10;
    parameter STOP_STATE  = 2'b11;

    reg [7:0] data_buffer = 8'h00;
    reg [2:0] bit_index = 3'h0;
    reg [1:0] state = IDLE_STATE;

    initial begin
        serial_tx = 1'b1;
    end

    always @(posedge clk_50mhz) begin
        case (state)
            IDLE_STATE: begin
                if (write_enable) begin
                    state <= START_STATE;
                    data_buffer <= data_in;
                    bit_index <= 3'h0;
                end
            end
            START_STATE: begin
                if (clock_enable) begin
                    serial_tx <= 1'b0;
                    state <= DATA_STATE;
                end
            end
            DATA_STATE: begin
                if (clock_enable) begin
                    if (bit_index == 3'h7)
                        state <= STOP_STATE;
                    else
                        bit_index <= bit_index + 3'h1;
                    serial_tx <= data_buffer[bit_index];
                end
            end
            STOP_STATE: begin
                if (clock_enable) begin
                    serial_tx <= 1'b1;
                    state <= IDLE_STATE;
                end
            end
            default: begin
                serial_tx <= 1'b1;
                state <= IDLE_STATE;
            end
        endcase
    end

    assign tx_active = (state != IDLE_STATE);

endmodule