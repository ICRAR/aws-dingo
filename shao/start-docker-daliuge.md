# Start Docker Daliuge

## Node Manager

```
docker run -d -it --name daliuge --mount type=bind,source=/o9000,target=/o9000 \
    --mount type=bind,source=/home/kvinsen,target=/home/kvinsen \
    -p 8000:8000 -p 5555:5555 -p 6666:666 \
    192.168.6.123:5000/yanda/yanda-daliuge \
    \
    dlg nm -vvv -H 0.0.0.0 --log-dir "/home/kvinsen/daliuge-nm-$(hostname -I | grep -Po '192\.168\.6\.[0-9]+')" \
    --max-request-size 10
```

# Data Island Manager

```
docker run -d -it --name daliuge --mount type=bind,source=/o9000,target=/o9000 \
    --mount type=bind,source=/home/kvinsen,target=/home/kvinsen \
    -p 8001:8001 -p 5555:5555 -p 6666:6666 \
    192.168.6.123:5000/yanda/yanda-daliuge \
    \
    dlg dim -vvv -H 0.0.0.0 --ssh-pkey-path /home/kvinsen/.ssh/id_daliuge \
    --nodes 192.168.6.35,192.168.6.36,192.168.6.37,192.168.6.38,192.168.6.39,192.168.6.40,192.168.6.41,192.168.6.42 \
    --log-dir "/home/kvinsen/daliuge-dim-$(hostname -I | grep -Po '192\.168\.6\.[0-9]+')" --max-request-size 10
```