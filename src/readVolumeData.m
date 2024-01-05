% readVolumeData.m
% Read volume data in OpenDX format and Gaussian cube format
% output:
% dime: grid dimension
% delta: grid spacing
% origin: origin coordinates of the cubic
% volumeOut: volumetric data (elecstatic potential, ion accessibility, etc.)
% Binhan Yu
% University of Texas Medical Branch at Galveston
% 07-24-2020
function [dime,delta,origin,volumeOut] = readVolumeData(fileName,fileFormat)

format = fileFormat;
delimiterIn = ' ';
if strcmp(format,'cube')
    headerlinesIn = 7;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Bohr radius
    coeff = 0.5291772108; % coefficient for Gaussian Cube format
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
if strcmp(format,'dx')
    headerlinesIn = 11;
end

APBS = importdata(fileName,delimiterIn,headerlinesIn);
output = APBS.data';
textdata = APBS.textdata;
output(isnan(output)) = [];
volumeOut = output(:);

%% read coordinate info from Gaussian cube format
if strcmp(format,'cube')
    tmp = textdata{3};
    tmpin = textscan(tmp,'%f%f%f%f%f');
    origin = [tmpin{2}, tmpin{3}, tmpin{4}];
    %
    tmp = textdata{4};
    tmpin = textscan(tmp,'%f%f%f%f%f');
    delta(1,1) = tmpin{2};
    dime(1,1) = tmpin{1};
    %
    tmp = textdata{5};
    tmpin = textscan(tmp,'%f%f%f%f%f');
    delta(1,2) = tmpin{3};
    dime(1,2) = tmpin{1};
    %
    tmp = textdata{6};
    tmpin = textscan(tmp,'%f%f%f%f%f');
    delta(1,3) = tmpin{4};
    dime(1,3) = tmpin{1};
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    delta = delta.*coeff;
    origin = origin.*coeff;
end
%% read coordinate info from OpenDX format
if strcmp(format,'dx')
    tmp = textdata{6};
    tmpin = textscan(tmp,'%s%f%f%f');
    origin = [tmpin{2}, tmpin{3}, tmpin{4}];
    %
    tmp = textdata{5};
    tmpin = textscan(tmp,'%s%f%s%s%s%f%f%f');
    dime = [tmpin{6}, tmpin{7}, tmpin{8}];
    %
    tmp = textdata{7};
    tmpin = textscan(tmp,'%s%f%f%f');
    delta(1,1) = tmpin{2};
    %
    tmp = textdata{8};
    tmpin = textscan(tmp,'%s%f%f%f');
    delta(1,2) = tmpin{3};
    %
    tmp = textdata{9};
    tmpin = textscan(tmp,'%s%f%f%f');
    delta(1,3) = tmpin{4};
end
end

