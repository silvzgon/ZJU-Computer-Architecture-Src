`timescale 1ns / 1ps

module    REG_ID_EX(input        clk,
                    input        rst,
                    input        EN,
                    input        flush,
                    input [31:0] IR_ID,
                    input [31:0] PCurrent_ID,
                    input [4:0]  rs1_addr,
                    input [4:0]  rs2_addr,
                    input [31:0] rs1_data,
                    input [31:0] rs2_data,
                    input [31:0] Imm32,
                    input [4:0]  rd_addr,
                    input        ALUSrc_A,
                    input        ALUSrc_B,
                    input [3:0]  ALUC,
                    input        DatatoReg,
                    input        RegWrite,
                    input        WR,
                    input [2:0] u_b_h_w,
                    input       mem_r,
                    input       csr_rw,
                    input       csr_w_imm_mux,
                    input       mret,
                    input [1:0] exp_vector,

                    output reg [31:0] PCurrent_EX,
                    output reg [31:0] IR_EX,
                    output reg [4:0]  rs1_EX,
                    output reg [4:0]  rs2_EX,
                    output reg [31:0] A_EX,
                    output reg [31:0] B_EX,
                    output reg [31:0] Imm32_EX,
                    output reg [4:0]  rd_EX,
                    output reg        ALUSrc_A_EX,
                    output reg        ALUSrc_B_EX,
                    output reg [3:0]  ALUC_EX,
                    output reg        DatatoReg_EX,
                    output reg        RegWrite_EX,
                    output reg        WR_EX,
                    output reg [2:0]  u_b_h_w_EX,
                    output reg        mem_r_EX,
                    output reg        isFlushed,
                    output reg        csr_rw_EX,
                    output reg        csr_w_imm_mux_EX,
                    output reg        mret_EX,
                    output reg [1:0]  exp_vector_EX
                );

    always @(posedge clk or posedge rst) begin                           //ID/EX Latch
        if(rst) begin
            rd_EX         <= 0;
            RegWrite_EX   <= 0;
            WR_EX         <= 0;
            IR_EX         <= 32'h00000000;
            PCurrent_EX   <= 32'h00000000 ;
            rs1_EX        <= 0;
            rs2_EX        <= 0;
            mem_r_EX      <= 0;
            isFlushed     <= 0;
            csr_rw_EX     <= 0;
            mret_EX       <= 0;
            exp_vector_EX <= 0;
        end
        else if(EN) begin
            if(flush) begin
                IR_EX         <= 32'h00000000;
                rd_EX         <= 0;
                RegWrite_EX   <= 0;
                WR_EX         <= 0;
                PCurrent_EX   <= PCurrent_ID;
                mem_r_EX      <= 0;
                isFlushed     <= 1;
                csr_rw_EX     <= 0;
                mret_EX       <= 0;
                exp_vector_EX <= 0;
            end
            else begin
                PCurrent_EX      <= PCurrent_ID;
                IR_EX            <= IR_ID;
                A_EX             <= rs1_data;
                B_EX             <= rs2_data;
                Imm32_EX         <= Imm32;
                rd_EX            <= rd_addr;
                rs1_EX           <= rs1_addr;
                rs2_EX           <= rs2_addr;
                ALUSrc_A_EX      <= ALUSrc_A;
                ALUSrc_B_EX      <= ALUSrc_B;
                ALUC_EX          <= ALUC;
                DatatoReg_EX     <= DatatoReg;
                RegWrite_EX      <= RegWrite;
                WR_EX            <= WR;
                u_b_h_w_EX       <= u_b_h_w;
                mem_r_EX         <= mem_r;
                isFlushed        <= 0;
                csr_rw_EX        <= csr_rw;
                mret_EX          <= mret;
                exp_vector_EX    <= exp_vector;
                csr_w_imm_mux_EX <= csr_w_imm_mux;
            end
        end
    end

endmodule
