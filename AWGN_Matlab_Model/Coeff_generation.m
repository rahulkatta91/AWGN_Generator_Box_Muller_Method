%% Sin/Cos coefficients generation
inter = linspace(0,1,129); % Generating constant interval array
fun_out = sin(inter*pi/2); % Input to Sin

% Solving Degree -1 Quadratic equation
for i = 1: size(inter,2)-1;
    c1 = (fun_out(1,i+1)-fun_out(1,i))/(inter(1,i+1)-inter(1,i));
    c0 = fun_out(1,i)- c1*inter(1,i);
    % Extracting Coefficient values
    coeff(i,1) = c0;
    coeff(i,2) = c1;
end

% c0 =19 bit,c1 = 12 bit ------------>sin/cos

% Converting Signed fraction to  binary and vice versa
m_bit_size = [19,12];
n = 1;         % number bits for integer part      
sin_cos_bin_un1 = [];
sin_cos_bin_un2 = [];


    m1 = m_bit_size(1)-n-1;         % Number bits for fraction part of number
    m2 = m_bit_size(2)-n-1;         % Number bits for fraction part of number
    
    m1_comp = zeros(1,m_bit_size(1));
    m2_comp = zeros(1,m_bit_size(2));
        
    m1_comp(1,m_bit_size(1)) = 1;   % Creating a Matrix with right end bit one and rest all zeros
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
       sin_cos_coeffs{j,1} =  strjoin(cellstr(num2str(d2b1'))','');%c0
       sin_cos_coeffs{j,2} =  strjoin(cellstr(num2str(d2b2'))','');%c1
       % Sin_Cos coeff in binary matrix format binary
       sin_cos_bin_un1 = [sin_cos_bin_un1;d2b1];
       sin_cos_bin_un2 = [sin_cos_bin_un2;d2b2];
       % Sin_Cos coeff for exporting to RTL Code
       sin_save{j,1} = cellstr(strcat(num2str(j-1),' : data <= 31''','b',sin_cos_coeffs{j,2},'_',sin_cos_coeffs{j,1},';'));
    end
% Clearing Unnecessary variables
clearvars -except sin_cos_coeffs sin_save

%% Log coefficients generation
inter = linspace(1,2,258); % Generating constant interval array
fun_out = -log(inter); % Input to log

% Solving Degree -2 Quadratic equation
for i = 1: size(inter,2)-2;
    c2 = (((fun_out(1,i+2)- fun_out(1,i))*(inter(1,i+1)-inter(1,i))) - ((fun_out(1,i+1)- fun_out(1,i))*(inter(1,i+2)-inter(1,i))))/((inter(1,i+2) - inter(1,i))*(inter(1,i+1) - inter(1,i))*(inter(1,i+2) - inter(1,i+1)));
    c1 = ((fun_out(1,i+2)- fun_out(1,i))/(inter(1,i+2) - inter(1,i))) - (c2*(inter(1,i+2) + inter(1,i)));
    c0 = fun_out(1,i) - (c2*(inter(1,i)^2)) - (c1*inter(1,i));
    % Extracting Coefficient values
    coeff(i,1) = c0;
    coeff(i,2) = c1;
    coeff(i,3) = c2;
    
end

% log----> coeff
% c0 =30 bit,c1 = 22 bit, c2 =13
m_bit_size = [30,22,13];
n = 1;         % Number bits for integer part of number      
log_bin_un1 = [];
log_bin_un2 = [];
log_bin_un3 = [];

    m1 = m_bit_size(1)-n-1;         % Number bits for fraction part of number
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
       
       log_save{j,1} = cellstr(strcat(num2str(j-1),' : data <= 65''','b',log_coeff{j,3},'_',log_coeff{j,2},'_',log_coeff{j,1},';'));
    end

    clearvars -except sin_cos_coeffs sin_save log_coeff log_save
%% Sqrt1 coefficients generation
inter = linspace(2,4,65);
fun_out = sqrt(inter); %Input to Sqrt1 function

% Solving Degree -1 Quadratic equation
for i = 1: size(inter,2)-1;
    c1 = (fun_out(1,i+1)-fun_out(1,i))/(inter(1,i+1)-inter(1,i));
    c0 = fun_out(1,i)- c1*inter(1,i);
    % Extracting Coefficient values
    coeff(i,1) = c0;
    coeff(i,2) = c1;
end

% c0 =20 bit,c1 = 12 bit ------------>sqrt1
m_bit_size = [20,12];
n = 1;         % Number bits for integer part of number      
sqrt1_bin_un1 = [];
sqrt1_bin_un2 = [];

    m1 = m_bit_size(1)-n-1;         % Number bits for fraction part of number
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
       
       sqrt1_save{j,1} = cellstr(strcat(num2str(j-1),' : data <= 32','''','b',sqrt1_coeff{j,2},'_',sqrt1_coeff{j,1},';'));       
       
    end
    clearvars -except sin_cos_coeffs sin_save log_coeff log_save sqrt1_coeff sqrt1_save

%% Sqrt 2 coefficients generation
inter = linspace(1,2,65);
fun_out = sqrt(inter);%Input to Sqrt2 function

% Solving Degree -1 Quadratic equation
for i = 1: size(inter,2)-1;
    c1 = (fun_out(1,i+1)-fun_out(1,i))/(inter(1,i+1)-inter(1,i));
    c0 = fun_out(1,i)- c1*inter(1,i);
    % Extracting Coefficient values
    coeff(i,1) = c0;
    coeff(i,2) = c1;
end


% c0 =20 bit,c1 = 12 bit ------------>sqrt2

m_bit_size = [20,12];
n = 1;         % Number bits for integer part of number      
sqrt2_bin_un1 = [];
sqrt2_bin_un2 = [];

    m1 = m_bit_size(1)-n-1;         % Number bits for fraction part of number
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
       
       sqrt2_save{j,1} = cellstr(strcat(num2str(j-1),' : data <= 32''b',sqrt2_coeff{j,2},'_',sqrt2_coeff{j,1},';')); 
    end
 clearvars -except sin_cos_coeffs sin_save log_coeff log_save sqrt1_coeff sqrt1_save sqrt2_coeff sqrt2_save
 
 license('inuse') %Command for listing Matlab toolboxes used by code
 save('All_coeff','log_coeff','sin_cos_coeffs','sqrt1_coeff','sqrt2_coeff'); %Saving the generated coefficient values