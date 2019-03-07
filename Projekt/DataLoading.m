function [HueColorRefXYZ,HueColorRefLab,HueColors, ColorRefXYZ, ColorRefLab, Colors ] = DataLoading()
    %Load referens data for the HueColor
    load('HueColor.mat');
    HueColorRefLab = HueColor;
    %Load the data for the HueColors
    load('HueColorsData.mat');
    HueColors = ColorChart;
    %Load the data for the Colors
    load('ColorChart.mat');
    Colors = ColorChart;
    %Load referens data for the Color
    load('ColorPatches.mat');
    ColorRefLab  = ColorPatches;
    %Clear variables
    clear ColorChart
    clear HueColor
    clear ColorPatches
    
    % Calibrate for the white point
    W = im2double(imread('HueColors/vit.dng'));
    WhiteRGB = WhitePoint(W);
    clear W;
    HueColors = HueColors./WhiteRGB;
    HueColors(HueColors>1) = 1.0;
    
    W = im2double(imread('Traindata/vit.dng'));
    WhiteRGB = WhitePoint(W);
    clear W;
    Colors = Colors./WhiteRGB;
    Colors(Colors>1) = 1.0;
    
    
    % Get XYZ ref for both colors
    HueColorRefXYZ = lab2xyz(HueColorRefLab);
    ColorRefXYZ = lab2xyz(ColorRefLab);
    
    
    
    
    
end

