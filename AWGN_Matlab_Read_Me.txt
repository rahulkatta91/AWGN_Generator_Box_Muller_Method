

------------------------------------------------
To run the AWGN Matlab Model, download the AWGN_Matlab_Model folder and run the file named 'Complete_model.m'.
------------------------------------------------

The entire Matlab model for the noise generator is present in the AWGN_Matlab_Model folder which consists of 4 files:

------------------------------------------------
File to execute:
------------------------------------------------

1.Complete_model.m

This file consists of the Matlab program written to emulate the Box Muller architecture.

It generates 6 output '.dat' files and Standard deviation and Mean calculation for x0,x1. This file also generates erros plots and histograms of the URNG's and Gaussian variale x0,x1. It also has the feature to display the toolboxes used by the program. 


------------------------------------------------
Supporting Files:
------------------------------------------------

2.dec2twos.m

This file contains the program for conversion from decimal values to 2's complement form which is needed by the Complete_model.m file. This is a copyright file created by Drew Compston.

3.All_coeff.mat

The Complete_model.m file generates the coefficient values for the Sin/Cos, Sqrt and Log functions. These coefficient values are stored in this file and later used by the Complete_model.m program.

4.errors_final.mat

The RTL model takes the 6 .dat files and creates error files depicting the error in outputs from the Matlab and RTL model. These error files are stored in errors_finals.mat file. This file is used by the Complete_model.m file to generate error plots.