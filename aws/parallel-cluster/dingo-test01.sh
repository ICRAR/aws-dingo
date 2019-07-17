#!/bin/bash
# Number of MPI tasks
#SBATCH -n 6
#
# Number of tasks per node
#SBATCH --tasks-per-node=2

module load mpi/openmpi3-x86_64

mpirun imager -p -c science_spectral_imager_F00_B00_5575077.in