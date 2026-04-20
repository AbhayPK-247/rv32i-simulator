`timescale 1ns / 1ps
module rv32i_dmem (
    input         clk,
    input         MemRead,
    input         MemWrite,
    input  [31:0] addr,
    input  [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] mem [0:1023];  // 4KB

    // Synchronous write
    always @(posedge clk) begin
        if (MemWrite)
            mem[addr[11:2]] <= write_data;
    end

    // Asynchronous read (single-cycle)
    assign read_data = MemRead ? mem[addr[11:2]] : 32'b0;
endmodule