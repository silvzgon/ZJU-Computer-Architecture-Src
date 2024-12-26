`timescale 1ns / 1ps

module FU_mul(
    input clk, EN,
    input[31:0] A, B,
    output[31:0] res
);

    reg[6:0] state;//用来强行延迟执行来模拟latency
    initial begin
        state = 0;
    end
    
    reg[31:0] A_reg, B_reg;
    
    always@(posedge clk) begin
        if(EN & ~|state) begin
            A_reg <= A;
            B_reg <= B;
            state <= 7'b1111111;            // TO_BE_FILLED;
        end
        else state <= {1'b0, state[6:1]};   // TO_BE_FILLED
    end
    


    wire [63:0] mulres;
    multiplier mul(.CLK(clk),.A(A_reg),.B(B_reg),.P(mulres));

    assign res = mulres[31:0];              // TO_BE_FILLED

endmodule