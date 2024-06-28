%
% Calculation of phiENS values from electrostatic potentials and PQR file
%
% Input file required

global pqrFile
global fileFormat espFile calcIvdw ivdwFile outputENSzones calcPotAv
global radiiENSfile percentENS Htype rProbe zp1 zp2
global phiENSfile barPhiFile phiUnits Te
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Require functions:            %
% readPQR.m                     %
% readVolumeData.m              %
% calcDXgridCoord.m             %
% calc_ivdw_pqrR.m              %
% writeDXtrim.m                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Boltzmann Constant in m2 kg s-2 K-1
kB = 1.38064852*10^(-23);
% Elementary charge in C
ec = 1.602176634*10^(-19);
% Read PQR file
[ rens rets atms coords chargs rads ] = readPQR(pqrFile);
fprintf(' Loaded information of %d atoms\n\n',length(rens));
resNumFull = unique(rens);
resNumFullNH = rens(atms == Htype);
ubCoord = coords(atms == Htype,:);
ubAllCoord = coords;
allCoord = ubAllCoord;
Hcoord = ubCoord;

% Read ESP file
fprintf(' Reading the ESP file: %s\n',espFile);
[dime,delta,origin,pot] = readVolumeData(espFile,fileFormat);
fprintf(' Loaded information of potentials at %d grid points\n\n',length(pot));
if calcIvdw == 0
    [~,~,~,ivdw] = readVolumeData(ivdwFile,fileFormat);
    if strcmp(fileFormat,'cube')
        ivdw(ivdw<20) = 0;
        ivdw(ivdw>20) = 1;
    end
end
% build grid coordinates in openDX format
[gridCoord] = calcDXgridCoord(dime,delta,origin);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if calcIvdw ==1
    [ivdw] = calc_ivdw_pqrR(rProbe,gridCoord,allCoord,rads);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist(radiiENSfile,'file')==2
    effRcut =  load(radiiENSfile);
    trig = 1;
else
    trig = 0;
end
%% Calculations of effective near-surface (ENS) potentials: PhiENS
% Set scaling factor for units;
if (strcmp(phiUnits,'mV'))
    mV = 1000.0*kB*Te/ec;
    fprintf(' Effective near-surface (ENS) potentials being calculated in mV units\n');
else
    mV = 1.0;
    fprintf(' Effective near-surface (ENS) potentials being calculated in kBT/e units\n');
end
for jk=1:length(Hcoord(:,1))
    rhgs = sqrt(sum((Hcoord(jk,:)-gridCoord).^2,2));
    % Average phi within the ENS zone (threshold defined by percentENS)
    if calcPotAv ==1
        if trig == 0
            Va = sum(ivdw .* rhgs.^-6);
            r = 0.1:0.5:55.1;
            for ij = 1:length(r)
                Vr(ij) = sum(ivdw(rhgs<r(ij)).*rhgs(rhgs<r(ij)).^-6);
            end
            effR(jk,:) = Vr./Va;
            effRcut(jk) = r(min(find(effR(jk,:) > percentENS)));
            
            if jk==length(Hcoord(:,1))
                save(radiiENSfile,'effRcut','-ASCII')
            end
        end
        idxPot = intersect(find(rhgs<effRcut(jk)==1),find(ivdw==1));
        potAv(jk) = mV*mean(pot(idxPot));
    end
    % PhiENS (see Eqs. 3 and 4 in Yu, B. et al. [2021])
    G2ovG2 = sum(ivdw.*exp(-ivdw.*zp1.*pot).*rhgs.^-6)./sum(ivdw.*exp(-ivdw.*zp2.*pot).*rhgs.^-6);
    % ivdw inside exp stabilize the calculation
    phiENSs(jk) = -mV/(zp1-zp2)*log(G2ovG2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % output effective space for sPRE in DX format for visualization
    if outputENSzones == 1
        [ivdw_res] = writeDXtrim(delta, pot, idxPot, jk, gridCoord, Coord, trimR);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
fo1 = fopen(phiENSfile,'w');
for j=1:length(resNumFullNH)
    fprintf(fo1,'%d %7.4f\n', resNumFullNH(j),phiENSs(j));
end
fclose(fo1);
if calcPotAv == 1
    fo2 = fopen(barPhiFile,'w');
    for j=1:length(resNumFullNH)
        fprintf(fo2,'%d %7.4f\n', resNumFullNH(j),potAv(j));
    end
    fclose(fo2);
end
toc
