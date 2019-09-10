`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design name: counter_top.v
// Create Date: 09/03/2019 
// Module Name: counter_top
// Created by: Ard Aunario
// Description: 8-bit directional counter
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module counter_top(
    input CLK,
    input RST,
    input EN,
    input DIR,
    output reg [7:0] CNT
    );
    
    always @(posedge CLK or negedge RST) begin
        // Check reset
        if (!RST)
            // Initialize on reset
            CNT <= 0;
        else begin
            // Check EN, If 1 then...
            if (EN) begin
                // Check Direction (0 for Up and 1 for down)
                if (DIR == 0) 
                    // Count up
                    CNT <= CNT + 1;
                 else if (DIR == 1)
                    // Count down
                    CNT <= CNT - 1;
                 else
                    // If DIR is unknown CNT stays the same
                    CNT <= CNT;                  
            end 
            // Else EN = 0, then...
            else
                // CNT stays the same
                CNT <= CNT;      
        end
    end
    
endmodule
