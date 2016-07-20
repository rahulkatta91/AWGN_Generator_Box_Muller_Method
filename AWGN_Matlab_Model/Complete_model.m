%This file consists of the Matlab program written to emulate the Box Muller architecture.

%It generates 6 output '.dat' files and Standard deviation and Mean calculation for x0,x1. 
%This file also generates erros plots and histograms of the URNG's and Gaussian variale x0,x1. 
%It also has the feature to give the toolboxes used by the program. 




%% Sin/Cos coefficients generation
inter = linspace(0,1,129); % Generating constant interval array
fun_out = sin(inter*pi/2); % Input to Sin
syms c1 c0 % Creating syms object for equation solver
% Solving Quadratic equation
for i = 1: size(inter,2)-1;
    S = solve([c1*inter(1,i)+c0 == fun_out(1,i),c1*inter(1,i+1)+c0 == fun_out(1,i+1)],[c0,c1]);
    % Extracting Coefficient values and transforming them to suit x_g_a_B, x_g_b_B as input
    coeff(i,1) = i*double(S.c1)+double(S.c0);
    coeff(i,2) = double(S.c1)./128;
end

% c0 =12 bit,c1 = 19 bit ------------>sin/cos

% m,n are for equation which converts Signed fraction to  binary and vice versa
m_bit_size = [12,19];
n = 1;         % number bits for integer part of your number      
sin_cos_bin_un1 = [];
sin_cos_bin_un2 = [];


    m1 = m_bit_size(1)-n-1;         % number bits for fraction part of your number
    m2 = m_bit_size(2)-n-1;         % number bits for fraction part of your number
    
    m1_comp = zeros(1,m_bit_size(1));
    m2_comp = zeros(1,m_bit_size(2));
        
    m1_comp(1,m_bit_size(1)) = 1;   % creating a Matrix with right end bit one and rest all zeros
    m2_comp(1,m_bit_size(2)) = 1;
    
    
    for j= 1: size(coeff,1)
       % Converting decimal to binary of a signed fraction 
       d2b1 =  fix(rem(abs(coeff(j,1))*pow2(-(n-1):m1),2));
       d2b2 =  fix(rem(abs(coeff(j,2))*pow2(-(n-1):m2),2));
       
       d2b1 = [0,d2b1];
       d2b2 = [0,d2b2];
       
       % Performing twos complement representation for negative integers
       if coeff(j,1)<0
           d2b1 = not(d2b1);
           temp1 = bin2dec(strjoin(cellstr(num2str(d2b1'))',''));
           temp2 = bin2dec(strjoin(cellstr(num2str(m1_comp'))',''));
           temp3 = temp1+temp2;
           d2b1 =  fix(rem(temp3*pow2(-(m_bit_size(1)-1):0),2));           
       end
       % Performing twos complement and checking whether its negative
       if coeff(j,2)<0
           d2b2 = not(d2b2);
           temp1 = bin2dec(strjoin(cellstr(num2str(d2b2'))',''));
           temp2 = bin2dec(strjoin(cellstr(num2str(m2_comp'))',''));
           temp3 = temp1+temp2;
           d2b2 =  fix(rem(temp3*pow2(-(m_bit_size(2)-1):0),2));           
       end
       % Sin_Cos Coeffs in String cell array format
       sin_cos_coeffs{j,1} =  strjoin(cellstr(num2str(d2b1'))','');
       sin_cos_coeffs{j,2} =  strjoin(cellstr(num2str(d2b2'))','');
       % Sin_Cos coeff in binary matrix format binary
       sin_cos_bin_un1 = [sin_cos_bin_un1;d2b1];
       sin_cos_bin_un2 = [sin_cos_bin_un2;d2b2];
       % Sin_Cos coeff for exporting to RTL Code
       sin_save{j,1} = cellstr(strcat(sin_cos_coeffs{j,2},'_',sin_cos_coeffs{j,1}));
    end
% Clearing Unnecessary variables
clearvars -except sin_cos_coeffs sin_save

%% Log coefficients generation
inter = linspace(1,2,258); % Generating constant interval array
fun_out = -log(inter); % Input to log
syms c2 c1 c0
for i = 1: size(inter,2)-2;
    S = solve([c2*inter(1,i)^2+c1*inter(1,i)+c0 == fun_out(1,i),c2*inter(1,i+1)^2+c1*inter(1,i+1)+c0 == fun_out(1,i+1),c2*inter(1,i+2)^2+c1*inter(1,i+2)+c0 == fun_out(1,i+2)],[c0,c1,c2]);
    coeff(i,1) = double(S.c0);
    coeff(i,2) = double(S.c1);
    coeff(i,3) = double(S.c2);
    % Extracting Coefficient values and transforming them to suit x_e_B as input
    coeff(i,1) = (double(S.c2).*i^2)+(double(S.c1).*i)+double(S.c0);
    coeff(i,2) = ((double(S.c2).*i)./128)+(double(S.c1)./256);
    coeff(i,3) = double(S.c2)./65536;
    
end

% log----> coeff
% c0 =30 bit,c1 = 22 bit, c2 =13
m_bit_size = [30,22,13];
n = 1;         % Number bits for integer part of your number      
log_bin_un1 = [];
log_bin_un2 = [];
log_bin_un3 = [];

    m1 = m_bit_size(1)-n-1;         % Number bits for fraction part of your number
    m2 = m_bit_size(2)-n-1;
    m3 = m_bit_size(3)-n-1;
    m1_comp = zeros(1,m_bit_size(1));
    m2_comp = zeros(1,m_bit_size(2));
    m3_comp = zeros(1,m_bit_size(3));
    
    m1_comp(1,m_bit_size(1)) = 1;
    m2_comp(1,m_bit_size(2)) = 1;
    m3_comp(1,m_bit_size(3)) = 1;
    
    for j= 1: size(coeff,1)
       d2b1 =  fix(rem(abs(coeff(j,1))*pow2(-(n-1):m1),2));
       d2b2 =  fix(rem(abs(coeff(j,2))*pow2(-(n-1):m2),2));
       d2b3 =  fix(rem(abs(coeff(j,3))*pow2(-(n-1):m3),2));
       d2b1 = [0,d2b1];
       d2b2 = [0,d2b2];
       d2b3 = [0,d2b3];
       
       if coeff(j,1)<0
           d2b1 = not(d2b1);
           temp1 = bin2dec(strjoin(cellstr(num2str(d2b1'))',''));
           temp2 = bin2dec(strjoin(cellstr(num2str(m1_comp'))',''));
           temp3 = temp1+temp2;
           d2b1 =  fix(rem(temp3*pow2(-(m_bit_size(1)-1):0),2));           
       end
       
       if coeff(j,2)<0
           d2b2 = not(d2b2);
           temp1 = bin2dec(strjoin(cellstr(num2str(d2b2'))',''));
           temp2 = bin2dec(strjoin(cellstr(num2str(m2_comp'))',''));
           temp3 = temp1+temp2;
           d2b2 =  fix(rem(temp3*pow2(-(m_bit_size(2)-1):0),2));           
       end
       
       if coeff(j,3)<0
           d2b3 = not(d2b3);
           temp1 = bin2dec(strjoin(cellstr(num2str(d2b3'))',''));
           temp2 = bin2dec(strjoin(cellstr(num2str(m3_comp'))',''));
           temp3 = temp1+temp2;
           d2b3 =  fix(rem(temp3*pow2(-(m_bit_size(3)-1):0),2));           
       end
       % String
       log_coeff{j,1} =  strjoin(cellstr(num2str(d2b1'))','');
       log_coeff{j,2} =  strjoin(cellstr(num2str(d2b2'))','');
       log_coeff{j,3} =  strjoin(cellstr(num2str(d2b3'))','');
       
       % Binary
       log_bin_un1 = [log_bin_un1;d2b1];
       log_bin_un2 = [log_bin_un2;d2b2];
       log_bin_un3 = [log_bin_un3;d2b3];
       
       log_save{j,1} = cellstr(strcat(log_coeff{j,3},'_',log_coeff{j,2},'_',log_coeff{j,1}));
    end

    clearvars -except sin_cos_coeffs sin_save log_coeff log_save
%% Sqrt1 coefficients generation
inter = linspace(2,4,65);
fun_out = sqrt(inter); %Input to Sqrt1 function
syms c1 c0
for i = 1: size(inter,2)-1;
    S = solve([c1*inter(1,i)+c0 == fun_out(1,i),c1*inter(1,i+1)+c0 == fun_out(1,i+1)],[c0,c1]);
    % Extracting Coefficient values and transforming them to suit x_f_B as input
    coeff(i,1) = i*double(S.c1)+double(S.c0);
    coeff(i,2) = double(S.c1)./128;
end

% cos/sin /sqrt----> coeff
% c0 =12 bit,c1 = 20 bit ------------>sqrt1
% c0 =12 bit,c1 = 20 bit ------------>sqrt2

m_bit_size = [12,20];
n = 1;         % Number bits for integer part of your number      
sqrt1_bin_un1 = [];
sqrt1_bin_un2 = [];

    m1 = m_bit_size(1)-n-1;         % Number bits for fraction part of your number
    m2 = m_bit_size(2)-n-1;
    
    m1_comp = zeros(1,m_bit_size(1));
    m2_comp = zeros(1,m_bit_size(2));
        
    m1_comp(1,m_bit_size(1)) = 1;
    m2_comp(1,m_bit_size(2)) = 1;
    
    
    for j= 1: size(coeff,1)
       d2b1 =  fix(rem(abs(coeff(j,1))*pow2(-(n-1):m1),2));
       d2b2 =  fix(rem(abs(coeff(j,2))*pow2(-(n-1):m2),2));
       
       d2b1 = [0,d2b1];
       d2b2 = [0,d2b2];
       
       
       if coeff(j,1)<0
           d2b1 = not(d2b1);
           temp1 = bin2dec(strjoin(cellstr(num2str(d2b1'))',''));
           temp2 = bin2dec(strjoin(cellstr(num2str(m1_comp'))',''));
           temp3 = temp1+temp2;
           d2b1 =  fix(rem(temp3*pow2(-(m_bit_size(1)-1):0),2));           
       end
       
       if coeff(j,2)<0
           d2b2 = not(d2b2);
           temp1 = bin2dec(strjoin(cellstr(num2str(d2b2'))',''));
           temp2 = bin2dec(strjoin(cellstr(num2str(m2_comp'))',''));
           temp3 = temp1+temp2;
           d2b2 =  fix(rem(temp3*pow2(-(m_bit_size(2)-1):0),2));           
       end
       % String
       sqrt1_coeff{j,1} =  strjoin(cellstr(num2str(d2b1'))','');
       sqrt1_coeff{j,2} =  strjoin(cellstr(num2str(d2b2'))','');
       
       % Binary
       sqrt1_bin_un1 = [sqrt1_bin_un1;d2b1];
       sqrt1_bin_un2 = [sqrt1_bin_un2;d2b2];
       
       sqrt1_save{j,1} = cellstr(strcat(num2str(j-1),' : data = 42','"','b',sqrt1_coeff{j,2},'_',sqrt1_coeff{j,1}));       
       
    end
    clearvars -except sin_cos_coeffs sin_save log_coeff log_save sqrt1_coeff sqrt1_save

%% Sqrt 2 coefficients generation
inter = linspace(1,2,65);
fun_out = sqrt(inter);%Input to Sqrt2 function
syms c1 c0
for i = 1: size(inter,2)-1;
    S = solve([c1*inter(1,i)+c0 == fun_out(1,i),c1*inter(1,i+1)+c0 == fun_out(1,i+1)],[c0,c1]);
    % Extracting Coefficient values and transforming them to suit x_f_B as input
    coeff(i,1) = i*double(S.c1)+double(S.c0);
    coeff(i,2) = double(S.c1)./128;
end

% cos/sin /sqrt----> coeff
% c0 =12 bit,c1 = 20 bit ------------>sqrt2

m_bit_size = [12,20];
n = 1;         % Number bits for integer part of your number      
sqrt2_bin_un1 = [];
sqrt2_bin_un2 = [];

    m1 = m_bit_size(1)-n-1;         % Number bits for fraction part of your number
    m2 = m_bit_size(2)-n-1;
    
    m1_comp = zeros(1,m_bit_size(1));
    m2_comp = zeros(1,m_bit_size(2));
        
    m1_comp(1,m_bit_size(1)) = 1;
    m2_comp(1,m_bit_size(2)) = 1;
    
    
    for j= 1: size(coeff,1)
       d2b1 =  fix(rem(abs(coeff(j,1))*pow2(-(n-1):m1),2));
       d2b2 =  fix(rem(abs(coeff(j,2))*pow2(-(n-1):m2),2));
       
       d2b1 = [0,d2b1];
       d2b2 = [0,d2b2];
       
       
       if coeff(j,1)<0
           d2b1 = not(d2b1);
           temp1 = bin2dec(strjoin(cellstr(num2str(d2b1'))',''));
           temp2 = bin2dec(strjoin(cellstr(num2str(m1_comp'))',''));
           temp3 = temp1+temp2;
           d2b1 =  fix(rem(temp3*pow2(-(m_bit_size(1)-1):0),2));           
       end
       
       if coeff(j,2)<0
           d2b2 = not(d2b2);
           temp1 = bin2dec(strjoin(cellstr(num2str(d2b2'))',''));
           temp2 = bin2dec(strjoin(cellstr(num2str(m2_comp'))',''));
           temp3 = temp1+temp2;
           d2b2 =  fix(rem(temp3*pow2(-(m_bit_size(2)-1):0),2));           
       end
       % String
       sqrt2_coeff{j,1} =  strjoin(cellstr(num2str(d2b1'))','');
       sqrt2_coeff{j,2} =  strjoin(cellstr(num2str(d2b2'))','');
       
       % Binary
       sqrt2_bin_un1 = [sqrt2_bin_un1;d2b1];
       sqrt2_bin_un2 = [sqrt2_bin_un2;d2b2];
       
       sqrt2_save{j,1} = cellstr(strcat(num2str(j-1),' : data = 42''b',sqrt2_coeff{j,2},'_',sqrt2_coeff{j,1})); 
    end
 clearvars -except sin_cos_coeffs sin_save log_coeff log_save sqrt1_coeff sqrt1_save sqrt2_coeff sqrt2_save
 %% Random noise generation using Taus Algorithm 
clear all; close all;clc;
% Input seeds to the Taus Algorithm, same seed values given to verilog code
s_0=uint32(hex2dec('ffffffff'));
s_1=uint32(hex2dec('fdfdfdfd'));
s_2=uint32(hex2dec('efefefef'));
s_3=uint32(hex2dec('fedafeda'));
s_4=uint32(hex2dec('fffafffa'));
s_5=uint32(hex2dec('fdeafdea'));

for i = 1:10000
    %Taus algorithm
    b       = bitshift(bitxor(bitshift(s_0,13,'uint32'),s_0),-19,'uint32');
    s_0     = bitxor(bitshift(bitand(s_0,hex2dec('fffffffe')),12),b,'uint32');
    b       = bitshift(bitxor(bitshift(s_1,2),s_1),-25,'uint32');
    s_1     = bitxor(bitshift(bitand(s_1,hex2dec('fffffff8')),4),b,'uint32');
    b       = bitshift(bitxor(bitshift(s_2,3),s_2),-11,'uint32');
    s_2     = bitxor(bitshift(bitand(s_2,hex2dec('fffffff0')),17),b,'uint32');
    b       = bitshift(bitxor(bitshift(s_3,13,'uint32'),s_3),-19,'uint32');
    s_3     = bitxor(bitshift(bitand(s_3,hex2dec('fffffffe')),12),b,'uint32');
    b       = bitshift(bitxor(bitshift(s_4,2),s_4),-25,'uint32');
    s_4     = bitxor(bitshift(bitand(s_4,hex2dec('fffffff8')),4),b,'uint32');
    b       = bitshift(bitxor(bitshift(s_5,3),s_5),-11,'uint32');
    s_5     = bitxor(bitshift(bitand(s_5,hex2dec('fffffff0')),17),b,'uint32');
    temp_1  = bitxor(s_0,s_1);
    rand_1(i,1)= bitxor(temp_1,s_2);
    temp_2  = bitxor(s_3,s_4);
    rand_2(i,1)    = bitxor(temp_2,s_5);
end

%Histogram plot of random variable generated by Taus algorithm ---->u0
rand_plots = double(rand_1);
figure;
hist(rand_plots,30)

title('Uniform Distribution Random Noise Generator 0');
xlabel('bins');
ylabel('Count');

%Histogram plot of random variable generated by Taus algorithm ---->u1
rand_plots = double(rand_2);
figure;
hist(rand_plots,30)

title('Uniform Distribution Random Noise Generator 1');
xlabel('bins');
ylabel('Count');

% Decimal to binary string conversion of u0, u1
for i =1:length(rand_1)
    unrg_1{i,1} = cellstr(dec2bin(rand_1(i,1),32));
    unrg_2{i,1} = cellstr(dec2bin(rand_2(i,1),32));
    
    temp_1 = char(unrg_1{i,1});  
    u_1{i,1} = cellstr((temp_1(1:16)));
    u_0{i,1} = cellstr(strcat(char(unrg_2{i,1}),temp_1(17:32)));
end
clearvars -except u_1 u_0;
clearvars -except u_1 u_0;

%% Sin Cos Function Unit
load('All_coeff.mat'); %Loading coefficient values
for i= 1: length(u_1)
    %range reduction
    temp_1 = char(u_1{i,1});
    quad{i,1} = cellstr((temp_1(1:2))); %Quadrant selection
    x_g_a{i,1} = cellstr((temp_1(3:16))); %Table index value for Sin coefficients
    x_g_b{i,1} = dec2bin(bin2dec('11111111111111')-bin2dec(char(x_g_a{i,1})),14); %Table index value for Cos coefficients
    temp2 = char(x_g_a{i,1});
    temp3 = char(x_g_b{i,1});
    x_g_a_A{i,1} = cellstr(temp2(1:7)); %Table index value for Sin coefficients
    x_g_a_B{i,1} = cellstr(strcat(temp2(8:14),'0000000')); %Left shifted version of remaining bits for Sin
    x_g_b_A{i,1} = cellstr(temp3(1:7)); %Table index value for Cos coefficients
    x_g_b_B{i,1} = cellstr(strcat(temp3(8:14),'0000000')); %Left shifted version of remaining bits for Cos
    
    %Decimal conversion of index values for coefficient values retrival
    sin_indx_coeff{i,1} = cellstr(sin_cos_coeffs{bin2dec(char(x_g_a_A{i,1}))+1,1});
    sin_indx_coeff{i,2} = cellstr(sin_cos_coeffs{bin2dec(char(x_g_a_A{i,1}))+1,2});
    
    cos_indx_coeff{i,1} = cellstr(sin_cos_coeffs{bin2dec(char(x_g_b_A{i,1}))+1,1});
    cos_indx_coeff{i,2} = cellstr(sin_cos_coeffs{bin2dec(char(x_g_b_A{i,1}))+1,2});
    
    %Output y_g_a and y_g_b for Sin and Cos functions
    y_g_a_D_temp = dec2bin(bin2dec(char(sin_indx_coeff{i,2}))*bin2dec(char(x_g_a_B{i,1})),19);
    y_g_a_D{i,1}= cellstr(y_g_a_D_temp(1:19));
    y_g_a_temp =  dec2bin(bin2dec(char(y_g_a_D{i,1}))+bin2dec(char(sin_indx_coeff{i,1})),16);
    y_g_a{i,1}= cellstr(y_g_a_temp(1:15));
    
    y_g_b_D_temp =dec2bin(bin2dec(char(cos_indx_coeff{i,2}))*bin2dec(char(x_g_b_B{i,1})),19);
    y_g_b_D{i,1}= cellstr(y_g_b_D_temp(1:19));
    y_g_b_temp =  dec2bin(bin2dec(char(y_g_b_D{i,1}))+bin2dec(char(cos_indx_coeff{i,1})),16);
    y_g_b{i,1}= cellstr(y_g_b_temp(1:15));
    
    %Quadrant selection for range reconstruction for final output g0 and g1 with two's complement representation
    if bin2dec(char(quad{i,1}))+1 == 1
        g_0{i,1} = dec2twos(1*bin2dec(char(y_g_b{i,1})),16);
        g_1{i,1} = dec2twos(1*bin2dec(char(y_g_a{i,1})),16);
    elseif bin2dec(char(quad{i,1}))+1 == 2
        g_0{i,1} = dec2twos(1*bin2dec(char(y_g_a{i,1})),16);
        g_1{i,1} = dec2twos(-1*bin2dec(char(y_g_b{i,1})),16);                     
    elseif bin2dec(char(quad{i,1}))+1 == 3
        g_0{i,1} = dec2twos(-1*bin2dec(char(y_g_b{i,1})),16);
        g_1{i,1} = dec2twos(-1*bin2dec(char(y_g_a{i,1})),16);
    elseif bin2dec(char(quad{i,1}))+1 == 4
        g_0{i,1} = dec2twos(-1*bin2dec(char(y_g_a{i,1})),16);
        g_1{i,1} = dec2twos(1*bin2dec(char(y_g_b{i,1})),16);
    end
    
end

clearvars -except u_1 u_0 g_0 g_1 y_g_a_D y_g_b_D ;

%% Log Function Unit
load('All_coeff.mat');
n1 = 0;
m1 = 32;
for i =1:length(u_0)
    %Range reduction
    temp_1 = findstr(char(u_0{i,1}),'1'); %Leading Zero detection
    exp_e(i,1) = temp_1(1,1);
    x_e{i,1} = cellstr(dec2bin(bitshift(bin2dec(char(u_0{i,1})),exp_e(i,1)),49)); %Left shifted version of input
    
    temp_2 = char(x_e{i,1});
    x_e_A{i,1} = cellstr((temp_2(1:8))); %Table index value for Log coefficients
    x_e_B{i,1} = cellstr(strcat(temp_2(9:49),'00000000')); %Left shifted version of remaining bits for Log
    
    %Decimal conversion of index values for coefficient values retrival
    log_indx_coeff{i,1} = cellstr(log_coeff{bin2dec(char(x_e_A{i,1}))+1,1});
    log_indx_coeff{i,2} = cellstr(log_coeff{bin2dec(char(x_e_A{i,1}))+1,2});
    log_indx_coeff{i,3} = cellstr(log_coeff{bin2dec(char(x_e_A{i,1}))+1,3});
    
    %Output y_e computation for Log unit
    y_e_D_temp = dec2bin(bin2dec(char(log_indx_coeff{i,3}))*bin2dec(char(x_e_B{i,1})),22);
    y_e_D{i,1}= cellstr(y_e_D_temp(1:22));
    y_e_D1_temp = dec2bin(bin2dec(char(log_indx_coeff{i,2}))+bin2dec(char(y_e_D{i,1})),23);
    y_e_D1{i,1}= cellstr(y_e_D1_temp(1:23));
    y_e_D2_temp = dec2bin(bin2dec(char(y_e_D1{i,1}))*bin2dec(char(x_e_B{i,1})),30);
    y_e_D2{i,1}= cellstr(y_e_D2_temp(1:30));
    y_e_temp = dec2bin(bin2dec(char(log_indx_coeff{i,1}))+bin2dec(char(y_e_D2{i,1})),27);
    y_e{i,1}= cellstr(y_e_temp(1:27));
    
    %Range reconstruction for final output e_final of Log unit
    e_1{i,1} = strjoin(cellstr(num2str(fix(rem(exp_e(i,1)*log(2)*pow2(-(n1-1):m1),2))'))','');
    e_final_temp = dec2bin(bitshift(abs(bin2dec(char(e_1{i,1}))-bin2dec(char(y_e{i,1}))),1),31);
    e_final{i,1}= cellstr(e_final_temp(1:31));
    
end
clearvars -except e_final g_0 g_1;

%% Sqrt Function Unit
load('All_coeff.mat');
for i=1:length(e_final)
    %Range reduction
    temp_1 = findstr(char(e_final{i,1}),'1');
    exp_f(i,1) = 5-temp_1(1,1);
    x_f_1{i,1} = cellstr(char(dec2bin(bitsra(bin2dec(e_final{i,1}),exp_f(i,1)),31))); %Right shifted version of input
    
    if rem(exp_f(i,1),2)==0 %Output generation based on value of exp[0] = 1
       x_f{i,1} = x_f_1{i,1};
       temp_2 = char(x_f{i,1});
       x_f_A{i,1} = cellstr(temp_2(1:6)); %Table index value for Sqrt1 coefficients
       x_f_B{i,1} = cellstr(strcat(temp_2(7:31),'000000')); %Left shifted version of remaining bits for Sqrt
       
       %Decimal conversion of index values for coefficient values retrival
       sqrt1_indx_coeff{i,1} = cellstr(sqrt2_coeff{bin2dec(char(x_f_A{i,1}))+1,1});
       sqrt1_indx_coeff{i,2} = cellstr(sqrt2_coeff{bin2dec(char(x_f_A{i,1}))+1,2});
       
       %Output y_e computation for Sqrt unit
       x_f_D_temp =  dec2bin(bin2dec(char(sqrt1_indx_coeff{i,2}))*bin2dec(char(x_f_B{i,1})),20);
       x_f_D{i,1} = cellstr(x_f_D_temp(1:20));
       
       y_f_temp = dec2bin(bin2dec(char(x_f_D{i,1}))+bin2dec(char(sqrt1_indx_coeff{i,1})),20);
       y_f{i,1} = cellstr(y_f_temp(1:20));
              
    else %Output generation based on value of exp[0] = 0
       x_f{i,1} = cellstr(char(dec2bin(bitsra(bin2dec(x_f_1{i,1}),1),31)));
       
       temp_2 = char(x_f{i,1});
       x_f_A{i,1} = cellstr(temp_2(1:6)); %Table index value for Sqrt2 coefficients
       x_f_B{i,1} = cellstr(strcat(temp_2(7:31),'000000')); %Left shifted version of remaining bits for Sqrt
       
       %Decimal conversion of index values for coefficient values retrival
       sqrt1_indx_coeff{i,1} = cellstr(sqrt1_coeff{bin2dec(char(x_f_A{i,1}))+1,1});
       sqrt1_indx_coeff{i,2} = cellstr(sqrt1_coeff{bin2dec(char(x_f_A{i,1}))+1,2});
       
       %Output y_e computation for Sqrt unit
       x_f_D_temp =  dec2bin(bin2dec(char(sqrt1_indx_coeff{i,2}))*bin2dec(char(x_f_B{i,1})),20);
       x_f_D{i,1} = cellstr(x_f_D_temp(1:20));
       
       y_f_temp = dec2bin(bin2dec(char(x_f_D{i,1}))+bin2dec(char(sqrt1_indx_coeff{i,1})),20);
       y_f{i,1} = cellstr(y_f_temp(1:20));
              
    end
    
    %Range reconstruction for final output f of Sqrt unit
    if rem(exp_f(i,1),2)==0
        exp_f_1(i,1) = bitsra(exp_f(i,1),1);
        f{i,1} = dec2bin(bitshift(bin2dec(char(y_f{i,1})),exp_f_1(i,1)),17);
    else
        exp_f_1(i,1) = bitsra(exp_f(i,1)+1,1);
        f{i,1} = dec2bin(bitshift(bin2dec(char(y_f{i,1})),exp_f_1(i,1)),17);
    end
end
clearvars -except f e_final g_0 g_1;

%% Gaussian distributed Random Variable, generation of x0 and x1
n = 4; %Number of integer bits
m = 11; %Number of fractional bits
for i =1: length(f)
    %Computation of x0 = f*g0
    x_0_temp =  dec2bin(bin2dec(char(f{i,1}))*bin2dec(char(g_0{i,1})),16);
    x_0{i,1} = cellstr(x_0_temp(2:16));
    %For plotting of x0
    x_0_int{i,1} = bin2dec(char(x_0{i,1}));
    temp_1 = char(x_0{i,1});
    for j =1:size(temp_1,2)
        temp_2(1,j) = str2num(temp_1(j));
    end
    x_0_dec(i,1) = temp_2*pow2(n-1:-1:-m).';

    %Computation of x1 = f*g1
    x_1_temp =  dec2bin(bin2dec(char(f{i,1}))*bin2dec(char(g_1{i,1})),16);
    x_1{i,1} = cellstr(x_1_temp(2:16));
    %For plotting of x1
    x_1_int{i,1} = bin2dec(char(x_1{i,1}));
    temp_3 = char(x_1{i,1});
    for j =1:size(temp_3,2)
        temp_4(1,j) = str2num(temp_3(j));
    end
    x_1_dec(i,1) = temp_4*pow2(n-1:-1:-m).';
    
end
    %Histogram plots for Gaussian variable x0
    figure;
    hist(x_0_dec,30)
    title('Histogram for Output X_0')
    xlabel('bins');
    ylabel('Count');
    %Histogram plots for Gaussian variable x1
    figure;
    hist(x_1_dec,30)
    title('Histogram for Output X_1')
    xlabel('bins');
    ylabel('Count');

% Mean and Standard deviation calculation
mean_x_0 = mean(x_0_dec)
std_x_0 = std(x_0_dec)
mean_x_1 = mean(x_1_dec)
std_x_1 = std(x_1_dec)

% Output file generation for comparision with RTL model
x_0_save = cell2table(x_0);
x_1_save = cell2table(x_1);
e_final_save = cell2table(e_final);
f_save = cell2table(f);
g_0_save = cell2table(g_0);
g_1_save = cell2table(g_1);

writetable(x_0_save,'x_0.dat');
writetable(x_1_save,'x_1.dat');
writetable(e_final_save,'e_final.dat');
writetable(f_save,'f.dat');
writetable(g_0_save,'g_0.dat');
writetable(g_1_save,'g_1.dat');

clearvars -except f e_final g_0 g_1 x_0 x_1;
%% Plotting Error files generated from RTL model
% The error files depicts the variations in outputs between Matlab and RTL models
load('errors_finals.mat')
figure; plot(errore./norm(errore));
title('Error in output e (Log Unit) Plot');
xlabel('Sample Index');
ylabel('Error');

figure; plot(errorf./norm(errorf));
title('Error in output f (Sqrt Unit) Plot');
xlabel('Sample Index');
ylabel('Error');

figure; plot(errorg0./norm(errorg0));
title('Error in output g0 (Sin Unit) Plot');
xlabel('Sample Index');
ylabel('Error');

figure; plot(errorg1./norm(errorg1));
title('Error in output g1 (Cos Unit) Plot');
xlabel('Sample Index');
ylabel('Error');

figure; plot(errorx0./norm(errorx0));
title('Error AWGN X0 Plot');
xlabel('Sample Index');
ylabel('Error');

figure; plot(errorx1./norm(errorx1));
title('Error AWGN X1 Plot');
xlabel('Sample Index');
ylabel('Error');

license('inuse') %Command for listing Matlab toolboxes used by code