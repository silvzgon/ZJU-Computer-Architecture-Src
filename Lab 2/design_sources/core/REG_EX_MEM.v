`timescale 1ns / 1ps

module   REG_EX_MEM(input        clk,
                    input        rst,
                    input        EN,
                    input        flush,
                    input [31:0] IR_EX,
                    input [31:0] PCurrent_EX,
                    input [31:0] ALUO_EX,
                    input [31:0] B_EX,
                    input [4:0]  rs1_EX, rd_EX,
                    input [31:0] rs1_data_EX,
                    input        DatatoReg_EX,
                    input        RegWrite_EX,
                    input        WR_EX,
                    input [2:0] u_b_h_w_EX,
                    input       mem_r_EX,
                    input       csr_rw_EX,
                    input       csr_w_imm_mux_EX,
                    input       mret_EX,
                    input [1:0] exp_vector_EX,

                    output reg [31:0] PCurrent_MEM,
                    output reg [31:0] IR_MEM,
                    output reg [31:0] ALUO_MEM,
                    output reg [31:0] Datao_MEM,
                    output reg [4:0]  rd_MEM,
                    output reg [4:0]  rs1_MEM,
                    output reg [31:0] rs1_data_MEM,
                    output reg        DatatoReg_MEM,
                    output reg        RegWrite_MEM,
                    output reg        WR_MEM,
                    output reg [2:0]  u_b_h_w_MEM,
                    output reg        mem_r_MEM,
                    output reg        isFlushed,
                    output reg        csr_rw_MEM,
                    output reg        csr_w_imm_mux_MEM,
                    output reg        mret_MEM,
                    output reg [1:0]  exp_vector_MEM
                );

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            IR_MEM         <= 0;
            PCurrent_MEM   <= 0;
            rd_MEM         <= 0;
            rs1_MEM        <= 0;
            RegWrite_MEM   <= 0;
            WR_MEM         <= 0;
            mem_r_MEM      <= 0;
            isFlushed      <= 0;
            csr_rw_MEM     <= 0;
            mret_MEM       <= 0;
            exp_vector_MEM <= 0;
        end
        else if(EN) begin
            if(flush) begin
                IR_MEM         <= 0;
                PCurrent_MEM   <= PCurrent_EX;
                rd_MEM         <= 0;
                rs1_MEM        <= 0;
                RegWrite_MEM   <= 0;
                WR_MEM         <= 0;
                mem_r_MEM      <= 0;
                isFlushed      <= 1;
                csr_rw_MEM     <= 0;
                mret_MEM       <= 0;
                exp_vector_MEM <= 0;
            end
            else begin
                IR_MEM            <= IR_EX;
                PCurrent_MEM      <= PCurrent_EX;
                ALUO_MEM          <= ALUO_EX;
                Datao_MEM         <= B_EX;
                DatatoReg_MEM     <= DatatoReg_EX;
                RegWrite_MEM      <= RegWrite_EX;
                WR_MEM            <= WR_EX;
                rd_MEM            <= rd_EX;
                rs1_MEM           <= rs1_EX;
                rs1_data_MEM      <= rs1_data_EX;
                u_b_h_w_MEM       <= u_b_h_w_EX;
                mem_r_MEM         <= mem_r_EX;
                isFlushed         <= 0;
                csr_rw_MEM        <= csr_rw_EX;
                csr_w_imm_mux_MEM <= csr_w_imm_mux_EX;
                mret_MEM          <= mret_EX;
                exp_vector_MEM    <= exp_vector_EX;
            end
        end
    end

endmodule
