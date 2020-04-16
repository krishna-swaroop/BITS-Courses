module multiply_8_bit(a,q,m);
output [15:0]a;
input [7:0]q,m;
reg [15:0]a;
//reg [7:0]p;

//always @*
//begin
 //   p = 8'b00000000;
//end

//initial
//begin
//a = {p, q}; //initiating a as q
//end

integer i;

always @(q or m)
begin
a = 0;
for(i=0;i<8;i=i+1)
if( q[i] == 1'b1 ) a = a + ( m << i );
end

endmodule

module test_8bitmultiplier();

reg [0:7] q;
reg [0:7] m;
wire [0:15] a;

multiply_8_bit mul1(a,q,m);
initial
begin
$monitor("a=%b | q=%b | m=%b",a,q,m);
end
initial
begin
q=8'b00001100; m=8'b01000000;
//#3 q=8'b00010010; m=8'b01000000;
//#3 q=8'b00001100; m=8'b10000000;
end
endmodule




