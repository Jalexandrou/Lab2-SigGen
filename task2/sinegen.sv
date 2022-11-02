module sinegen #(
    parameter   A_WIDTH = 8,
                D_WIDTH = 8
)(
    // interface signals
    input   logic       clk,      //clk
    input   logic       rst,      //reset 
    input   logic       en,       //enable
    input   logic [D_WIDTH-1:0] incr,     //increment for addr counter
    input   logic [D_WIDTH-1:0] offset,     //offset for addr2 
    output  logic [D_WIDTH-1:0] dout1,  
    output  logic [D_WIDTH-1:0] dout2     // output data  
);

    logic [A_WIDTH-1:0]     addr;  //interconnect wire

counter addrcounter(
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr   (incr),
    .count (addr)
);

rom2ports sineROM (
    .clk (clk),
    .addr1 (addr),
    .addr2 (addr + offset),
    .dout1   (dout1),
    .dout2   (dout2)
);

endmodule
