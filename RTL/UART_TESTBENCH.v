module uart_testbench;

    reg [7:0] test_data_in = 0;
    reg clk_50mhz = 0;
    reg write_enable = 0;
    reg rx_clear_ready = 0;

    wire tx_active;
    wire rx_data_ready;
    wire [7:0] test_data_out;
    wire serial_loopback;

    uart_top test_uart (
        .data_in(test_data_in),
        .write_enable(write_enable),
        .clk_50mhz(clk_50mhz),
        .serial_tx(serial_loopback),
        .tx_active(tx_active),
        .serial_rx(serial_loopback),
        .rx_data_ready(rx_data_ready),
        .rx_clear_ready(rx_clear_ready),
        .data_out(test_data_out)
    );

    initial begin
        $dumpfile("uart_waveform.vcd");
        $dumpvars(0, uart_testbench);
        write_enable <= 1'b1;
        #2 write_enable <= 1'b0;
    end

    always begin
        #1 clk_50mhz = ~clk_50mhz;
    end

    always @(posedge rx_data_ready) begin
        #2 rx_clear_ready <= 1;
        #2 rx_clear_ready <= 0;
        if (test_data_out != test_data_in) begin
            $display("FAIL: Received data %x does not match transmitted %x", test_data_out, test_data_in);
            $finish;
        end else begin
            if (test_data_out == 8'hff) begin
                $display("SUCCESS: All bytes verified");
                $finish;
            end
            test_data_in <= test_data_in + 1'b1;
            write_enable <= 1'b1;
            #2 write_enable <= 1'b0;
        end
    end

endmodule