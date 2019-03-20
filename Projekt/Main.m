% This program takes in a couple of samples of different colors from a
% cellphone. There after i calculates the transfer function for RGB->CIEXYZ
%% Data
%Load in data
[HueColorRefXYZ,HueColorRefLab,HueColors, ColorRefXYZ, ColorRefLab, Colors,ColorReV2fXYZ, ColorV2RefLab, ColorsV2 ] = DataLoading();

% Read in data from spektro




%% Calculate difference between White calibrated and not white calibrated and directly rgb to XYZ
%Convert patches to Cielab
HueColorsLab =rgb2lab(HueColors,'WhitePoint','d65');
[HueMean, HueMax] = Ediff(HueColorsLab,HueColorRefLab);

ColorsLab =rgb2lab(Colors,'WhitePoint','d65');
[ColorsMean, ColorsMax] = Ediff(ColorsLab,ColorRefLab);

%% Calculate difference between White calibrated and not white calibrated and rgb->xyz->lab

HueColorsXYZ = rgb2xyz(HueColors,'WhitePoint','d65');
HueColorsLab = xyz2lab(HueColorsXYZ,'WhitePoint','d65');
[HueMean, HueMax] = Ediff(HueColorsLab,HueColorRefLab);


ColorsXYZ = rgb2xyz(Colors,'WhitePoint','d65');
ColorsLab = xyz2lab(ColorsXYZ,'WhitePoint','d65');
[ColorsMean, ColorsMax] = Ediff(ColorsLab,ColorRefLab);

ColorsV2XYZ = rgb2xyz(ColorsV2,'WhitePoint','d65');
ColorsV2Lab = xyz2lab(ColorsV2XYZ,'WhitePoint','d65');
[ColorsV2Mean, ColorsV2Max] = Ediff(ColorsV2Lab,ColorPatches);


%% Prim rose inversion
A = pinv(HueColors)*HueColorRefXYZ;
HueColorsXYZ =HueColors*A;
HueColorsLab = xyz2lab(HueColorsXYZ,'WhitePoint','d65');
[HueMean, HueMax] = Ediff(HueColorsLab,HueColorRefLab);

A = pinv(Colors)*ColorRefLab;
ColorsXYZ =Colors*A;
ColorsLab = xyz2lab(ColorsXYZ,'WhitePoint','d65');
[ColorsMean, ColorsMax] = Ediff(ColorsLab,ColorRefLab);

%% Regression

A = Optimize_poly(HueColors', HueColorRefXYZ');
HueColorsXYZ =Polynomial_regression(HueColors',A)';
HueColorsLab = xyz2lab(HueColorsXYZ,'WhitePoint','d65');
[HueMean, HueMax] = Ediff(HueColorsLab,HueColorRefLab);

A = Optimize_poly(Colors', ColorRefXYZ');
ColorsXYZ =Polynomial_regression(Colors',A)';
ColorsLab = xyz2lab(ColorsXYZ,'WhitePoint','d65');
[ColorsMean, ColorsMax] = Ediff(ColorsLab,ColorRefLab);

%% Signal dep Regression

A = Optimize_poly_SignalDep(HueColors', HueColorRefXYZ');
HueColorsXYZ =Polynomial_regression_SignalDep(HueColors',A)';
HueColorsLab = xyz2lab(HueColorsXYZ,'WhitePoint','d65');
[HueMean, HueMax] = Ediff(HueColorsLab,HueColorRefLab);

A = Optimize_poly_SignalDep(Colors', ColorRefXYZ');
ColorsXYZ =Polynomial_regression_SignalDep(Colors',A)';
ColorsLab = xyz2lab(ColorsXYZ,'WhitePoint','d65');
[ColorsMean, ColorsMax] = Ediff(ColorsLab,ColorRefLab);
%% Find best 20 samples
clear best
clear ColorIndex
[best, ColorIndex] = Generic(ColorsV2,ColorV2RefLab, 40, 1000);


%%
ColorGene = HueColors(ColorIndex(1,:),:);
A = Optimize_poly_SignalDep(ColorGene', HueColorRefXYZ(ColorIndex(1,:),:)');

XYZ_cal_D65 =Polynomial_regression_SignalDep(HueColors',A)';
LabData = xyz2lab(XYZ_cal_D65,'WhitePoint','d65');
[Value_mean, Value_max] = Ediff(LabData,HueColorRefLab);
%% Show Colors choosen
ColorsChosen =HueColors(ColorIndex(1,:),:);

showRGB(ColorsChosen)









