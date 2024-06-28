This directory contains MATLAB scripts to calculate phiENS potentials and local average electrostatic potentials from an APBS or DelPhi electrostatic potential file and a PQR file.

====================================================
You do not need to edit any files in this directory.
====================================================

Here information about each file is given just in case you need modifications.

'calcPhiENS.m'
This is the main script. It runs calculations based on the information in an 'input script', which specifies some global varaiables. It can compute PB-based phiENS potentails, local average electrostatic potentials, and ENS radii.

'readPQR.m'
This function reads a PQR format file.

'calcDXgridCoord.m'
This function calculates xyz cooridnates for each grid points. 

'readVolumeData.m'
This function reads a '.dx' or '.cube' file of electrostatic potentials.

'calc_ivdw_pqrR.m'
This function sets the accessibility coefficient (1 for accessible grids; 0 for inaccessible grids) for the 3D space of electrostatic potentials.

'writeDXtrim.m'
This function is used to create DX-format files representing individual ENS zones. This function is used only when 'outputENSzone = 1'.

These scripts were originally coded by Binhan Yu, and minor modifications were made by Junji Iwahara


Junji Iwahara

January 10, 2024

