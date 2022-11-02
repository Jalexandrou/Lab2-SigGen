module counter #(
    parameter WIDTH = 8
)(
    //interface signals 
    input logic             clk,      //clk
    input logic             rst,      //reset 
    input logic             en,       //counter enable
    input logic  [WIDTH-1:0] incr,    //increment to count by
    output logic [WIDTH-1:0] count   //count output
);

always_ff @ (posedge clk)
    if (rst) count <= {WIDTH{1'b0}};
    else     count <= en ? count + incr : count;

endmodule
