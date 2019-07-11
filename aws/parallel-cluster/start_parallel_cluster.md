# Start cluster

The min-config.ini is symbolically linked to ~/.pcluster/config

### Start
```
pcluster create NAME
```

### Connect
```
pcluster ssh NAME -i KEY
```

### Delete 
```
pcluster delete NAME
``` 


# Running Jobs

```
sbatch --partition=compute test2.sh
```

## Restore S3 to FSx

```
nohup find . -type f -print0 | xargs -0 -n 1 sudo lfs hsm_restore &

sudo lfs hsm_restore filename
```

## Exporting Fsx to S3

```
nohup find local/directory -type f -print0 | xargs -0 -n 1 sudo lfs hsm_archive &


sudo lfs hsm_archive filename
```


# SRUN

```
parset="/group/askap/jrhee/G23_1_32MHz/parsets/G23_T1-0A/science_spectral_imager_F00_B00_${SLURM_JOB_ID}.in"
log="/group/askap/jrhee/G23_1_32MHz/logs/G23_T1-0A/science_spectral_imager_F00_B00_${SLURM_JOB_ID}.log"
NCORES=433
NPPN=20
srun --export=ALL --ntasks=${NCORES} --ntasks-per-node=${NPPN} imager -p -c "$parset" > "$log”
```

