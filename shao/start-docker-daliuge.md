# Start Docker Daliuge

```
docker run -d -it --name daliuge --mount type=bind,source=/o9000,target=/o9000 --mount type=bind,source=/beegfs,target=/beegfs 192.168.6.123:5000/yanda/yanda-daliuge \
   dlg nm --daemon -${log_level} --dlg-path=/home/ec2-user/aws-chiles02/pipeline -H 0.0.0.0 --log-dir /mnt/daliuge/dlg_root --error-listener=aws_chiles02.error_handling.ErrorListener --max-request-size ${max_request_size}'
```