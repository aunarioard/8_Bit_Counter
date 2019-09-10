`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2019 11:51:32 PM
// Design Name: 
// Module Name: ROM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ROM(CLK, ADDR, EN, DATA_OUT);
    //Size of ROM
    parameter ROM_WIDTH = 8;
    parameter ROM_ADDR_BITS = 8;
   
    // Ports
    input CLK;
    input EN;
    input [ROM_ADDR_BITS-1:0] ADDR;
    output reg [ROM_WIDTH-1:0] DATA_OUT;
   
    // Creating memory
    reg [ROM_WIDTH-1:0] ROM_MEM [(2**ROM_ADDR_BITS)-1:0];
    
     /* Initializing ROM */
    initial
        $readmemh("counter_LUT.mem", ROM_MEM);

    always@(posedge CLK) begin
        if (EN)
            DATA_OUT <= ROM_MEM[ADDR];
        else
            DATA_OUT <= DATA_OUT;
    end
endmodule
