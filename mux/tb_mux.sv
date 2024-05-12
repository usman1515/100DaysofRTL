`timescale 1ns/100ps

module tb_mux;

    localparam DATA_WIDTH = 8;
    logic [DATA_WIDTH-1:0]  in_a;
    logic [DATA_WIDTH-1:0]  in_b;
    logic                   in_sel;
    logic [DATA_WIDTH-1:0]  out;

    mux #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut_mux (
        .in_a(in_a),
        .in_b(in_b),
        .in_sel(in_sel),
        .out(out)
    );

    initial begin
        repeat(10) begin
            in_a    = $urandom_range('h0,'hff);
            in_b    = $urandom_range('h0,'hff);
            in_sel  = $urandom_range(0, 1);
            #1;
            $display("| Time: %2d | Input_A: %h | Input_B: %h | in_sel: %1d | Output: %h |",
                $time, in_a, in_b, in_sel, out);
        end

        $finish;
    end

    initial begin
        $dumpfile("tb_mux.vcd");
        $dumpvars(0, tb_mux);
    end

endmodule