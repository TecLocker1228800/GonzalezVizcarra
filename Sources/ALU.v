/******************************************************************
* Description
*	This is an 32-bit arithetic logic unit that can execute the next set of operations:
*		add
*		sub
*		or
*		and
*		nor
* This ALU is written by using behavioral description.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/

module ALU 
(
	input [3:0] ALUOperation,
	input [31:0] A,
	input [31:0] B,
	input [4:0] shamt,//
	output reg Zero,
	output reg [31:0]ALUResult
);

localparam AND = 4'b0000;
localparam OR  = 4'b0001;
localparam NOR = 4'b0010;
localparam ADD = 4'b0011;
localparam SUB = 4'b0100;
localparam SLL = 4'b0101;
localparam SRL = 4'b0110;
localparam LUI = 4'b0111;
localparam BEQ = 4'b1000;
localparam BNE = 4'b1001;
   
   always @ (A or B or ALUOperation)
     begin
		case (ALUOperation)
		  AND: // and
		   ALUResult=A & B;
		  OR: // or
			ALUResult=A | B;
		  NOR: // nor
			ALUResult= ~(A|B);
		  ADD: // add
			ALUResult=A + B;
		  SUB: // sub
			ALUResult=A - B;
		  SLL: //sll
		   ALUResult = A << shamt;
		  SRL: //srl
		   ALUResult = A >> shamt;
		  LUI: //lui
		   ALUResult = {B[15:0],16'b0};
		  BEQ:
			ALUResult= (A == B) ? 1'b0 : 1'b1;
		  BNE:
			ALUResult= (A != B) ? 1'b0 : 1'b1;

		default:
			ALUResult= 0;
		endcase // case(control)
		Zero = (ALUResult==0) ? 1'b1 : 1'b0;
     end // always @ (A or B or control)
endmodule // ALU