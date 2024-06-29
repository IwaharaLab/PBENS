%
% Input for PBENS scripts to calculate effective near-surface (ENS) electrostatic potentials
% from grid electrostatic potentials and atomic coordinates
%
% Programed by Binhan Yu and Junji Iwahara
%

clear; clc; close all
path(path,'./src_PBENS/');
global fileFormat espFile calcIvdw ivdwFile outputENSzones calcPotAv
global radiiENSfile percentENS Htype rProbe zp1 zp2 phiUnits
global pqrFile phiENSfile barPhiFile Te

%% ESP files
% File format of electrostatic potentials
% APBS DX format: 'dx'
% DelPhi Gaussian cube format: 'cube'
fileFormat = 'dx';

% Electrostatic potentials file
espFile = 'forAPBS/1ubq_ic24mM_pot2.0.dx';

%% PQR file and atom specification
pqrFile = 'forAPBS/1ubq.pqr';

% Atom name for ENS calculation
% This has be specified with double quotation marks
Htype = "H";

%% Probe properties
% Radius for PROXYL derivatives: 3.5 Å is empirically optimal
rProbe = 3.5;

% Charge valence of Probe 1
zp1 =+1;

% Charge valence of Probe 2
zp2 = -1;

%% Output files
% Output of PhiENS data
phiENSfile = 'outputData/phiENS_1ubq_ic24mM_apbs.txt';

% Option for output files of ENS zones in DX format
% ON:  outputENSzones = 1;
% OFF: outputENSzones = 0;
outputENSzones = 0;

% Option for an output of average Phi within the ENS zone
% calcPotAv = 1: Calculate average Phi as well (quite time-consuming)
% calcPotAv = 0: Calculate phiENS only
calcPotAv = 1;
% Output of average Phi within the ENS zone
barPhiFile = 'outputData/barPhiENS_1ubq_ic24mM_apbs.txt';

% Threshold for ENS zone (ENS zone contribution to sum of r^(-6))
% This requires only when calcPotAv = 1
percentENS = 0.68;  

% ENS radii file
% This output file contains the ENS radii.
% Providing this will accelerate calculations of average Phi within ENS
% next time.
radiiENSfile = 'outputData/effRcut068_1ubq_HN2.txt';

% Paramangetic center accessibility 
% calcIvdw = 1; Evaluate grid accessibility coefficient using PQR radii and rProbe.
% calcIvdw = 0; Use APBS ivdw with an appropriate a probe radius
calcIvdw = 1;

% IVDW file for accessibility of paramagnetic center
% Required only when calcIvdw = 0
% ivdwFile = 'forAPBS/3cqt_mutate2_ic40mM_ivdw3.5.dx';

% Units in electrostatic potentials
% Use phiUnits = 'mV' for mV units; otherwise, values are in kBT/e units.
phiUnits = 'mV';

% Temperature in K
% Required only when phiUnits 'mV' is used.
Te = 298.15;

%% Main function
calcPhiENS
