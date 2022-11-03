module sigdelay #(
    parameter   A_WIDTH = 9,
                D_WIDTH = 8
)(
    // interface signals
    input   logic                   clk,      //clk
    input   logic                   rst,      //reset 
    input   logic                   en,       //enable
    input   logic                   wr_en,       //write enable
    input   logic                   rd_en,       //rd enable
    input   logic [A_WIDTH-1:0]     offset,     //offset for write address
    input   logic [D_WIDTH-1:0]     mic_signal,  //input data
    output  logic [D_WIDTH-1:0]     delayed_signal   // output data  
);

    logic [A_WIDTH-1:0]     wr_addr;  //interconnect wire

counter addrcounter(
    .clk (clk),
    .rst (rst),
    .en (en),
    .count (wr_addr)
);

ram2ports sineRAM (
    .clk (clk),
    .rd_addr (wr_addr),
    .wr_addr (wr_addr - offset),
    .wr_en (wr_en),
    .rd_en (rd_en),
    .din   (mic_signal),
    .dout  (delayed_signal)
);

endmodule
