% calculate ion accessibility using molecular and cubic coordinates
% Van Der Waals radius assigned according to atom type
% Binhan Yu
% 01-26-2021
% University of Texas Medical Branch at Galveston
function [ivdw] = calc_ivdw_pqrR(rProb,gridCoord,allCoord,radius)
tic
rVdw = radius;
ivdw = ones(length(gridCoord(:,1)),1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
coordCutoffUp = max(allCoord) + (max(rVdw)+ rProb);
coordCutoffLo = min(allCoord) - (max(rVdw)+ rProb); % grid points outside of the protein
% upper bound
idxupx=gridCoord(:,1)>coordCutoffUp(1);
idxupy=gridCoord(:,2)>coordCutoffUp(2);
idxupz=gridCoord(:,3)>coordCutoffUp(3);
% lower bound
idxlox=gridCoord(:,1)<coordCutoffLo(1);
idxloy=gridCoord(:,2)<coordCutoffLo(2);
idxloz=gridCoord(:,3)<coordCutoffLo(3);
% outside of the smallest cubic that contains the protein
idxoutside = idxupx + idxupy +idxupz +idxlox +idxloy +idxloz;
ivdw_c = ivdw(idxoutside==0);
gridCoord_c = gridCoord(idxoutside==0,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for jk=1:length(allCoord(:,1))
    if jk ==1
        distanceCut = sqrt(sum((allCoord(jk,:)-gridCoord_c).^2,2));
        ivdw_c(distanceCut < (rVdw(jk) + rProb)) = 0;
    else
        distanceCut = sqrt(sum((allCoord(jk,:)-gridCoord_c(ivdw_c==1,:)).^2,2));
        idx_c = find(ivdw_c==1);
        ivdw_tmp = ivdw_c(idx_c);
        ivdw_tmp(distanceCut < (rVdw(jk) + rProb)) = 0;
        ivdw_c(idx_c) = ivdw_tmp;
    end
end
ivdw(idxoutside==0) = ivdw_c;
%save('ivdw_pqrR.txt','ivdw','-ASCII')
toc
end
