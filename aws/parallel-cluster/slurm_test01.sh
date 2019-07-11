#!/bin/bash
# Number of MPI tasks
#SBATCH -n 2
#
# Number of tasks per node
#SBATCH --tasks-per-node=2

srun hostname