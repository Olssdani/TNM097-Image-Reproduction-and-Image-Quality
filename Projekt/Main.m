% This program takes in a couple of samples of different colors from a
% cellphone. There after i calculates the transfer function for RGB->CIEXYZ

%% Data
%Load in data
load('ColorChart.mat');
load('ColorPatches.mat');
ColorDataRef = ColorPatches;

%% ReMapping
% Remap the data because some data was lost during processing and has to be
% taken away. The colorPathces that was lost is 29, 63 and 64
ColorData = ColorChart;
ColorDataRef = ColorPatches;
%64
ColorData(64,:) =[];
ColorDataRef(64,:) =[];
%63
ColorData(63,:) =[];
ColorDataRef(63,:) =[];
%29
ColorData(29,:) =[];
ColorDataRef(29,:) =[];
ColorDataRefXYZ =lab2xyz(ColorDataRef);
clear ColorChart;
clear ColorPatches;
%% White point
%Load and examine the white point
W = im2double(imread('TrainData/vit.dng'));
WhiteRGB = WhitePoint(W);
clear W;

%% Convert data after Whitepoint
ColorDataWhiteCalibrated = ColorData./WhiteRGB;
ColorDataWhiteCalibrated(ColorDataWhiteCalibrated>1) = 1.0;


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
[best, ColorIndex] = Generic(ColorData,ColorDataRef, 40,500 );


%% Show Colors choosen
Colors =ColorData(ColorIndex(1,:),:);

showRGB(Colors)











