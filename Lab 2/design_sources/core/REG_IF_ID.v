`timescale 1ns / 1ps

module    REG_IF_ID(input clk,
                    input rst,
                    input EN,
                    input Data_stall,
                    input flush,
                    input [31:0] PCOUT,
                    input [31:0] IR,

                    output reg [31:0] IR_ID,
                    output reg [31:0] PCurrent_ID,
                    output reg isFlushed
                );

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            IR_ID       <= 32'h00000013;
            PCurrent_ID <= 32'h00000000;
            isFlushed   <= 0;
        end
        else if(EN)begin
            if(Data_stall)begin
                IR_ID       <= IR_ID;
                PCurrent_ID <= PCurrent_ID;
                isFlushed   <= 0;
            end
            else if(flush)begin
                IR_ID       <= 32'h00000013;
                PCurrent_ID <= PCurrent_ID;
                isFlushed   <= 1;
            end
            else begin
                IR_ID       <= IR;
                PCurrent_ID <= PCOUT;
                isFlushed   <= 0;
            end
        end
    end

endmodule
