#!/bin/bash

# Poor man's way of setting up permissions for the Lustre share:
# - chown to cycleadmin (needs to use lfs setstrip for this project)
# - also make group writable for new group with gid $GID

set -ex

MOUNTPOINT=/lustre
GID=10000
GROUP=lustre
ADMIN=cycleadmin

# create group if needed
if ! grep -qw $GID /etc/group; then
  groupadd -g $GID $GROUP
  usermod -a -G $GROUP $ADMIN
fi

# set permissions (if FS is mounted)
if mount | grep -q $MOUNTPOINT; then
    chown $ADMIN:$GROUP $MOUNTPOINT
    chmod 775 $MOUNTPOINT
else
    echo "WARNING: $MOUNTPOINT not mounted yet. Not fixing permissions" >&2
fi

# Add the flock option
umount /lustre
sed -i '/lustre/s/defaults/defaults,flock/' /etc/fstab
mount -a

exit 0