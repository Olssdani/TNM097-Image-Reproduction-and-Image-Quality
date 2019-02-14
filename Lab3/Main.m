%Lab 3

%Add the other folder
addpath('scielab')  
addpath('lab3')  
%% Load files
load dell.mat
load inkjet.mat


%% 1. Color Gamut:
%visa color gamyt
plot_chrom(XYZdell,"red");
hold on 
plot_chrom(XYZinkjet,"blue");

%% 2. Mathemacial metrics

%% 2.1 Grayscale image (MSE/SNR)

%% 2.1.1 Interpolation
% Read in image
image = imread('peppers_gray.tif');
image = im2double(image);

%Nearest
nearest= imresize(imresize(image,0.25,'nearest'),4,'nearest');
multi = cat(2,image,nearest);
montage(multi);
figure

%bilinear
bilinear= imresize(imresize(image,0.25,'bilinear'),4,'bilinear');
multi = cat(2,image,bilinear);
montage(multi);
figure

%bicubic
bicubic= imresize(imresize(image,0.25,'bicubic'),4,'bicubic');
multi = cat(2,image,bicubic);
montage(multi);

%SNR
SNR_Neareset=snr(image,image-nearest);

SNR_bilinear=snr(image,image-bilinear);

SNR_bicubic=snr(image,image-bicubic);


%MSE
MSE_Neareset=immse(image,nearest);

MSE_bilinear=immse(image,bilinear);

MSE_bicubic=immse(image,bicubic);

%% 2.1.2 Halftoning
image = imread('peppers_gray.tif');
image = im2double(image);
%Halftone the image
Dither = dither(image);
level =graythresh(image);
Thresh = image>=level;

%Convert to double
Dither = double(Dither);
Thresh = double(Thresh);

% SNR
SNR_Thresh=snr(image,image-Thresh);
SNR_dither=snr(image,image-Dither);

% MSE
MSE_Thresh = immse(image,Thresh);
MSE_dither = immse(image,Dither);


multi = cat(2,Thresh,Dither);
montage(multi);


%% 2.2 Color Image (Eab)
%Load image
imageRGB = imread('peppers_color.tif');
imageRGB = im2double(imageRGB);
%Make referens LAB image
imLab = rgb2lab(imageRGB);

%Make threshold
ThreshRGB(:,:,1) = imageRGB(:,:,1)>=0.5;
ThreshRGB(:,:,2) = imageRGB(:,:,2)>=0.5;
ThreshRGB(:,:,3) = imageRGB(:,:,3)>=0.5;

%Make dither image
DitherRGB(:,:,1) = dither(imageRGB(:,:,1));
DitherRGB(:,:,2) = dither(imageRGB(:,:,2));
DitherRGB(:,:,3) = dither(imageRGB(:,:,3));

%Convert to double
DitherRGB = double(DitherRGB);
ThreshRGB = double(ThreshRGB);

%SHow Image
imshow(ThreshRGB)
figure
imshow(DitherRGB)

%Convert to LAB
DitherLAB =rgb2lab(DitherRGB);
HalftoneLAB =rgb2lab(ThreshRGB);

% SNR
%SNR_halftoneRGB=snr(imageRGB,imageRGB-halftoneRGB);
%SNR_ditherRGB=snr(imageRGB,imageRGB-DitherRGB);

% MSE
%MSE_halftoneRGB = immse(imageRGB,halftoneRGB);
%MSE_ditherRGB = immse(imageRGB,DitherRGB);

DeltaEdither = sqrt((DitherLAB(:,:,1)-imLab(:,:,1)).^2+(DitherLAB(:,:,2)-imLab(:,:,2)).^2+(DitherLAB(:,:,3)-imLab(:,:,3)).^2);
DeltaEditherMetric = sum(sum(DeltaEdither))/(size(DeltaEdither,1)*size(DeltaEdither,2));

DeltaEThresh = sqrt((HalftoneLAB(:,:,1)-imLab(:,:,1)).^2+(HalftoneLAB(:,:,2)-imLab(:,:,2)).^2+(HalftoneLAB(:,:,3)-imLab(:,:,3)).^2);
DeltaEThreshMetric = sum(sum(DeltaEThresh))/(size(DeltaEThresh,1)*size(DeltaEThresh,2));


