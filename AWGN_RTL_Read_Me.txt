

------------------------------------------------
To run the AWGN RTL Model, download the AWGN_Box_Muller_RTL_Model folder and open the project 'AWGN_Box_Muller_RTL_Model.mpf'.
------------------------------------------------


The entire RTL model for the noise generator is present in the AWGN_Box_Muller_RTL_Model folder which consists of the following files:


1.AWGN_Box_Muller_RTL_Model.mpf

This is the project file which opens in ModelSim. To simulate the design, the testbench file 'AWGN_testbench.v' must be run.

The AWGN_testbench.v file generates 12 new '.txt' files. These files include the output results from the RTL model and Error files which depicts the error between the outputs from the Matlab and RTL model.


2.Verilog files

There are a total of 11 verilog files which depicts the RTL design and testbench needed for simulation.


3.Text files

There are a total of 6 '.txt' files with the output values from the Matlab model. These files are needed for automated verification of output results from both the Matlab and RTL model.


4.Folder - 'work'

The work folder consists of the library files used by ModelSim.