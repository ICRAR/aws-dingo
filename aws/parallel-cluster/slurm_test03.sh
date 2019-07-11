#!/bin/sh
# SLURM directives
#
#SBATCH --job-name=slurm_test
#SBATCH --ntasks-per-node=24
#SBATCH --nodes=1
#SBATCH --array=0-2
#--SBATCH --parsable
#--SBATCH --partition=debugq

srun run-task.sh