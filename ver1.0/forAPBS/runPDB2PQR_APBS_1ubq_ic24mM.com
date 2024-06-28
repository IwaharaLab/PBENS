#!/bin/csh
#
# APBS calculations for 1ubq.pdb
#
# pdb2pqr30 was installed through:
# > pip install pdb2pqr
#

# Get PQR-format file
pdb2pqr30 --with-ph 7.5 --titration-state-method propka --drop-water --whitespace --ff AMBER 1ubq.pdb 1ubq.pqr 

#Get electrostatic potentials with ionic radius of 2.0 A
~/apbs/bin/apbs 1ubq_ic24mM_forPhiENS_2.0.in > 1ubq_ic24mM_forPhiENS_2.0.out

