`timescale 1ns/1ps
module rv32i_alu_control(

    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg [3:0] alu_ctrl

);

always @(*) begin

    case(ALUOp)

        2'b00: alu_ctrl = 4'b0010; // ADD (load/store)

        2'b01: alu_ctrl = 4'b0110; // SUB (branch)

        2'b10: begin

            case(funct3)

                3'b000:
                    if(funct7 == 7'b0100000)
                        alu_ctrl = 4'b0110; // SUB
                    else
                        alu_ctrl = 4'b0010; // ADD

                3'b111: alu_ctrl = 4'b0000; // AND
                3'b110: alu_ctrl = 4'b0001; // OR
                3'b100: alu_ctrl = 4'b0011; // XOR
                3'b001: alu_ctrl = 4'b0100; // SLL
                3'b101:
                    if(funct7 == 7'b0100000)
                        alu_ctrl = 4'b1000; // SRA
                    else
                        alu_ctrl = 4'b0101; // SRL
                3'b010: alu_ctrl = 4'b0111; // SLT

                default: alu_ctrl = 4'b0000;

            endcase

        end

        default: alu_ctrl = 4'b0000;

    endcase

end

endmodule