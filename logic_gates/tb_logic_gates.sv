`timescale 1ns/100ps

module tb_logic_gates;

    localparam T = 10;

    reg     in_dataA;
    reg     in_dataB;
    reg     out_notA;
    reg     out_notB;
    reg     out_andC;
    reg     out_orC;
    reg     out_xorC;
    reg     out_nandC;
    wire    out_norC;
    wire    out_xnorC;

    logic_gates dut_logic_gates (
        .in_dataA(in_dataA),
        .in_dataB(in_dataB),
        .out_notA(out_notA),
        .out_notB(out_notB),
        .out_andC(out_andC),
        .out_orC(out_orC),
        .out_xorC(out_xorC),
        .out_nandC(out_nandC),
        .out_norC(out_norC),
        .out_xnorC(out_xnorC)
    );

    initial begin
        repeat(10) begin
            in_dataA = $urandom_range(0, 1);
            in_dataB = $urandom_range(0, 1);
            #T;
            $display("| in_dataA: %b | in_dataB:  %b |", in_dataA, in_dataB);
            $display("| out_notA: %b | out_andC:  %b | out_orC:  %b | out_xorC:  %b |",
                        out_notA, out_andC, out_orC, out_xorC);
            $display("| out_notB: %b | out_nandC: %b | out_norC: %b | out_nxorC: %b |\n",
                        out_notB, out_nandC, out_norC, out_xnorC);
        end

        $finish;
    end

    initial begin
        $dumpfile("tb_logic_gates.vcd");
        $dumpvars(0,tb_logic_gates);
    end

endmodule
