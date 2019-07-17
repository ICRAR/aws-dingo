#!/bin/sh
# SLURM directives
#
#SBATCH --job-name=slurm_test
#SBATCH --ntasks-per-node=24
#SBATCH --nodes=1
#--SBATCH --parsable

module load openmpi/3.1.4

srun run-task.sh