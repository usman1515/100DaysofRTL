`timescale 1ns/100ps

module mux #(parameter DATA_WIDTH=1) (
    input   logic [DATA_WIDTH-1:0]  in_a,
    input   logic [DATA_WIDTH-1:0]  in_b,
    input   logic                   in_sel,
    output  logic [DATA_WIDTH-1:0]  out
);

    // approach 1
    // assign out = (in_a & ~in_sel) | (in_b & in_sel);

    // approach 2
    // always @(*) begin
    //     out = (in_sel)? in_a : in_b;
    // end

    // approach 3
    always @(*) begin
        case (in_sel)
            1'd0: out = in_a;
            1'd1: out = in_b;
            default: out = 'd0;
        endcase
    end

endmodule