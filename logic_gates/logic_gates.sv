`timescale 1ns/100ps

module logic_gates (
    input wire  in_dataA,
    input wire  in_dataB,
    output wire out_notA,
    output wire out_notB,
    output wire out_andC,
    output wire out_orC,
    output wire out_xorC,
    output wire out_nandC,
    output wire out_norC,
    output wire out_xnorC
);

    assign out_notA = ~ in_dataA;
    assign out_notB = ~ in_dataB;

    assign out_andC = in_dataA & in_dataB;
    assign out_orC  = in_dataA | in_dataB;
    assign out_xorC = in_dataA ^ in_dataB;

    assign out_nandC    = ~ (in_dataA & in_dataB);
    assign out_norC     = ~ (in_dataA | in_dataB);
    assign out_xnorC    = ~ (in_dataA ^ in_dataB);

endmodule
