`timescale 1ns / 1ps
module rv32i_imem (
    input  [31:0] addr,
    output [31:0] instruction
);
    reg [31:0] mem [0:1023];  // 4KB

    initial begin
        $readmemh("program.hex", mem);  // load your RISC-V program
    end

    assign instruction = mem[addr[11:2]]; // word-aligned access
endmodule