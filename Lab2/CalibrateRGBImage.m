function [Cal_Image] = CalibrateRGBImage(Image)
    load TRC_display.mat

    x =0:0.01:1;
    Cal_Image(:,:,1) =interp1(TRCr,x,Image(:,:,1),'pchips'); 
    Cal_Image(:,:,2)=interp1(TRCg,x,Image(:,:,2),'pchips'); 
    Cal_Image(:,:,3) =interp1(TRCb,x,Image(:,:,3),'pchips'); 
end

