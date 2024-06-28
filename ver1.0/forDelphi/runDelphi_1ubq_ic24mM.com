#!/bin/csh
#
# Script to run Delphi for 1ubq
#

# Get PQR-format file
pdb2pqr30 --with-ph 7.5 --titration-state-method propka --drop-water --whitespace --ff AMBER 1ubq.pdb 1ubq.pqr 

# This converts '1ubq.prq' into a format compatible with Delphi.
cat 1ubq.pqr | awk '{printf "%4s %5d %-4s  %3s %5d     %7.3f %7.3f %7.3f %7.4f %6.4f\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}' > 1ubq_forDelphi.pqr

# fort.15 for PQR file
cp 1ubq_forDelphi.pqr fort.15

# Run Delphi
# See 'param_1ubq_ic24mM_forPhiENS_2.0' for the parameter settings
#
~/delphi/bin/delphi param_1ubq_ic24mM_forPhiENS_2.0 > delphi_1ubq.out

rm fort.15
