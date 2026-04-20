`timescale 1ns / 1ps

module rv32i_reg_file(
    input clk,
    input rst,
    input reg_write,
    
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    
    input [31:0] write_data,
    
    output [31:0] read_data_1,
    output [31:0] read_data_2
    );

reg [31:0] registers [31:0];
integer k;

//write
always @(posedge clk) begin
    if (rst) begin
        for (k = 0;k<32;k = k+1)
        registers[k] <=0;
    end
    
    else if (reg_write && rd != 0)
        registers[rd] <= write_data;
end

//read

assign read_data_1 = 
    (rs1 == 0) ? 0 : registers[rs1];
assign read_data_2 = 
    (rs2 == 0) ? 0 : registers[rs2];
    
endmodule
