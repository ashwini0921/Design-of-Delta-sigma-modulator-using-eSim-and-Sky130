# Design-of-Delta-sigma-modulator-using-eSim-and-Sky130

# Abstract

Delta-sigma modulator is extensively used in digital communication to transfer data. The delay is generated using the Verilog code in Makerchip ide. Skywater 130 op-amp with other components like resistors  is configured in adder and subtractor configuration. The input sampled voltage range is 0 to 1V. A 1-bit quantizer is also designed using the Verilog code in Makerchip IDE. The Verilog code is converted to Ngspice using NgVeri.  The designed circuit is simulated in the eSim EDA tool developed by IIT Bombay. 

# Reference Circuit Diagram

![image](https://user-images.githubusercontent.com/111654188/209861030-47859167-b444-4fcd-8ad2-5c3953db1eff.png)

![image](https://user-images.githubusercontent.com/111654188/209861115-4b2b3d66-e813-4062-a871-f8d5345a3906.png)

# Circuit Details

The input quantized signal Vin is passed through analog to digital converter. The digital output is passed through ashwini_delay1bit module designed in Makerchip using Verilog code. The ashwini_delay1bit generate a delay of time T in input sampled signal. The delayed output data is passed to digital to analog converter 2 bit R-2R ladder type DAC. The DAC convert the 2 bit data to analog signal which is a delayed Vin i.e. Vin(n-T). The delayed Vin and Vin is passed through subtractor and quantizer which is obtained through the Sky130 avsd_opamp in comparator configuration. The output obtained after passing through comparator is the delta modulated output of Vin.

# Software Used

## eSim

It is an Open Source EDA developed by FOSSEE, IIT Bombay. It is used for electronic circuit simulation. It is made by the combination of two software namely NgSpice and KiCAD.
For more details refer:
https://esim.fossee.in/home

## NgSpice

It is an Open Source Software for Spice Simulations. For more details refer:
http://ngspice.sourceforge.net/docs.html

## Makerchip

It is an Online Web Browser IDE for Verilog/System-verilog/TL-Verilog Simulation. Refer
https://www.makerchip.com/

## Verilator

It is a tool which converts Verilog code to C++ objects. Refer: https://www.veripool.org/verilator/eSim

# Circuit Diagram in eSim

![image](https://user-images.githubusercontent.com/111654188/194233346-bcc6ff69-8f89-462e-bdac-a90dd2e5e3ba.png)

# Verilog Code

![image](https://user-images.githubusercontent.com/111654188/194382637-13d26ec0-9035-4d6d-95e3-740e2419f852.png)

# Makerchip

    \TLV_version 1d: tl-x.org
    \SV
    /* verilator lint_off UNUSED*/  /* verilator lint_off DECLFILENAME*/  /* verilator lint_off BLKSEQ*/  /* verilator lint_off WIDTH*/  /* verilator lint_off SELRANGE*/  /* verilator lint_off PINCONNECTEMPTY*/  /* verilator lint_off DEFPARAM*/  /* verilator lint_off IMPLICIT*/  /* verilator lint_off COMBDLY*/  /* verilator lint_off SYNCASYNCNET*/  /* verilator lint_off UNOPTFLAT */  /* verilator lint_off UNSIGNED*/  /* verilator lint_off CASEINCOMPLETE*/  /* verilator lint_off UNDRIVEN*/  /* verilator lint_off VARHIDDEN*/  /* verilator lint_off CASEX*/  /* verilator lint_off CASEOVERLAP*/  /* verilator lint_off PINMISSING*/  /* verilator lint_off BLKANDNBLK*/  /* verilator lint_off MULTIDRIVEN*/  /* verilator lint_off WIDTHCONCAT*/  /* verilator lint_off ASSIGNDLY*/  /* verilator lint_off MODDUP*/  /* verilator lint_off STMTDLY*/  /* verilator lint_off LITENDIAN*/  /* verilator lint_off INITIALDLY*/ 
    //Your Verilog/System Verilog Code Starts Here:
    module ashwini_updown_counter4bit(
     Clk,
    UpOrDown,  //Ashwini Kumar up-down counter 1 for up 0 for down
    Count
    );
    
    input Clk,UpOrDown;
    output [3 : 0] Count;
    reg [3 : 0] Count = 0; 
    
     always @(posedge(Clk))
     begin
            if(UpOrDown == 1)   //Up mode selected
                if(Count == 15)
                    Count <= 0;
                else
                    Count <= Count + 1; //Incremend Counter
            else  //Down mode selected
                if(Count == 0)
                    Count <= 15;
                else
                    Count <= Count - 1; //Decrement counter
     end       
     
    endmodule
    //Top Module Code Starts here:

	module top(input logic clk, input logic reset, input logic [31:0] cyc_cnt, output logic passed, output logic failed);
		logic  Clk;//input
		logic  UpOrDown;//input
		logic  [3 : 0] Count;//output
    //The $random() can be replaced if user wants to assign values
		assign Clk = clk;
		assign UpOrDown = 1'b0; //change it to 1'b1 for up count
		ashwini_updown_counter4bit ashwini_updown_counter4bit(.Clk(Clk), .UpOrDown(UpOrDown), .Count(Count));
    \TLV
    //Add \TLV here if desired                                     
    \SV
    endmodule




# Makerchip Plots

## Up Count

![image](https://user-images.githubusercontent.com/111654188/194245746-8f000f2a-f53b-4c1c-a4e4-2905b97647f4.png)

## Down Count

![image](https://user-images.githubusercontent.com/111654188/194245244-1b68f937-72f8-4f1d-b483-fb76f382fc15.png)

# Netlist

![image](https://user-images.githubusercontent.com/111654188/194375805-48975c66-c75e-4c05-a468-5647711157eb.png)

![image](https://user-images.githubusercontent.com/111654188/194375871-3b4f58ec-680a-4cb2-91ca-a8935960fbcf.png)

# NgSpice Plots

![image](https://user-images.githubusercontent.com/111654188/194373619-11f1ff78-a4f0-40ba-85fd-cfdbf2e01219.png)

![image](https://user-images.githubusercontent.com/111654188/194373726-78fb7ff7-21dc-4f7b-9ff5-852b59732b2f.png)

# Steps to run generate NgVeri Model


1. Open eSim
2. Run NgVeri-Makerchip
3. Add top level verilog file in Makerchip Tab
4. Click on NgVeri tab
5. Add dependency files
6. Click on Run Verilog to NgSpice Converter
7. Debug if any errors
8. Model created successfully

# Steps to run this project


1. Open a new terminal
2. Change directory:

       cd eSim-Workspace
3. Clone this project using the following command:

       git clone https://github.com/ashwini0921/Design-of-4-bit-Servo-Tracking-type-ADC.git
4. Run ngspice:

        ngspice servo_tracking_ADC1.cir.out
5. To run the project in eSim:

1)  Run eSim
2)  Load the project named servo_tracking_ADC1
3)  Open eeSchema

# Acknowlegdements

1. FOSSEE, IIT Bombay
2. Steve Hoover, Founder, Redwood EDA
3. Kunal Ghosh, Co-founder, VSD Corp. Pvt. Ltd. - kunalpghosh@gmail.com
4. Sumanto Kar, eSim Team, FOSSEE
5. Google
6. https://spoken-tutorial.org/
7. https://vlsisystemdesign.com/
8. https://www.c2s.gov.in/

# References

1. Ahmad, Nabihah & Hasan, Rezaul. (2011). A new design of XOR-XNOR gates for low power application. 10.1109/ICEDSA.2011.5959039.
2. K. Ravali, N. R. Vijay, S. Jaggavarapu and R. Sakthivel, "Low power XOR gate design and its applications," 2017 Fourth International Conference on Signal Processing, Communication and Networking (ICSCN), 2017, pp. 1-4, doi: 10.1109/ICSCN.2017.8085699.
3. https://github.com/Eyantra698Sumanto/Two-in-One-Low-power-XOR-XNOR-Gate.git
4. https://github.com/Eyantra698Sumanto/XOR-XNOR-Gate.git
5. Linear Integrated Circuit by D ROY CHOUDHURY, SHAIL BALA JAIN
