#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

Verilated::commandArgs(argc, argv);
// init top verilog instance
Vsinegen* top = new Vsinegen;
//init trace dump
Verilated::traceEverOn(true);
VerilatedVcdC* tfp = new VerilatedVcdC;
top->trace (tfp, 99);
tfp->open ("sinegen.vcd");

//init Vbuddy
if (vbdOpen()!=1) return(-1);
vbdHeader("SineWave");
vbdSetMode(0);

//initialize simulation inputs
top->clk = 0;
top->rst = 1;
top->en = 1;
top->incr = 1;
top->offset = 0;

//run simulation for many clock cycles 
for (i=0; i<1000000; i++){

    top->offset = vbdValue();
    
    //dump variables into VCD file and toggle clock
    for(clk=0; clk<2; clk++) {
        tfp->dump (2*i+clk);
        top->clk = !top->clk;
        top->eval ();
    }

    //++++ Send count value to Vbuddy
    vbdPlot(int(top->dout1), 0, 255);
    vbdPlot(int(top->dout2), 0, 255);
    vbdCycle(i+1);
    //---- end of Vbuddy output section

    //change input stimuli
    top->rst = (i<0) | (i == 0);
    
      // either simulation finished, or 'q' is pressed
    if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
        exit(0);                // ... exit if finish OR 'q' pressed
}

vbdClose();
tfp->close();
exit(0);
}
