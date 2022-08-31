`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:49:41 05/16/2022
// Design Name:   Top_R_I
// Module Name:   D:/zuchengyuanli/ri/test.v
// Project Name:  ri
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top_R_I
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg rst;
	reg clk;

	// Outputs
	wire zf;
	wire of;
	wire [31:0] F;
	wire [31:0] M_R_Data;

	// Instantiate the Unit Under Test (UUT)
	Top_R_I uut (
		.rst(rst), 
		.clk(clk), 
		.zf(zf), 
		.of(of), 
		.F(F), 
		.M_R_Data(M_R_Data)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		forever
		begin #5; clk=~clk; end
	end
      
endmodule

