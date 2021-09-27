// module cell (
//     input a, 
//     input b, 
//     input bin,
//     input app,
//     input qs, 
//     output reg bout, rout
// );
//     always @* begin
//         if (app)
//         begin 
//             bout = ~a&bin | ~a&b | b&bin;
//             rout = qs&(a^b^bin) | ~qs&a;
//         end
//         else 
//         begin 
//             bout = (~(a&b)&bin) | b;
//             rout = qs ? a|b^bin : a;
//         end 
//     end
// endmodule

module bout (
    output bout,
    input a, b, bin, app
);
    assign bout = app ? (~a&bin | ~a&b | b&bin) : ((~(a&b)&bin) | b);
endmodule

module rout (
    output rout,
    input a, b, bin, qs, app
);
    assign rout = app ? (qs&(a^b^bin) | ~qs&a) : (qs&(a|b^bin) | ~qs&a);
endmodule

module cascadecell (
    input [8:0]x, 
    input bin,
    input [7:0]y,
    input [7:0]app,
    output qs,
    output [7:0]rout
);
    wire i1, i2, i3, i4, i5, i6, i7, i8;
    bout mut1 (.a(x[0]), .b(y[0]), .bin(bin), .bout(i1), .app(app[0]));
    bout mut2 (.a(x[1]), .b(y[1]), .bin(i1), .bout(i2), .app(app[1]));
    bout mut3 (.a(x[2]), .b(y[2]), .bin(i2), .bout(i3), .app(app[2]));
    bout mut4 (.a(x[3]), .b(y[3]), .bin(i3), .bout(i4), .app(app[3]));
    bout mut5 (.a(x[4]), .b(y[4]), .bin(i4), .bout(i5), .app(app[4]));
    bout mut6 (.a(x[5]), .b(y[5]), .bin(i5), .bout(i6), .app(app[5]));
    bout mut7 (.a(x[6]), .b(y[6]), .bin(i6), .bout(i7), .app(app[6]));
    bout mut8 (.a(x[7]), .b(y[7]), .bin(i7), .bout(i8), .app(app[7]));
    assign qs = ~i8 | x[8];
    rout mut9 (.a(x[0]), .b(y[0]), .bin(bin), .qs(qs), .rout(rout[0]), .app(app[0]));
    rout mut10 (.a(x[1]), .b(y[1]), .bin(i1), .qs(qs), .rout(rout[1]), .app(app[1]));
    rout mut11 (.a(x[2]), .b(y[2]), .bin(i2), .qs(qs), .rout(rout[2]), .app(app[2]));
    rout mut12 (.a(x[3]), .b(y[3]), .bin(i3), .qs(qs), .rout(rout[3]), .app(app[3]));
    rout mut13 (.a(x[4]), .b(y[4]), .bin(i4), .qs(qs), .rout(rout[4]), .app(app[4]));
    rout mut14 (.a(x[5]), .b(y[5]), .bin(i5), .qs(qs), .rout(rout[5]), .app(app[5]));
    rout mut15 (.a(x[6]), .b(y[6]), .bin(i6), .qs(qs), .rout(rout[6]), .app(app[6]));
    rout mut16 (.a(x[7]), .b(y[7]), .bin(i7), .qs(qs), .rout(rout[7]), .app(app[7]));
endmodule

module array(
    input [15:0]x,
    input [7:0]y,
    input bin,
    input [7:0]app1,
    input [7:0]app2,
    input [7:0]app3,
    input [7:0]app4,
    input [7:0]app5,
    input [7:0]app6,
    input [7:0]app7,
    input [7:0]app8,
    output [7:0]q,
    output [7:0]r
);
    wire [8:0] rout1;
    cascadecell uut1 (.x(x[15:7]), .y(y), .qs(q[7]), .rout(rout1[8:1]), .bin(bin), .app(app1));
    wire [8:0] rout2;
    assign rout1[0] = x[6];
    cascadecell uut2 (.x(rout1), .y(y), .qs(q[6]), .rout(rout2[8:1]), .bin(bin), .app(app2));
    wire [8:0] rout3;
    assign rout2[0] = x[5];
    cascadecell uut3 (.x(rout2), .y(y), .qs(q[5]), .rout(rout3[8:1]), .bin(bin), .app(app3));
    wire [8:0] rout4;
    assign rout3[0] = x[4];
    cascadecell uut4 (.x(rout3), .y(y), .qs(q[4]), .rout(rout4[8:1]), .bin(bin), .app(app4));
    wire [8:0] rout5;
    assign rout4[0] = x[3];
    cascadecell uut5 (.x(rout4), .y(y), .qs(q[3]), .rout(rout5[8:1]), .bin(bin), .app(app5));
    wire [8:0] rout6;
    assign rout5[0] = x[2];
    cascadecell uut6 (.x(rout5), .y(y), .qs(q[2]), .rout(rout6[8:1]), .bin(bin), .app(app6));
    wire [8:0] rout7;
    assign rout6[0] = x[1];
    cascadecell uut7 (.x(rout6), .y(y), .qs(q[1]), .rout(rout7[8:1]), .bin(bin), .app(app7));
    assign rout7[0] = x[0];
    cascadecell uut8 (.x(rout7), .y(y), .qs(q[0]), .rout(r), .bin(bin), .app(app8));
endmodule