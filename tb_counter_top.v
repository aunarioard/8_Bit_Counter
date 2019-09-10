`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design name: tb_counter_top.v
// Create Date: 09/03/2019 
// Module Name: tb_counter_top
// Created by: Ard Aunario
// Description: 8-bit directional counter
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define CLK_PER 5

module tb_counter_top();
    /*  Size of ROM */
    parameter ROM_WIDTH = 8;
    parameter ROM_ADDR_BITS = 8;
   
    /* ROM Ports */
    reg CLK;
    reg EN;
    reg [ROM_ADDR_BITS-1:0] ADDR;
    wire [ROM_WIDTH-1:0] DATA_OUT;
    
    /* Counter_top Ports */
    reg C_RST;
    reg C_EN;
    reg C_DIR;
    wire [7:0] C_CNT;
    integer i;
    
    /* Instantiating Counter Top - UUT */
    counter_top UUT(CLK, C_RST, C_EN, C_DIR, C_CNT);
    
    /* Instantiating ROM */
    ROM R1(CLK, ADDR, EN, DATA_OUT);
        
    /* Clock */
    initial begin
        CLK = 0;
        forever #(`CLK_PER) CLK = ~CLK;
    end
 
    /* Counter for ADDR to access memory */
    always@(negedge CLK) begin
        if (EN) begin
            if (!C_DIR) ADDR <= ADDR + 1;
            else if (C_DIR) ADDR <= ADDR - 1;
        end
        else ADDR <= ADDR;
    end
    
    /* Display the content of memory */
    initial
        $monitor("C_RST = %b, C_EN = %b, C_DIR = %b --- DATA_OUT = %h C_CNT = %h",
            C_RST,
            C_EN,
            C_DIR,
            DATA_OUT,
            C_CNT
            );
    
    /* Checking for Errors */
    always@(posedge CLK) begin
        if (C_CNT != DATA_OUT) $display("Error: C_CNT = %h DOES NOT EQUAL DATA_OUT = %h", C_CNT, DATA_OUT);
    end
    
    initial begin
        ADDR = 0; EN = 1;  // Initializing ROM counter
        C_EN = 1; C_DIR = 0; C_RST = 0;  // Count Direction UP
        #(`CLK_PER) 
        $display("Checking Up Count"); 
        C_RST = 1;
        
        // Check if Error Checking is working properly //
        #(`CLK_PER*10)  force UUT.CNT = 0;
        #(`CLK_PER) release UUT.CNT;
        
        #(`CLK_PER*10)
        ADDR = 0;
        C_DIR = 1; C_RST = 0; // Count Direction Down
        #(`CLK_PER) 
        $display("Checking Down Count"); 
        C_RST = 1;
        
        #(`CLK_PER*10) $finish;
    end
    
endmodule
