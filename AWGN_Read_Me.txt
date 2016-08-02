This file gives a brief description of the procedure to run the Matlab and RTL models of the AWGN generator.

------------------------------------------------
------------------------------------------------

Matlab_model:
------------------------------------------------
1. To run the Matlab model, copy the contents of the AWGN_Matlab_Model folder (consists of 3 matlab files).

2. Firstly, run the 'Coeff_generation.m' file to generate the coefficients needed for the Sin/Cos, Square Root and Log units. Running this file generates another file 'All_coeff.mat' which consists of all the coefficients.

3. Next, run the 'Complete_model.m' file. This file consists the logic for the Taus's algorithm and Box Muller Architecture. The histograms of the results is generated and can be observed. Also, the Mean and Standard deviation is calculated and can be observed in the Matlab Command Window.

This file also generates output files - awgn_matlab_x0.txt and awgn_matlab_x1.txt which is later used by the RTL model for verification purposes.
----------------------------------------------
----------------------------------------------
RTL Model:
----------------------------------------------
1. To run the RTL model in Vivado Design Suite, create a new project with the 20 verilog files in the AWGN_Box_Muller_RTL_Model folder as 'Design Sources'.

2. Next, add the 2 files generated from the Matlab Model under 'Simulation Sources'.

3. Now, the testbench file written must be deselected for synthesis and implementation and only selected for simulation (this ensures the testbench is only a simulation source file).

4. Next, run the simulation and the waveforms can be viewed in the Simulator window.

Synthesis can be performed and the synthesis report can be viewed for a deeper understanding of the model.

5. Simulation generates 2 new files with consists of the comparision results of the outputs of the RTL and Matlab models. These files will be generated in the 'project.sim' directory under the behav folder.