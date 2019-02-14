function [L,a,b] = rgb2lab(r,g,b)

[n,m] = size(r);

Q = [41.2453 35.7580 18.0423; 21.2671 71.5160 7.2169; 1.9334 11.9193 95.0227];


xyz=Q*[r(:)';g(:)';b(:)'];
y=reshape(xyz(2,:),n,m);

Xn = 95.05;
Yn = 100.00;
Zn = 108.89;

ylim = Yn*0.008856;
L = (y>ylim).*(116*(y/Yn).^(1/3)-16)+(y<=ylim).*(903.3*y/Yn);
ytemp = foo(y/Yn);
a = 500*(foo(reshape(xyz(1,:),n,m)/Xn)-ytemp);
b = 200*(ytemp-foo(reshape(xyz(3,:),n,m)/Zn));
