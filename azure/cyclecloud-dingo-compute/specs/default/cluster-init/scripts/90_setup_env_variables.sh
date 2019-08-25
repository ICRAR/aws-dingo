#!/bin/bash

set -ex

# Add the new paths
echo "PATH=/usr/local/bin:/usr/bin:/shared/bin" >> /etc/environment
echo "LD_LIBRARY_PATH=/shared/lib" >> /etc/environment

# creates the necessary links and cache to the most recent shared libraries
echo "/shared/lib" >> /etc/ld.so.conf.d/yandasoft.conf
ldconfig

# Create the casacore file to point to the measures
echo "measures.DE200.directory: /shared/share/casacore/data/ephemerides" >> /shared/home/cycleadmin/.casarc
echo "measures.DE405.directory: /shared/share/casacore/data/ephemerides" >> /shared/home/cycleadmin/.casarc
echo "measures.line.directory: /shared/share/casacore/data/ephemerides" >> /shared/home/cycleadmin/.casarc
echo "measures.sources.directory: /shared/share/casacore/data/ephemerides" >> /shared/home/cycleadmin/.casarc
echo "measures.comet.directory: /shared/share/casacore/data/ephemerides" >> /shared/home/cycleadmin/.casarc
echo "measures.ierseop97.directory: /shared/share/casacore/data/geodetic" >> /shared/home/cycleadmin/.casarc
echo "measures.ierspredict.directory: /shared/share/casacore/data/geodetic" >> /shared/home/cycleadmin/.casarc
echo "measures.tai_utc.directory: /shared/share/casacore/data/geodetic" >> /shared/home/cycleadmin/.casarc
echo "measures.igrf.directory: /shared/share/casacore/data/geodetic" >> /shared/home/cycleadmin/.casarc
echo "measures.observatory.directory: /shared/share/casacore/data/geodetic" >> /shared/home/cycleadmin/.casarc

chown cycleadmin:cycleadmin /shared/home/cycleadmin/.casarc

exit 0