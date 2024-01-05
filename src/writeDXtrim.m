function [ivdw_res] = writeDXtrim(delta, pot, idxPot,jk,gridCoord,Coord,trimR)
if exist('./volumeOutput','dir') == 0
    mkdir volumeOutput
end
formatSpec = '%12.6e %12.6e %12.6e\n';
center = Coord(jk,:);
bx_max = center(1) + trimR*0.5; % trimR: length of the trimed box
bx_min = center(1) - trimR*0.5;
by_max = center(2) + trimR*0.5;
by_min = center(2) - trimR*0.5;
bz_max = center(3) + trimR*0.5;
bz_min = center(3) - trimR*0.5;
idx_xx1 = gridCoord(:,1) > bx_max;
idx_xx2 = gridCoord(:,1) < bx_min;
idx_xx = idx_xx1 + idx_xx2 == 1;
idx_yy1 = gridCoord(:,2) > by_max;
idx_yy2 = gridCoord(:,2) < by_min;
idx_yy = idx_yy1 + idx_yy2 == 1;
idx_zz1 = gridCoord(:,3) > bz_max;
idx_zz2 = gridCoord(:,3) < bz_min;
idx_zz = idx_zz1 + idx_zz2 == 1;
idx_trim = find(idx_xx + idx_yy + idx_zz > 0);
ivdw_res = zeros(size(pot));
ivdw_res(idxPot) = ivdw(idxPot);
ivdw_res(idx_trim) = [];
xx_out = gridCoord(:,1);
yy_out = gridCoord(:,2);
zz_out = gridCoord(:,3);
xx_out(idx_trim) = [];
yy_out(idx_trim) = [];
zz_out(idx_trim) = [];
origin_out = [min(xx_out), min(yy_out), min(zz_out)];
dime_out = [(max(xx_out)-min(xx_out))/delta(1)+1, ...
    (max(yy_out)-min(yy_out))/delta(2)+1, ...
    (max(zz_out)-min(zz_out))/delta(3)+1];

fid = fopen(['./volumeOutput/ivdwTrim_res_',num2str(resNumFullNH(jk)),'.dx'],'w');
fprintf(fid,'# Data from Binhan Yu\n');
fprintf(fid,'# Near surface zone for each residue\n');
fprintf(fid,'# Trimed to length "trimR"\n');
fprintf(fid,'object 1 class gridpositions counts %i %i %i \n',dime_out);
fprintf(fid,'origin %12.6e %12.6e %12.6e\n',origin_out);
fprintf(fid,'delta %12.6e %12.6e %12.6e\n',delta(1),0,0);
fprintf(fid,'delta %12.6e %12.6e %12.6e\n',0,delta(2),0);
fprintf(fid,'delta %12.6e %12.6e %12.6e\n',0,0,delta(3));
fprintf(fid,'2 class gridconnections counts %i %i %i\n',dime_out);
fprintf(fid,'object 3 class array type double rank 0 items %i data follows\n',length(ivdw_res));
fprintf(fid,formatSpec,ivdw_res);
%% close all files
fclose('all');
end