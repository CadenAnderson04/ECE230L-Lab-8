module top (
    input  [15:0] sw,
    input btnL, btnU, btnD, btnR, btnC,
    output [15:0] led
);

wire [1:0]concatMux = {btnU, btnL};
wire [3:0]muxOut;

fourToOne_mux inputMux (
    .A(sw[3:0]),
    .B(sw[7:4]),
    .C(sw[11:8]),
    .D(sw[15:12]),
    .Sel(concatMux),
    .Enable(btnC),
    .Y(muxOut[3:0])
);

wire [1:0]concatDemux = {btnR, btnD};

OneToFour_deMux outputMux (
    .In(muxOut),
    .Sel(concatDemux),
    .Enable(btnC),
    .Y1(led[3:0]),
    .Y2(led[7:4]),
    .Y3(led[11:8]),
    .Y4(led[15:12])
);

endmodule

module fourToOne_mux(
    input [3:0] A, [3:0] B,[3:0] C, [3:0] D,
    input [1:0]Sel, 
    input Enable,
    output [3:0] Y
);

    assign Y = Enable ? 
              (Sel == 2'b00 ? A:
               Sel == 2'b01 ? B:
               Sel == 2'b10 ? C:
               Sel == 2'b11 ? D:
               0):0;

endmodule

module OneToFour_deMux(
    input [3:0] In, 
    input [1:0] Sel, 
    input Enable,
    output [3:0] Y1, [3:0] Y2,[3:0] Y3, [3:0] Y4
);

    assign Y1 = Enable ? (Sel == 2'b00 ? In : 0): 0;
    assign Y2 = Enable ? (Sel == 2'b01 ? In : 0): 0;
    assign Y3 = Enable ? (Sel == 2'b10 ? In : 0): 0;
    assign Y4 = Enable ? (Sel == 2'b11 ? In : 0): 0;

endmodule 

