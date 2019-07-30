#!/bin/bash
# Number of MPI tasks
#SBATCH -n 244
#SBATCH --tasks-per-node=12
#SBATCH --nodes=21
#SBATCH --mem=242GB

# r4.8xlarge - 32 cores 244GB RAM

module load openmpi/3.1.4
cd /shared/G12_test
#mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in -l askap.log_cfg
mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in
