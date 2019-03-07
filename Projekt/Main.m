% This program takes in a couple of samples of different colors from a
% cellphone. There after i calculates the transfer function for RGB->CIEXYZ
%% Data
%Load in data
[HueColorRefXYZ,HueColorRefLab,HueColors, ColorRefXYZ, ColorRefLab, Colors] = DataLoading();

%% Calculate difference between White calibrated and not white calibrated and directly rgb to XYZ
%Convert patches to Cielab
LabDataWhiteCalibrated =rgb2lab(ColorDataWhiteCalibrated,'WhitePoint','d65');
[MeanCal, MaxCAl] = Ediff(LabDataWhiteCalibrated,ColorDataRef);

LabData =rgb2lab(ColorData,'WhitePoint','d65');
[MeanUnCal, MaxUnCAl] = Ediff(LabData,ColorDataRef);

%% Calculate difference between White calibrated and not white calibrated and rgb->xyz->lab

XYZDataWhiteCalibrated = rgb2xyz(ColorDataWhiteCalibrated,'WhitePoint','d65');
LabDataWhiteCalibrated = xyz2lab(XYZDataWhiteCalibrated,'WhitePoint','d65');
[MeanCal, MaxCAl] = Ediff(LabDataWhiteCalibrated,ColorDataRef);


XYZData = rgb2xyz(ColorData,'WhitePoint','d65');
LabData = xyz2lab(XYZData,'WhitePoint','d65');
[MeanUnCal, MaxUnCAl] = Ediff(LabData,ColorDataRef);


%% Prim rose inversion
A = pinv(ColorDataWhiteCalibrated)*ColorDataRefXYZ;

XYZ_cal =ColorDataWhiteCalibrated*A;
LabData = xyz2lab(XYZ_cal,'WhitePoint','d65');
[Value_mean, Value_max] = Ediff(LabData,ColorDataRef);



%% Regression

A = Optimize_poly(ColorDataWhiteCalibrated', ColorDataRefXYZ');

%Calulate with the matrix 
XYZ_cal_D65 =Polynomial_regression(ColorDataWhiteCalibrated',A)';
LabData = xyz2lab(XYZ_cal_D65,'WhitePoint','d65');
[Value_mean, Value_max] = Ediff(LabData,ColorDataRef);



%% Find best 20 samples
[best, ColorIndex] = Generic(HueColors,HueColorRefLab, 10, 2000);


%%
ColorGene = HueColors(ColorIndex(1,:),:);
A = Optimize_poly_SignalDep(ColorGene', HueColorRefXYZ(ColorIndex(1,:),:)');

XYZ_cal_D65 =Polynomial_regression_SignalDep(HueColors',A)';
LabData = xyz2lab(XYZ_cal_D65,'WhitePoint','d65');
[Value_mean, Value_max] = Ediff(LabData,HueColorRefLab);
%% Show Colors choosen
ColorsChosen =HueColors(ColorIndex(1,:),:);

showRGB(ColorsChosen)











