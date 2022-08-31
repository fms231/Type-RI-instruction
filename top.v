`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:37:54 05/15/2022 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(clk,clk_s,rst,sw,an,seg);
	input clk,rst;
	input clk_s;
	input sw;
	reg[31:0] led;
	output[3:0] an;
	output[7:0] seg;
	wire zf,of;
	wire[31:0] F;
	wire[31:0] M_R_Data;
	Top_R_I Top_R_I0(rst,clk,clk_s,zf,of,F,M_R_Data);
	
	
	always@(*)
	begin
	case(sw)
	1'b0: led=F;
	1'b1: led=M_R_Data;
	endcase
	end
	
	show show0(rst,clk_s,led,an,seg);
endmodule

module show(clr,clk,Data,an,seg);//数码管显示模块
	input clk,clr;
	input[31:0] Data;
	output reg[3:0] an;
	output reg[7:0] seg;

	reg[2:0] BitSel = 3'b0; //选择用哪一个数码管显示
	reg[3:0] data; //数码管所需要显示的数字
	//数码管显示数字模块
	always@(*)
	begin
		case(data)
			4'b0000: seg[7:0]<=8'b00000011;
			4'b0001: seg[7:0]<=8'b10011111;
			4'b0010: seg[7:0]<=8'b00100101;
			4'b0011: seg[7:0]<=8'b00001101;
			4'b0100: seg[7:0]<=8'b10011001;
			4'b0101: seg[7:0]<=8'b01001001;
			4'b0110: seg[7:0]<=8'b01000001;
			4'b0111: seg[7:0]<=8'b00011111;
			4'b1000: seg[7:0]<=8'b00000001;
			4'b1001: seg[7:0]<=8'b00001001;
			4'b1010: seg[7:0]<=8'b00010001;
			4'b1011: seg[7:0]<=8'b11000001;
			4'b1100: seg[7:0]<=8'b01100011;
			4'b1101: seg[7:0]<=8'b10000101;
			4'b1110: seg[7:0]<=8'b01100001;
			4'b1111: seg[7:0]<=8'b01110001;
		endcase
	end
	
	always@( posedge clk)
		begin
				begin
							BitSel <= BitSel + 1'b1;
							case(BitSel)
							3'b000: 
							begin 
								an<=4'b1111;
								if(clr) data <= 4'b1010;
								else data<=Data[3:0];
							end
							3'b001: 
							begin
								an<=4'b1110;							
								if(clr) data <= 4'b1010;
								else data<=Data[7:4];
							end
							3'b010: 
							begin
								an<=4'b1101;
								if(clr) data <= 4'b1010;
								else data<=Data[11:8];
							end
							3'b011: 
							begin
								an<=4'b1100;
								if(clr) data <= 4'b1010;
								else data<=Data[15:12];								
							end							
							3'b100:
							begin
								an<=4'b1011;
								if(clr) data <= 4'b1010;
								else data<=Data[19:16];
							end
							3'b101:
							begin
								an<=4'b1010;
								if(clr) data <= 4'b1010;
								else data<=Data[23:20];
							end
							3'b110:
							begin
								an<=4'b1001;
								if(clr) data <= 4'b1010;
								else data<=Data[27:24];
							end
							3'b111:
							begin
								an<=4'b1000;
								if(clr) data <= 4'b1010;
								else data<=Data[31:28];
							end
						endcase		
				end
		end
endmodule

module Top_R_I(input rst,input clk,input clkm,output zf,output of,output[31:0] F,output[31:0] M_R_Data);
	wire Write_Reg;
	wire[31:0] instcode;
	wire[4:0] rs;
	wire[4:0] rt;
	wire[4:0] rd;
	wire[31:0] rs_data;
	wire[31:0] rt_data;
	wire[31:0] rd_data;
	wire[31:0] imm_data;
	wire[15:0] imm;
	wire rd_rt_s;
	wire imm_s;
	wire alu_mem_s;
	wire rt_imm_s;
	wire Mem_Write;
	wire[4:0] W_Addr;
	wire[31:0] W_Data;
	wire[31:0] R_Data_A;
	wire[31:0] R_Data_B;
	wire[2:0] ALU_OP;
	wire[31:0] ALU_B;
	
	pc pc0(clk,rst,instcode);
	OP_Decoding OP_Decoding(instcode,ALU_OP,rs,rt,rd,Write_Reg,imm,rd_rt_s,imm_s,rt_imm_s,Mem_Write,alu_mem_s);
	assign W_Addr=(rd_rt_s)?rt:rd;
	assign imm_data=(imm_s)?{{16{imm[15]}},imm}:{16'b0,imm};
	Register_file Register_file0(rs,rt,W_Addr,Write_Reg,W_Data,clk,rst,R_Data_A,R_Data_B);
	assign ALU_B=(rt_imm_s)?imm_data:R_Data_B;
	ALU ALU0(R_Data_A,ALU_B,F,ALU_OP,zf,of);
	
	
	RAM_B your_instance_name (
  .clka(clkm), // input clka
  .wea(Mem_Write), // input [0 : 0] wea
  .addra(F[5:0]), // input [5 : 0] addra
  .dina(R_Data_B), // input [31 : 0] dina
  .douta(M_R_Data) // output [31 : 0] douta
);
	
	assign W_Data=(alu_mem_s)?M_R_Data:F;
endmodule

module pc(input clk,input rst,output[31:0] instcode);
	reg[31:0] pc;
	initial pc<=32'b0;
	wire[31:0] pc_new;
	
	Inst_code your_instance_name (
  .clka(clk), // input clka
  .addra(pc[7:2]), // input [5 : 0] addra
  .douta(instcode) // output [31 : 0] douta
);
	assign pc_new = pc+4;
	always@(negedge clk or posedge rst)
	begin
		if(rst)
			pc=32'b0;
		else
			pc={24'h000000,pc_new[7:0]};
	end
endmodule

module OP_Decoding(instcode,ALU_OP,rs,rt,rd,Write_Reg,imm,rd_rt_s,imm_s,rt_imm_s,Mem_Write,alu_mem_s);
	input[31:0] instcode;
	output reg[2:0] ALU_OP;
	output reg[4:0] rs;
	output reg[4:0] rt;
	output reg[4:0] rd;
	output reg Write_Reg;
	output reg[15:0] imm;
	output reg rd_rt_s;
	output reg imm_s;
	output reg rt_imm_s;	
	output reg Mem_Write;
	output reg alu_mem_s;

	always@(*)
	begin
		//R
		if(instcode[31:26]==6'b000000)
		begin
			rd=instcode[15:11];
			rt=instcode[20:16];
			rs=instcode[25:21];
			alu_mem_s=0;
			Mem_Write=0;
			rd_rt_s=0;
			rt_imm_s=0;
			Write_Reg=(instcode[5:0]==0)?1'b0:1'b1;
			case(instcode[5:0])
			6'b100000:ALU_OP=3'b100;
			6'b100010:ALU_OP=3'b101;
			6'b100100:ALU_OP=3'b000;
			6'b100101:ALU_OP=3'b001;
			6'b100110:ALU_OP=3'b010;
			6'b100111:ALU_OP=3'b011;
			6'b101011:ALU_OP=3'b110;
			6'b000100:ALU_OP=3'b111;
			endcase
		end
		//I型立即数
		if(instcode[31:29]==3'b001)
		begin
			imm=instcode[15:0];
			rt=instcode[20:16];
			rs=instcode[25:21];
			Mem_Write=0;
			rd_rt_s=1;
			rt_imm_s=1;
			alu_mem_s=0;
			Write_Reg=1;
			case(instcode[31:26])
			6'b001000:begin imm_s=1;ALU_OP=3'b100;end
			6'b001100:begin imm_s=0;ALU_OP=3'b000;end
			6'b001110:begin imm_s=0;ALU_OP=3'b010;end
			6'b001011:begin imm_s=0;ALU_OP=3'b110;end
			endcase
		end
		//I型取数/存数
		if((instcode[31:30]==2'b10)&&(instcode[28:26]==3'b011))
		begin
			imm=instcode[15:0];
			rt=instcode[20:16];
			rs=instcode[25:21];
			rd_rt_s=1;
			rt_imm_s=1;
			imm_s=1;
			case(instcode[31:26])
			6'b100011:begin alu_mem_s=1;Mem_Write=0;Write_Reg=1;ALU_OP=3'b100;end
			6'b101011:begin Mem_Write=1;Write_Reg=0;ALU_OP=3'b100;end
			endcase
		end
	end
endmodule

module Register_file(R_Addr_A,R_Addr_B,W_Addr,Write_Reg,W_Data,clk,rst,R_Data_A,R_Data_B);
	input[4:0] R_Addr_A;
	input[4:0] R_Addr_B;
	input[4:0] W_Addr;
	input Write_Reg;
	input[31:0] W_Data;
	input clk;
	input rst;
	output[31:0] R_Data_A;
	output[31:0] R_Data_B;
	reg[31:0] REG_file[0:31];
	reg[5:0] i;
	initial
	begin
	for(i=0;i<=31;i=i+1)
		REG_file[i]=32'b0;
	end
	
	assign R_Data_A=REG_file[R_Addr_A];
	assign R_Data_B=REG_file[R_Addr_B];
	always@(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			for(i=0;i<=31;i=i+1)
				REG_file[i]=32'b0;
		end
		else
			if(Write_Reg&&W_Addr!=0)
				REG_file[W_Addr]=W_Data;
	end
endmodule

module ALU(A,B,F,ALU_OP,zf,of);
	input[31:0] A;
	input[31:0] B;
	input[2:0] ALU_OP;
	output reg zf,of;
	output reg[31:0] F;
	reg C32;
	always@(*)
	begin
		of=1'b0;
		C32=1'b0;
		case(ALU_OP)
		3'b000:F=A&B;
		3'b001:F=A|B;
		3'b010:F=A^B;
		3'b011:F=~(A^B);
		3'b100:begin {C32,F}=A+B; of=A[31]^B[31]^F[31]^C32; end
		3'b101:begin {C32,F}=A-B; of=A[31]^B[31]^F[31]^C32; end
		3'b110:F=(A<B);
		3'b111:F=B<<A;
		endcase
		if(F==0)
			zf=1;
		else
			zf=0;
	end
endmodule