%% 3.  Mathematical metrics involving HVS


RDither = snr_filter(image,image-Dither);
Rhalftone = snr_filter(image,image-Thresh);

% Nu ger dem en bättre reprentasation av vad ens egna objektiva syn ger.

%Filter
f=MFTsp(15,0.0847,500);

%referens
ref(:,:,1) =conv2(imageRGB(:,:,1),f,'same');
ref(:,:,2) =conv2(imageRGB(:,:,2),f,'same');
ref(:,:,3) =conv2(imageRGB(:,:,3),f,'same');
ref(:,:,1) = (ref(:,:,1)>0).*ref(:,:,1);
ref(:,:,2) = (ref(:,:,2)>0).*ref(:,:,2);
ref(:,:,3) = (ref(:,:,3)>0).*ref(:,:,3);
ref = rgb2lab(ref);

% dither
DitherHVS(:,:,1) =conv2(DitherRGB(:,:,1),f,'same');
DitherHVS(:,:,2) =conv2(DitherRGB(:,:,2),f,'same');
DitherHVS(:,:,3) =conv2(DitherRGB(:,:,3),f,'same');
DitherHVS(:,:,1) = (DitherHVS(:,:,1)>0).*DitherHVS(:,:,1);
DitherHVS(:,:,2) = (DitherHVS(:,:,2)>0).*DitherHVS(:,:,2);
DitherHVS(:,:,3) = (DitherHVS(:,:,3)>0).*DitherHVS(:,:,3);
DitherHVS = rgb2lab(DitherHVS);

% Halftone
HalftoneHVS(:,:,1) =conv2(ThreshRGB(:,:,1),f,'same');
HalftoneHVS(:,:,2) =conv2(ThreshRGB(:,:,2),f,'same');
HalftoneHVS(:,:,3) =conv2(ThreshRGB(:,:,3),f,'same');
HalftoneHVS(:,:,1) = (HalftoneHVS(:,:,1)>0).*HalftoneHVS(:,:,1);
HalftoneHVS(:,:,2) = (HalftoneHVS(:,:,2)>0).*HalftoneHVS(:,:,2);
HalftoneHVS(:,:,3) = (HalftoneHVS(:,:,3)>0).*HalftoneHVS(:,:,3);
HalftoneHVS = rgb2lab(HalftoneHVS);

%Delta e for dither
DeltaEdither = sqrt((DitherHVS(:,:,1)-ref(:,:,1)).^2+(DitherHVS(:,:,2)-ref(:,:,2)).^2+(DitherHVS(:,:,3)-ref(:,:,3)).^2);
DeltaEditherMetric = sum(sum(DeltaEdither))/(size(DeltaEdither,1)*size(DeltaEdither,2));

%Delta e for thres
DeltaEThresh = sqrt((HalftoneHVS(:,:,1)-ref(:,:,1)).^2+(HalftoneHVS(:,:,2)-ref(:,:,2)).^2+(HalftoneHVS(:,:,3)-ref(:,:,3)).^2);
DeltaEThreshMetric = sum(sum(DeltaEThresh))/(size(DeltaEThresh,1)*size(DeltaEThresh,2));

%% 4. S-CIELab


%% 4.1 S-CIELab as a full-reference metric
load xyz.mat
%Load image
imageRGB = imread('peppers_color.tif');
imageRGB = im2double(imageRGB);
%Nearest
nearestRGB= imresize(imresize(imageRGB,0.25,'nearest'),4,'nearest');

%bilinear
bilinearRGB= imresize(imresize(imageRGB,0.25,'bilinear'),4,'bilinear');

%bicubic
bicubicRGB= imresize(imresize(imageRGB,0.25,'bicubic'),4,'bicubic');

%Show figure
imshow(nearestRGB);
figure
imshow(bilinearRGB);
figure
imshow(bicubicRGB);

%COnvert to XYZ
ref_XYZ=rgb2xyz(imageRGB);
ner_XYZ=rgb2xyz(nearestRGB);
bil_XYZ=rgb2xyz(bilinearRGB);
bic_XYZ=rgb2xyz(bicubicRGB);

