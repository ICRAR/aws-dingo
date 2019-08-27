#!/bin/bash
# Number of MPI tasks
#SBATCH -n 244
#SBATCH --tasks-per-node=25
#SBATCH --nodes=10

module load mpi/openmpi-x86_64

cd /lustre/G12_test
#mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in -l askap.log_cfg
mpirun -np 244 imager -p -c science_spectral_imager_F00_B00_5575077.in

#NCORES=244
#NPPN=25
#srun --export=ALL --no-kill --ntasks=244 --ntasks-per-node=25 imager -p -c science_spectral_imager_F00_B00_5575077.in