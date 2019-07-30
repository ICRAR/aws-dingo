#!/bin/bash
# Number of MPI tasks
#SBATCH -n 244
#SBATCH --tasks-per-node=30
#SBATCH --mem=70GB

# c5.9xlarge - 36 cores 72 GB RAM

module load openmpi/3.1.4
cd /shared/G12_test
#mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in -l askap.log_cfg
mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in
