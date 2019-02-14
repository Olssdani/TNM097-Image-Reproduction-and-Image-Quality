function [Value_mean,Value_max] = xyz2labdiff(cal,ref)
    %cal = cal';

    for i = 1:size(cal,1)
       %Calibrated
       [lc,ac,bc] = xyz2lab(cal(i,1),cal(i,2),cal(i,3));
 
       %Ref
       [lr,ar,br] = xyz2lab(ref(i,1),ref(i,2),ref(i,3));
       %dif
       diff(i,1) = sqrt((lc-lr)^2+(ac-ar)^2+(bc-br)^2);
        
    end
    diff
    Value_mean =mean(diff);
    Value_max =max(diff);
end

