`timescale 1ns/1ps
module rv32i_control_unit(

    input [6:0] opcode,

    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg MemToReg,
    output reg ALUSrc,
    output reg Branch,
    output reg Jump,
    output reg [1:0] ALUOp

);

always @(*) begin

    RegWrite = 0;
    MemRead = 0;
    MemWrite = 0;
    MemToReg = 0;
    ALUSrc = 0;
    Branch = 0;
    Jump = 0;
    ALUOp = 2'b00;

    case(opcode)

        7'b0110011: begin
            RegWrite = 1;
            ALUOp = 2'b10;
        end

        7'b0010011: begin
            RegWrite = 1;
            ALUSrc = 1;
            ALUOp = 2'b10;
        end

        7'b0000011: begin
            RegWrite = 1;
            MemRead = 1;
            MemToReg = 1;
            ALUSrc = 1;
        end

        7'b0100011: begin
            MemWrite = 1;
            ALUSrc = 1;
        end

        7'b1100011: begin
            Branch = 1;
            ALUOp = 2'b01;
        end

        7'b1101111: begin
            RegWrite = 1;
            Jump = 1;
        end

        7'b1100111: begin
            RegWrite = 1;
            Jump = 1;
            ALUSrc = 1;
        end

        7'b0110111: begin
            RegWrite = 1;
            ALUSrc = 1;
        end

        7'b0010111: begin
            RegWrite = 1;
            ALUSrc = 1;
        end

    endcase

end

endmodule