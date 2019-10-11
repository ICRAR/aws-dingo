#! /bin/bash

docker run -d -it --name daliuge --mount type=bind,source=/o9000,target=/o9000 \
    --mount type=bind,source=/home/kvinsen,target=/home/kvinsen \
    --expose 202.127.24.189:8001:8001 \
    192.168.6.123:5000/yanda/yanda-daliuge \
    dlg dim -vvv -H 0.0.0.0 --ssh-pkey-path /home/kvinsen/.ssh/id_daliuge \
    --nodes 192.168.6.35,192.168.6.36,192.168.6.37,192.168.6.38,192.168.6.39,192.168.6.40,192.168.6.41,192.168.6.42 \
    --log-dir "/home/kvinsen/daliuge-dim-$(hostname -I | grep -Po '192\.168\.6\.[0-9]+')" --max-request-size 10
