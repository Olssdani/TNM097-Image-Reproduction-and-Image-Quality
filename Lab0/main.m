clc
clear all
close all
load illum.mat

%% 1
%Translate the lighting to XYZ valyes with the standard observer
reflectance = ones(61,1);
XYZ(1,:) = colorsignal2xyz(reflectance,CIEA');
XYZ(2,:) = colorsignal2xyz(reflectance,CIEB');
XYZ(3,:) = colorsignal2xyz(reflectance,CIED65');
XYZ(4,:) = colorsignal2xyz(reflectance,Halogen75W');
XYZ(5,:) = colorsignal2xyz(reflectance,plank50k');
XYZ(6,:) = colorsignal2xyz(reflectance,plank65k');
XYZ(7,:) = colorsignal2xyz(reflectance,plank90k');
XYZ(8,:) = colorsignal2xyz(reflectance,Tungsten60W');

% Calculate the chromaticity
s = (XYZ(:,1)+XYZ(:,2)+XYZ(:,3));
s= 1./s(:,1);
Croma = s.*XYZ;

%% 2 
%loop thorugh all colorvalues
for i =1:size(XYZ,1)
    [r,g,b] = xyz2rgb(XYZ(i,1),XYZ(i,2),XYZ(i,3));
    rgb(i,1) = r;
    rgb(i,2) = b;
    rgb(i,3) = g;
end
showRGB(rgb);



%% 3

%Tar Tungsten60W, Plank90 och CIED65

%% 4


plot(waverange, CIEA);
hold on 
plot(waverange, CIEB);
plot(waverange, CIED65);
plot(waverange, Halogen75W);
plot(waverange, plank50k);
plot(waverange, plank65k);
plot(waverange, plank90k);
plot(waverange, Tungsten60W);
hold off
%Tar Tungsten60W CIEB och Plank90k
%Tog nästan samma så de finns ett samband däremot spelade de in hur jag
%definerade olika

%% 5
load chips20.mat


for i = 1:size(chips20, 1)
    XYZ= colorsignal2xyz(chips20(i,:)',Tungsten60W');
    [r,g,b] = xyz2rgb(XYZ(1,1),XYZ(1,2),XYZ(1,3));
    rgb(i,1) = r;
    rgb(i,2) = b;
    rgb(i,3) = g;
end
showRGB(rgb);

for i = 1:size(chips20, 1)
    XYZ= colorsignal2xyz(chips20(i,:)',plank90k');
    [r,g,b] = xyz2rgb(XYZ(1,1),XYZ(1,2),XYZ(1,3));
    rgb(i,1) = r;
    rgb(i,2) = b;
    rgb(i,3) = g;
end
showRGB(rgb);
for i =1: size(chips20, 1)
    XYZ= colorsignal2xyz(chips20(i,:)',CIED65');
    [r,g,b] = xyz2rgb(XYZ(1,1),XYZ(1,2),XYZ(1,3));
    rgb(i,1) = r;
    rgb(i,2) = b;
    rgb(i,3) = g;
end
showRGB(rgb);


%% 6a
%Konvertera till CIEXYZ
%Valda belysningar Tungsten60W, Plank90 och CIED65
reflectance = ones(61,1);
XYZ(1,:) = colorsignal2xyz(reflectance,Tungsten60W');
XYZ(2,:) = colorsignal2xyz(reflectance,plank90k');
XYZ(3,:) = colorsignal2xyz(reflectance,CIED65');


plot3(XYZ(1,1),XYZ(1,2),XYZ(1,3),'*');
hold on
plot3(XYZ(2,1),XYZ(2,2),XYZ(2,3),'+');
hold on
plot3(XYZ(3,1),XYZ(3,2),XYZ(3,3),'o');
axis([0 200 0 200 0 200])


%% 6b
load chips20.mat
for i = 1:size(chips20, 1)
    Tung(i,:)= colorsignal2xyz(chips20(i,:)',Tungsten60W');
    Plank(i,:)= colorsignal2xyz(chips20(i,:)',plank90k');
    CIED(i,:)= colorsignal2xyz(chips20(i,:)',CIED65');
end

for i = 1:size(Tung, 1)
    hold on
    plot3(Tung(i,1),Tung(i,2),Tung(i,3),'o');
    plot3(Plank(i,1),Plank(i,2),Plank(i,3),'x');
    plot3(CIED(i,1),CIED(i,2),CIED(i,3),'*');
end


%% 7a
reflectance = ones(61,1);
XYZ(1,:) = colorsignal2xyz(reflectance,Tungsten60W');
XYZ(2,:) = colorsignal2xyz(reflectance,plank90k');
XYZ(3,:) = colorsignal2xyz(reflectance,CIED65');

hold on
[L, a, b] = (xyz2lab(XYZ(1,1),XYZ(1,2),XYZ(1,3)));
plot3(L,a,b,'o');
[L, a, b] = xyz2lab(XYZ(2,1),XYZ(2,2),XYZ(2,3));
plot3(L,a,b,'x');
[L, a, b]= xyz2lab(XYZ(3,1),XYZ(3,2),XYZ(3,3));
plot3(L,a,b,'*');


%% 7b
