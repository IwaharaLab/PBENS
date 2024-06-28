
This directory contains an example of APBS calculation for ubiquitin at pH 7.5.

'runPDB2PQR_APBS_1ubq_ic24mM.com':
This is a script to run the PDB2PQR and APBS programs for '1ubq.pdb'. The PDB2PQR program generates '1ubq.pqr' in a PQR format using AMBER atomic radii and charges at pH 7.5. Using this PQR format file and an input file '1ubq_ic24mM_forPhiENS_2.0.in', APBS will calculate electrostatic potentials.

'1ubq_ic24mM_forPhiENS_2.0.in':
This is an input file for APBS. The grid space is 128 A x 128 A x 128 A with an interval of 0.5 A for each dimension. The input file specifies the ion radius of 2.0 A, the monovalent ion concentration of 24 mM, the exterior dielectric constant of 78.54, the interior dielectric constant of 2.0, and temperature at 25 C. The APBS output file of electrostatic potentials is '1ubq_ic24mM_pot2.0.dx' in the 'DX' format.

The calculations require installation of the following programs:
- APBS    (https://apbs.readthedocs.io/en/latest/index.html)
- PDB2PQR (https://pdb2pqr.readthedocs.io/en/latest/getting.html)
- python  (a version compatible with PDB2PQR)

If PDB2PQR does not work on your computer, you can use the PDB2PQR server: https://server.poissonboltzmann.org/pdb2pqr

Junji Iwahara

