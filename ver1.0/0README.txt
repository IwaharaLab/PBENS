%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PBENS
MATLAB scripts to calculate effective near-surface electrostatic potentials (phi_ENS)
using an APBS or DelPhi output.

By Binhan Yu and Junji Iwahara
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

'src_PBENS': 
The directory of the MALTAB functions for the calculations

'forAPBS':
A directory for the APBS calculation on '1ubq.pdb' as an example.

'forDelphi':
A directory for the DelPhi calculation on '1ubq.pdb' as an exaple.

'inputPBENS_1ubq_ic24mM_Apbs.m':
An input file for PBENS to calculate phi_ENS potentials from the APBS output and the PQR format file of '1ubq.pdb'.

'inputPBENS_1ubq_ic24mM_Delphi.m':
An input file for PBENS to calculate phi_ENS potentials from the DelPhi output and the PQR format file of '1ubq.pdb'.

'outputData':
A directory used for output files from PBENS. 

%%%%%%%%%%%%%%%%%%
If you use APBS
%%%%%%%%%%%%%%%%%%
1. Go to the directory 'ver1.0/forAPBS'
2. Edit 'runPDB2PQR_APBS_1ubq_ic24mM.com' and give appropriate paths for 'pdb2pqr30' and 'apbs' programs on your computer.
3. Run 'sh runPDB2PQR_APBS_1ubq_ic24mM.com'.
4. Go to the directory 'ver1.0'.
5. Run the MATLAB script 'inputPBENS_1ubq_ic24mM_Apbs.m'.
6. Check the output files in the 'outputData' directory

%%%%%%%%%%%%%%%%%%
If you use Delphi
%%%%%%%%%%%%%%%%%%
1. Go to the directory 'ver1.0/forDelphi'
2. Edit 'runDelphi_1ubq_ic24mM.com' and give appropriate paths for 'pdb2pqr30' and 'delphi' programs on your computer.
3. Run 'sh runDelphi_1ubq_ic24mM.com'.
4. Go to the directory 'ver1.0'.
5. Run the MATLAB script 'inputPBENS_1ubq_ic24mM_Delphi.m'.
6. Check the output files in the 'outputData' directory

This GitHub package does not contain any output files. If you would like to get our output files, send a request to j.iwahara@utmb.edu.
