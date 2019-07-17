#!/bin/bash
# Number of MPI tasks
#SBATCH -n 4
#
# Number of tasks per node
#SBATCH --tasks-per-node=2

module load openmpi/3.1.4

mpirun hello.mpi