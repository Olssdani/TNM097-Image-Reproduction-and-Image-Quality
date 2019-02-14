function [XYZ] = colorsignal2xyz(reflectance, illumination)
    load xyz.mat

    k = 100/sum(illumination.*xyz(:,2));


    X = k*sum(reflectance.*illumination.*xyz(:,1));
    Y = k*sum(reflectance.*illumination.*xyz(:,2));
    Z = k*sum(reflectance.*illumination.*xyz(:,3));

    XYZ(1,1) = X;
    XYZ(1,2) = Y;
    XYZ(1,3) = Z;
end

