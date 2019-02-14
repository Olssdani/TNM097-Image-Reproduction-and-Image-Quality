%% Lab 2
%% Load Files
load XYZ_ref.mat
load XYZ_est.mat
load xyz.mat
load RGB_raw.mat
load RGB_cal.mat
load Ramp_linear.mat
load Ramp_display.mat
load illum.mat
load DLP.mat
load chips20.mat
load TRC_display.mat


%% Assignment 1.1
plot(0:0.01:1,TRCb,'blue');
hold on
plot(0:0.01:1,TRCr,'red');
plot(0:0.01:1,TRCg,'green');



%% Assignment 1.2
%Incorrect reprensation
%imshow(Ramp_display);
%figure
%Correct reprentsation
%imshow(Ramp_linear);

% %Calibrate the channels
% x = 0:0.01:1;
% r = interp1(TRCr,x,x,'pchips'); 
% b = interp1(TRCb,x,x,'pchips'); 
% g = interp1(TRCg,x,x,'pchips'); 
% 
% %Plot the calibrated channels
% plot(x,b,'blue');
% hold on
% plot(x,r,'red');
% plot(x,g,'green');
% 


%Calibrate image
Ramp_Cal_display = CalibrateRGBImage(Ramp_display);
figure
imshow(Ramp_Cal_display);
%% Assignment 1.3
yr = 2.1;
yg = 2.4;
yb = 1.8;


% gamma correction since Dmax =1.0 so we ignore it
Ramp_Gamma_Display(:,:,1) = (Ramp_display(:,:,1)).^(1/yr);
Ramp_Gamma_Display(:,:,2) = (Ramp_display(:,:,2)).^(1/yg);
Ramp_Gamma_Display(:,:,3) = (Ramp_display(:,:,3)).^(1/yb);
imshow(Ramp_Gamma_Display);
%% Assignment 2.1
x = 400:5:700;
plot(x,DLP(:,1),'red');
hold on
plot(x,DLP(:,2),'green');
plot(x,DLP(:,3),'blue');
%% Assignment 2.2
%Calculate the referens values
for i = 1:size(chips20,1)   
    XYZ_D65_ref(i,:) = colorsignal2xyz(chips20(i,:)',CIED65');
end



%Get the color spectra from the RGB_raw with regards to the output device
Srgb_spectra= DLP*RGB_raw;

%Calcuate K value depending on CIED65
k = 100/sum(CIED65'.*xyz(:,2));

%Make spectra to XYZ
Srgb =k*Srgb_spectra'*xyz;

%Take the mean and max
[mean_, max_] = xyz2labdiff(Srgb, XYZ_D65_ref);


%% Assignment 2.3
Srgb_spectra= DLP*RGB_cal;

Srgb =k*Srgb_spectra'*xyz;
[mean_, max_] = xyz2labdiff(Srgb, XYZ_D65_ref);

%% Assignment 3.1
reflectance = ones(61,1);
k = 100/sum(CIED65'.*xyz(:,2));
for i = 1:size(DLP,2)  
     
    %Sum XYZ for each channel
    X = k*sum(DLP(:,i).*xyz(:,1));
    Y = k*sum(DLP(:,i).*xyz(:,2));
    Z = k*sum(DLP(:,i).*xyz(:,3));
    Acrt(1,i) = X;
    Acrt(2,i) = Y;
    Acrt(3,i) = Z;
end




%% Assignment 3.2
load XYZ_cal_D65.mat
%Calculate inverse of of Acrt
Dprim = Acrt\XYZ_cal_D65';
Srgb_spectra= DLP*Dprim;

% Calculate XYZ
Srgb =k*Srgb_spectra'*xyz;
[mean_, max_] = xyz2labdiff(Srgb, XYZ_D65_ref);





%% Assignment 3.4
Dprim = Acrt\XYZ_cal_D65';
%Clamp the values
Dprim(Dprim>1.0)=1.00;
Dprim(Dprim<0.0)=0.0;
Srgb_spectra= DLP*Dprim;


Srgb =k*Srgb_spectra'*xyz;
[mean_, max_] = xyz2labdiff(Srgb, XYZ_D65_ref);

%% Assignment 3.5

plot_chrom_sRGB(Acrt);




%% Assignment 3.6

plot(waverange, Srgb_spectra(:,1));
hold on
plot(waverange, chips20(1,:).*CIED65);
plot(waverange, chips20(1,:))


