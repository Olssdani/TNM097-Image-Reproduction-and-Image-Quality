function [x,y,z] = rgb2xyz(r,g,b)

[n,m] = size(r);

Q = [41.2453 35.7580 18.0423; 21.2671 71.5160 7.2169; 1.9334 11.9193 95.0227];


xyz=Q*[r(:)';g(:)';b(:)'];
x=reshape(xyz(1,:),n,m);
y=reshape(xyz(2,:),n,m);
z=reshape(xyz(3,:),n,m);

