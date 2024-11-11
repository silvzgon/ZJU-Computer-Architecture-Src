`timescale 1ns / 1ps

module   REG_MEM_WB(input        clk,
                    input        rst,
                    input        EN,
                    input [31:0] IR_MEM,
                    input [31:0] PCurrent_MEM,
                    input [31:0] ALUO_MEM,
                    input [31:0] Datai,
                    input [4:0]  rd_MEM,
                    input        DatatoReg_MEM,
                    input        RegWrite_MEM,
                    input        flush,
                    input [3:0]  exp_vector_MEM,
                    input        mret_MEM,
                    output reg [31:0] PCurrent_WB,
                    output reg [31:0] IR_WB,
                    output reg [31:0] ALUO_WB,
                    output reg [31:0] MDR_WB,
                    output reg [4:0]  rd_WB,
                    output reg        DatatoReg_WB,
                    output reg        RegWrite_WB,
                    output reg        isFlushed,
                    output reg [3:0]  exp_vector_WB,
                    output reg        mret_WB
                );

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            rd_WB         <= 0;
            RegWrite_WB   <= 0;
            IR_WB         <= 0;
            PCurrent_WB   <= 0;
            isFlushed     <= 0;
            exp_vector_WB <= 0;
            mret_WB       <= 0;
        end
      else if(EN) begin
            if(flush) begin
                IR_WB         <= 0;
                PCurrent_WB   <= PCurrent_MEM;  
                rd_WB         <= 0;
                RegWrite_WB   <= 0;
                isFlushed     <= 1;
                exp_vector_WB <= 0;
                mret_WB       <= 0;
            end
            else begin
                IR_WB         <= IR_MEM;
                PCurrent_WB   <= PCurrent_MEM;
                ALUO_WB       <= ALUO_MEM;
                MDR_WB        <= Datai;
                rd_WB         <= rd_MEM;
                RegWrite_WB   <= RegWrite_MEM;
                DatatoReg_WB  <= DatatoReg_MEM;
                isFlushed     <= 0;
                exp_vector_WB <= exp_vector_MEM;
                mret_WB       <= mret_MEM;
            end
        end
    end
  
endmodule
