#! /bin/bash

docker run -d -it --name daliuge --mount type=bind,source=/o9000,target=/o9000 --mount type=bind,source=/beegfs,target=/beegfs \
   --mount type=bind,source=/home/kvinsen,target=/home/kvinsen 192.168.6.123:5000/yanda/yanda-daliuge \
   dlg nm --daemon -vvv -H 0.0.0.0 --log-dir /home/kvinsen/daliuge --max-request-size 10
