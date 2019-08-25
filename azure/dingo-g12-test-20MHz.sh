#!/bin/bash
# Number of MPI tasks
#SBATCH -n 5
#SBATCH --tasks-per-node=25
#SBATCH --nodes=3

module load mpi/openmpi-x86_64

cd /lustre/G12_test_20MHz
#mpirun -np 55 imager -p -c science_spectral_imager_F00_B00_5688023.in -l askap.log_cfg
mpirun -np 55 imager -p -c science_spectral_imager_F00_B00_5688023.in

#NCORES=55
#NPPN=25
#srun --export=ALL --ntasks=${NCORES} --ntasks-per-node=${NPPN} imager -p -c science_spectral_imager_F00_B00_5688023.in