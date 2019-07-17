#!/bin/sh
# SLURM directives
#
#SBATCH --job-name=slurm_test
#SBATCH --ntasks-per-node=24
#SBATCH --nodes=1
#--SBATCH --parsable

srun run-task.sh