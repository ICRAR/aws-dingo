#!/bin/bash
# Number of MPI tasks
#SBATCH -n 433
#
# Number of tasks per node
#SBATCH --tasks-per-node=30

module load openmpi/3.1.4
cd /fsx
mpirun imager -p -c science_spectral_imager_F00_B00_5575077.in