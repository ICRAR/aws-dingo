#!/bin/bash
# Number of MPI tasks
#SBATCH -n 244
#SBATCH --tasks-per-node=30
#SBATCH --nodes=9
#SBATCH --mem=480GB

# r4.16xlarge - 64 cores 488 GB RAM

module load openmpi/3.1.4
cd /dingo/G12_test
#mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in -l askap.log_cfg
mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in