%Scielab
%Sample
sampPerDeg =round(72 / ((180/pi)*atan(1/30)));

%nearest
Nearest_Scielab =scielab(sampPerDeg,ref_XYZ,ner_XYZ,[95.05 100 108.9],'xyz');
Nearest_Scielab = sum(sum(Nearest_Scielab))/(size(Nearest_Scielab,1)*size(Nearest_Scielab,2));
%Bilinear
Bilinear_Scielab =scielab(sampPerDeg,ref_XYZ,bil_XYZ,[95.05 100 108.9],'xyz');
Bilinear_Scielab = sum(sum(Bilinear_Scielab))/(size(Bilinear_Scielab,1)*size(Bilinear_Scielab,2));
%Bicubical
Bicubic_Scielab =scielab(sampPerDeg,ref_XYZ,bic_XYZ,[95.05 100 108.9],'xyz');
Bicubic_Scielab = sum(sum(Bicubic_Scielab))/(size(Bicubic_Scielab,1)*size(Bicubic_Scielab,2));

% Ja den stämmer överrens med vad jag tycker.

%% 4.2 S-CIELab as a no-reference metric
load colorhalftones.mat
sampPerDeg =round(72 / ((180/pi)*atan(1/30)));
imshow(c1)
figure
imshow(c2)
figure
imshow(c3)
figure
imshow(c4)
figure
imshow(c5)


C1_test =scielab(sampPerDeg,c1);
C2_test =scielab(sampPerDeg,c2);
STDC1 =sum(sum(std(C1_test)));
STDC2 =sum(sum(std(C2_test)));
%De ser ungefär likadana ut och få ungefär samma resultat så typ ja

C3_test =scielab(sampPerDeg,c3);
C4_test =scielab(sampPerDeg,c4);
C5_test =scielab(sampPerDeg,c5);
STDC3 =sum(sum(std(C3_test)));
STDC4 =sum(sum(std(C4_test)));
STDC5 =sum(sum(std(C5_test)));

%Ser ingen typ skillnad



%% 5 SSIM
peppers = im2double(imread('peppers_gray.tif'));


%a
even = 1:2:size(peppers,1);
uneven = 2:2:size(peppers,1);
distortion1 = peppers;
%distorion
distortion1(even,:) =distortion1(even,:)+0.1; 
distortion1(uneven,:) =distortion1(uneven,:)-0.1; 
%Set boundries to 0 and 1
distortion1(distortion1<0)=0;
distortion1(distortion1>1)=1;
imshow(distortion1)

%distortion 2
distortion2 = peppers;
%distorion
distortion2(1:size(distortion2,1)/2,:) =distortion2(1:size(distortion2,1)/2,:)+0.1; 
distortion2((size(distortion2,1)/2+1):size(distortion2,1),:) =distortion2((size(distortion2,1)/2+1):size(distortion2,1),:)-0.1; 
%Set boundries to 0 and 1
distortion2(distortion2<0)=0;
distortion2(distortion2>1)=1;
imshow(distortion2)

[dis1, map1] = ssim(distortion1, peppers);

[dis2 map2] = ssim(distortion2, peppers);
imshow(map1)
figure
imshow(map2)

% Dis1 syns de mycket mindre att den är distorerad då det smälter ihop i en
% enda stor klump. Däremot i dis2 ser man mycket tydligt att halva är
% distorerad och den andra halvan inte är.




%% B
%distortion 1
dist1=peppers+0.2*(rand(size(peppers))-0.5);

%Distortion 2
f=fspecial('gauss',21,10);
dist2 = conv2(peppers,f,'same');

% Show distortions
imshow(dist1)
figure
imshow(dist2)

%Get snr values
SNR_dist1=snr(peppers,peppers-dist1);
SNR_dist2=snr(peppers,peppers-dist2);

%Get ssim
[dis1, map1] = ssim(dist1, peppers);
[dis2 map2] = ssim(dist2, peppers);

%Show distortion maps
figure
imshow(map1)
figure
imshow(map2)




