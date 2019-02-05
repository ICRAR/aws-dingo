#!/bin/bash -vx
#
# ##    ##  #######  ######## ########
# ###   ## ##     ##    ##    ##
# ####  ## ##     ##    ##    ##
# ## ## ## ##     ##    ##    ######
# ##  #### ##     ##    ##    ##
# ##   ### ##     ##    ##    ##
# ##    ##  #######     ##    ########
#
#
apt -y update
apt -y upgrade

# Print into the logs the disk free
df -h

build_raid () {
  drive_count=$1
  shift
  drives=$@
  echo "Drive count = $drive_count"
  echo "Drives = $drives"

  # Overwrite first few blocks in case there is a filesystem, otherwise mdadm will prompt for input
  for drive in ${drives}; do
    dd if=/dev/zero of=${drive} bs=4096 count=1024
  done

  if (( $drive_count > 1 )); then
    mdadm --create --verbose /dev/md0 --level=0 -c256 --raid-devices=${drive_count} ${drives}
    blockdev --setra 65536 /dev/md0
    pvcreate /dev/md0
    vgcreate dingo-group /dev/md0
  else
    pvcreate ${drives}
    vgcreate dingo-group ${drives}
  fi
  lvcreate -L 20G --name swap dingo-group
  lvcreate --extents 100%FREE --name data dingo-group

  mkfs.xfs -K /dev/dingo-group/data
  mkdir -p /mnt/dingo
  mount /dev/dingo-group/data /mnt/dingo

  mkswap /dev/dingo-group/swap
  swapon /dev/dingo-group/swap
}

if [[ -b "/dev/nvme0n1" ]]; then
  # figure out how many NVMe we have
  drives="/dev/nvme0n1"
  drive_count=1
  for e in 1 2 3 4 5 6 7; do
      device_path="/dev/nvme"${e}"n1"
      echo "Probing $device_path .."
    # test that the device actually exists
    if [[ -b ${device_path} ]]; then
      echo "Detected NVMe disk: $device_path"
      drives="$drives $device_path"
      drive_count=$((drive_count + 1 ))
    else
      echo "NVMe disk $e, $device_path is not present. skipping"
    fi
  done

  build_raid ${drive_count} ${drives}

elif [[ -b "/dev/xvdb" ]]; then
  METADATA_URL_BASE="http://169.254.169.254/latest"

  # Configure Raid if needed - taking into account xvdb or sdb
  root_drive=`df -h | grep -v grep | awk 'NR==2{print $1}'`

  echo "Detected 'xvd' drive naming scheme (root: $root_drive)"
  DRIVE_SCHEME='xvd'

  # figure out how many ephemerals we have by querying the metadata API, and then:
  #  - convert the drive name returned from the API to the hosts DRIVE_SCHEME, if necessary
  #  - verify a matching device is available in /dev/
  drives=""
  ephemeral_count=0
  ephemerals=$(curl --silent ${METADATA_URL_BASE}/meta-data/block-device-mapping/ | grep ephemeral)
  for e in ${ephemerals}; do
    echo "Probing $e .."
    device_name=$(curl --silent ${METADATA_URL_BASE}/meta-data/block-device-mapping/${e})

    # might have to convert 'sdb' -> 'xvdb'
    device_name=$(echo ${device_name} | sed "s/sd/$DRIVE_SCHEME/")
    device_path="/dev/$device_name"

    # test that the device actually exists since you can request more ephemeral drives than are available
    # for an instance type and the meta-data API will happily tell you it exists when it really does not.
    if [[ -b ${device_path} ]]; then
      echo "Detected ephemeral disk: $device_path"
      drives="$drives $device_path"
      ephemeral_count=$((ephemeral_count + 1 ))
    else
      echo "Ephemeral disk $e, $device_path is not present. skipping"
    fi
  done

  echo "ephemeral_count = $ephemeral_count"
  if (( ephemeral_count >= 1 )); then
    if mountpoint -q "/media/ephemeral0" ; then
      umount /media/ephemeral0
    fi

    build_raid ${ephemeral_count} ${drives}

  else
    mkdir -p /mnt/dingo
    mkfs.xfs -K /dev/xvdb

    mount /dev/xvdb /mnt/dingo
    dd if=/dev/zero of=/mnt/swapfile bs=1M count=1024
    mkswap /mnt/swapfile
    swapon /mnt/swapfile
    chmod 0600 /mnt/swapfile
  fi
fi
# Print free disk space
df -h

# More file handles
ulimit -n 20480

# Create the dingo root
mkdir -p /mnt/dingo
chmod -R 0777 /mnt/dingo

cd /home/ubuntu
