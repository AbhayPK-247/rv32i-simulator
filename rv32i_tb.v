module rv32i_tb;

reg clk, rst;

// Instantiate your top
rv32i_top uut (
    .clk(clk),
    .rst(rst)
);

// Clock: 10ns period
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    #20;
    rst = 0;       // release reset
    #1000;         // run for 1000ns
    $finish;
end

// Dump waveform
initial begin
    $dumpfile("rv32i_tb.vcd");
    $dumpvars(0, rv32i_tb);
end

endmodule