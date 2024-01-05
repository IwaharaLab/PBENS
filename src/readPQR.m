function [ rens rets atms coords chargs rads ] = readPQR( fname )
% Function to read PQR files 
% fname :   File name
% rens:     Array of residue numbers
% atms:     Array of atom names
% coords:   Array of [x,y,z] coordinates
% chargs:   Array of charges
% rads:     Array of radii
%  

fid = fopen(fname);
fprintf(' Reading PQR file: %s\n', fname);
theLines = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
theLines = theLines{1};
nl=numel(theLines);
nhdr=0;
for j = 1:nl
    C = theLines{j};
    if (strncmp(C,'REMARK',6))
        nhdr = nhdr + 1;
        continue;
    end
    break
end
fprintf(' Skipping %d header lines\n', nhdr);
rens=[]; rets=[]; atms=[]; coords=[]; chargs=[]; rads=[];
for n = (nhdr+1):nl
    C = theLines{n};
    dc = textscan(C,'%s %d %s %5c %d %f %f %f %f %f');
    atm = dc{3}; ret = dc{4}; ren = dc{5};
    coord = [dc{6} dc{7} dc{8}]; charg = dc{9}; rad = dc{10};
    rens = [rens; ren];
    rets = [rets; convertCharsToStrings(ret(1:3))];
    atms = [atms; atm];
    coords = [coords; coord];
    chargs = [chargs; charg];
    rads   = [rads; rad];
end
end

