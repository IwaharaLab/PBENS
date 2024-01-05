% calculate ion accessibility using molecular and cubic coordinates
% Van Der Waals radius assigned by pqr file values
% Binhan Yu
% 01-10-2021
% University of Texas Medical Branch at Galveston
function [ivdw] = calc_ivdw(rProb,gridCoord,allCoord,radius)
tic
rVdw = radius;
% rCutoff = rVdw + rProb;
ivdw = ones(length(gridCoord(:,1)),1);
for jk=1:length(allCoord(:,1))
    distanceCut = sqrt(sum((allCoord(jk,:)-gridCoord).^2,2));
    ivdw(distanceCut < (rVdw(jk) + rProb)) = 0;
end
save('ivdw_calc.txt','ivdw','-ASCII')
toc
end
