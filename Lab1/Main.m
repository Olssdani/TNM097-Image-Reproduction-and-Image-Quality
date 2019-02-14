%% Load all data 
load Ad.mat
load Ad2.mat
load illum.mat
load chips20.mat
load M_XYZ2RGB.mat
load xyz.mat

%% Assignment 1.1

%Plot the two cameras
%r
figure
plot(waverange, Ad(:,1), 'red')
hold on
plot(waverange, Ad2(:,1), 'blue')

%b
figure
plot(waverange, Ad(:,2), 'red')
hold on
plot(waverange, Ad2(:,2), 'blue')

%g
figure
plot(waverange, Ad(:,3), 'red')
hold on
plot(waverange, Ad2(:,3), 'blue')

figure
plot(waverange, Ad, 'red')
figure
plot(waverange, Ad2, 'blue')


%% Assignment 1.2

%loop through all materials for AD
for i = 1:size(chips20,1)
    %Get the e which is the reflectance time the illumination R*I
    e = chips20(i,:).*CIED65;

    % Get the camera response d = ad' *e'
    d = Ad'*e';
    
    RGB_raw_D65(i,:) =d'; 
 
end
%Show 
showRGB(RGB_raw_D65);


%loop through all materials for AD
for i = 1:size(chips20,1)
    %Get the e which is the reflectance time the illumination R*I
    e = chips20(i,:).*CIED65;

    % Get the camera response d = ad' *e'
    d = Ad2'*e';
    
    RGB_raw_D65_AD2(i,:) =d'; 
 
end
%show
showRGB(RGB_raw_D65_AD2);









%% Assignment 2.1
%Find d with a e vector with just a vector of ones
e = ones(1,61);
% = e.*CIED65;
d = Ad'*e';

NormalizationAD = 1./d;

d = Ad2'*e';
NormalizationAD2 = 1./d;


%% Assignment 2.2

RGB_cal_D65 = RGB_raw_D65.*NormalizationAD';
showRGB(RGB_cal_D65);
RGB_cal_D65_AD2 = RGB_raw_D65_AD2.*NormalizationAD2';
showRGB(RGB_cal_D65_AD2);


%% Assignment 2.3

plot(waverange, CIEA, 'red');
hold on
plot(waverange, CIED65, 'blue');


%% Assignment 2.4


%loop through all materials for AD With lightsource CIEA
for i = 1:size(chips20,1)
    %Get the e which is the reflectance time the illumination R*I
    e = chips20(i,:).*CIEA;

    % Get the camera response d = ad' *e'
    d = Ad'*e';
    
    RGB_raw_A(i,:) =d'; 
end

%Normalize
RGB_cal_A = RGB_raw_A.*NormalizationAD';
%Show
showRGB(RGB_cal_D65);
showRGB(RGB_cal_A);


%% Assignment 2.5

%Normalization D65
R = ones(1,61);
e = R.*CIED65;
d = Ad'*e';
NormalizationAD_D65 = 1./d;

%NOrmalization A
e = R.*CIEA;
d = Ad'*e';
NormalizationAD2_A = 1./d;

% Calibrate
RGB_cal_AD_D65 = RGB_raw_D65.*NormalizationAD_D65';
RGB_cal_AD_A = RGB_raw_A*1.*NormalizationAD2_A';

%Show
showRGB(RGB_cal_AD_D65);
showRGB(RGB_cal_AD_A);


%% Assignment 3.1
%Get the reference values
for i = 1:size(chips20,1)   
    XYZ_D65_ref(i,:) = colorsignal2xyz(chips20(i,:)',CIED65');
end


%% Assignment 3.2
%Calculate the XYZ values from RGB
XYZ_cal_D65 = inv(M_XYZ2RGB)*RGB_cal_D65';
%Calulate the max and mean
[Value_mean, Value_max] = xyz2labdiff(XYZ_cal_D65',XYZ_D65_ref);



%% Assignment 3.3

plot(waverange, Ad,'red');
figure
plot(waverange, xyz,'blue');




%% Assignment 3.4
% use the the moore-penrose pseudo inv to convert rgb->XYZ
A = pinv(RGB_cal_D65)*XYZ_D65_ref;

% D*A
XYZ_cal_D65 =RGB_cal_D65*A;

[Value_mean, Value_max] = xyz2labdiff(XYZ_cal_D65,XYZ_D65_ref);

%% Assignment 3.5

%Get the matrix A
A = Optimize_poly(RGB_cal_D65', XYZ_D65_ref');

%Calulate with the matrix 
XYZ_cal_D65 =Polynomial_regression(RGB_cal_D65',A)';

[Value_mean, Value_max] = xyz2labdiff(XYZ_cal_D65,XYZ_D65_ref);

