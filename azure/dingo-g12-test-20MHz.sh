#!/bin/bash
# Number of MPI tasks
#SBATCH -n 244
#SBATCH --tasks-per-node=25
#SBATCH --nodes=10

cd /lustre/G12_test_20MHz
#mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in -l askap.log_cfg
mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5688023.in

#NCORES=244
#NPPN=20
#srun --export=ALL --ntasks=${NCORES} --ntasks-per-node=${NPPN} imager -p -c science_spectral_imager_F00_B00_5688023.in