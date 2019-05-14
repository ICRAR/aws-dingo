## sync s3

```bash
aws s3 sync 4191 s3://aws-dingo/4191 --profile=XXX

docker run -d -it --name dingo --mount type=bind,source="$(pwd)",target=/app --mount type=bind,source=/mnt/dingo,target=/mnt/dingo askapsoft-mpi

docker exec -it dingo mpirun --allow-run-as-root -np 1 mssplit -c /app/split_science_F00_B00_4051202.in
```

