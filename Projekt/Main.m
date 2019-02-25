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
clear ColorChart;
clear ColorPatches;
%% White point
%Load and examine the white point
W = im2double(imread('TrainData/vit.dng'));
WhiteRGB = WhitePoint(W);
clear W;

%% Convert data after Whitepoint
ColorDataW = ColorData./WhiteRGB;
ColorDataW(ColorDataW>1) = 1.0;


%%
%Convert patches to Cielab
LabData =rgb2lab(ColorDataW,'WhitePoint','d65');

[MeanUnCal, MaxUnCAl] = Ediff(LabData,ColorDataRef);





































