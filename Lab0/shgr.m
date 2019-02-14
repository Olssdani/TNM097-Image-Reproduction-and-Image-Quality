function x=shgr(IM)
% SHGR(imagematrix)  Show a gray scale image in the current figure window.
[im,map]=gray2ind(IM);
imshow(im,map);
