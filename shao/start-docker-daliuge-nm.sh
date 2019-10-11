#! /bin/bash

docker run -d -it --name daliuge --mount type=bind,source=/o9000,target=/o9000 \
    --mount type=bind,source=/home/kvinsen,target=/home/kvinsen \
    -p 8000:8000 -p 5555:5555 -p 6666:666 \
    192.168.6.123:5000/yanda/yanda-daliuge \
    \
    dlg nm -vvv -H 0.0.0.0 --log-dir "/home/kvinsen/daliuge-nm-$(hostname -I | grep -Po '192\.168\.6\.[0-9]+')" \
    --max-request-size 10
