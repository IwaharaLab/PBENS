
This directory contains an example of DelPhi calculation for ubiquitin at pH 7.5.

'runDelphi_1ubq_ic24mM.com':
This is a script to run the PDB2PQR and DelPhi programs for '1ubq.pdb'. The PDB2PQR program generates '1ubq.pqr' in a PQR format using AMBER atomic radii and charges at pH 7.5. Using this PQR format file and an input file 'param_1ubq_ic24mM_forPhiENS_2.0', DelPhi will calculate electrostatic potentials. 

'param_1ubq_ic24mM_forPhiENS_2.0':
This is an input file for DelPhi. The grid space is 128 A x 128 A x 128 A with an interval of 0.5 A for each dimension. The input file specifies the ion radius of 2.0 A, the monovalent ion concentration of 24 mM, the exterior dielectric constant of 78.54, the interior dielectric constant of 2.0, and temperature at 25 C. The DelPhi output file of electrostatic potentials is '1ubq_ic24mM_pot_2.0.cube' in the 'cube' format.

The calculations require installation of the following programs:
- DelPhi  (http://compbio.clemson.edu/lab/delphisw/)
- PDB2PQR (https://pdb2pqr.readthedocs.io/en/latest/getting.html)
- python  (a version compatible with PDB2PQR)

If you would like to get our output file '1ubq_ic24mM_pot_2.0.cube', send a request to j.iwahara@utmb.edu.

Junji Iwahara


