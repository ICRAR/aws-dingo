#!/bin/bash
# Number of MPI tasks
#SBATCH -n 244
#
# Number of tasks per node
#SBATCH --tasks-per-node=30

# c5.18xlarge - 72 cores 144 GB RAM

module load openmpi/3.1.4
cd /fsx/G12_test
#mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in -l askap.log_cfg
mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in
