function [x,y,z]=lab2xyz(L,a,b)

Xn = 95.05;
Yn = 100.00;
Zn = 108.89;

y=Yn*((L<8).*L/903.3+(L>=8).*((L+16)/116).^3);
ytemp=foo(y/Yn);
x=Xn*(a/500+ytemp).^3;
z=Zn*(ytemp-b/200).^3;
