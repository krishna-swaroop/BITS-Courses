 /* Verilog Code for Partial fulfillment of ADVD course
    Code for Serial Adder using JK Flip-Flop
    The circuit contains the following components- two shift registers(defined as srA and srB), One JK Flip-Flop, two AND Gates (defined as AND1 and AND2), one XOR gate(XOR1), one NOR gate(NOR1),
    The code defines each component to be a module.*/
 
 
 // Let's start off with defining the bigger blackbox (ie; the final Serial Adder using JK FLip Flops)
 
 module SerialAdderJK(SIa, SIb, sftCtrl, clk, clr, O2I)           /*SIx is serial input of Shift register X. sftCtrl is shift control. clk-clock. clr-clear. O2I is the output wire going to srA to store the result in srA thus saving one register. */
	input SIa;
	input SIb;
	input clk;
	input sftCtrl;                                                //sftCtrl is an active low signal
	input clr;                                                    //clr is an active high signal
	output Y;                        
	wire c,J,K,x,y,O2I,Q
	sr 1(O2I, clk, sftCtrl,x);
	sr 2(SIb, clk, sftCtrl,y);
	AND 1(clk, sftCtrl, c)
	AND 2(x, y, J);
	NOR 1(x, y, K);
	XOR 1(x, y, Q, O2I);
	JKFF 1(J, C, K, Q);
endmodule

/* The above code defines the connections between the various "blackboxes" in the circuit.
   The following code defines each of the blackboxes used.*/


/* Defining Serial Register
   The parameter N will decide the size of the shfit register*/
#(parameter N=8)
module sr(SI, clk, sftCtrl, clr, SO);
	input SI;
	input clk;
	input sftCtrl;
	input clr;
	output SO;
	
	reg[N-1:0] r_reg;
	wire [N-1:0] r_next;
	always @(posedge clk, posedge clr, sftCtrl=1)
	begin
		if(clr || sftCtrl=0)
			r_reg <= 0;
		else
			r_reg <= r_next;
	end 
		assign r_next = {SI, r_reg[N-1:1]};
		assign SO = r_reg[0];
endmodule



// Defining JK Flip-Flop

module jkff(j,k,clr,clk,qp);
    input j;
	input k;
    input clr,clk;
    output qp;
    reg qp;    wire q;
	reg [1:0] jk;
	jk[0]=k;
	jk[1]=j;
    always @ (posedge clk)
     begin
		if (clr)	
		  qp= 0;
		else
		   begin
		   case (jk)
		      2'b00: qp=q;
			  2'b01 : qp = 1'b0;
			  2'b10  : qp =1'b1;
			  2'b11 : qp = ~q;
			  default qp =0;
			endcase
			end
		end
	 assign q = qp;
endmodule


// Defining AND Gate

module AND(a,b,c);
    input a;
    input b;
    output c;
    assign c = a & b;
endmodule

// Defining NOR Gate
module NOR(a,b,f);
    input a;
    input b;
    output f;
    assign f = ~(a | b);
endmodule


// Defining XOR Gate
module XOR(a,b,c,h);
    input a;
    input b;
	input c;
    output h;
    assign h = a ^ b ^ c;
endmodule




		
			
    
