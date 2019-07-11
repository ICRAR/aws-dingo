#!/bin/bash
# Number of MPI tasks
#SBATCH -n 4
#
# Number of tasks per node
#SBATCH --tasks-per-node=2

module load mpi/openmpi-x86_64

srun hello.mpi