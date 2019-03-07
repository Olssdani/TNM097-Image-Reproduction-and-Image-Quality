function XYZ_est = Polynomial_regression_SignalDep(RGB,A)
% function XYZ_est = Polynomial_regression(RGB,A)
% Returns the 3xT matrix XYZ_est with estimated XYZ-values for T samples,
% computed from  RGB using a second order mixed polynomial + RGB-term 
% and the weight in the matrix A
% 
% RGB is device data for T samples, in the format 3xT
% A is the 11x3-matrix containing weights for the polynomial regression
%
%--------------------------------------------------------------------------
check = [1 2 3];
R=0;G=0;B=0;I1=0;I2=0;I3=0;

v = [1 R G B R.^2 R*G R*B G.^2 G*B B.^2 R.^3 R.^2*G R.^2*B R*G.^2 R*G*B, R*B.^2 G.^3 G.^2*B G*B.^2 B.^3 I1.^3*I2 I1.^3*I3 I2.^3*I1 I2.^3*I3];   % Second order +RGB-term

RGB_training=RGB';

Pv=zeros(length(RGB_training),length(v));
for r=1:length(RGB_training)
    R=RGB_training(r,1);
    G=RGB_training(r,2);
    B=RGB_training(r,3);
    [I1 index(1,1)] = max(RGB_training(r,:));
    [I3 index(1,2)] = min(RGB_training(r,:));
    logical =~ismember(check,index);
    I2 = sum(logical.*(RGB_training(r,:)));
    Pv(r,:) = [1 R G B R.^2 R*G R*B G.^2 G*B B.^2 R.^3 R.^2*G R.^2*B R*G.^2 R*G*B, R*B.^2 G.^3 G.^2*B G*B.^2 B.^3 I1.^3*I2 I1.^3*I3 I2.^3*I1 I2.^3*I3];

end

XYZ_est = (Pv*A)';