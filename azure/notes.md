# BLOG

Andreas Wilm's blog is here
```
https://andreas-wilm.github.io/2019-07-05-slurm-cluster-with-lustre/
```

# Lustre
```
git clone https://github.com/hmeiland/cyclecloud-lustre.git
cd cyclecloud-lustre
cyclecloud locker list

cyclecloud show_cluster

cyclecloud add_node <cluster-name> -c 1

cyclecloud terminate_node <cluster-name> <node-name> | <filter-expression> 
```
# Slurm cluster
```
git clone https://github.com/andreas-wilm/cyclecloud-dingo-compute
cd cyclecloud-dingo-compute
cyclecloud locker list
```

If ```cyclecloud import_template -f templates/dingo-compute.txt``` fails then use
```cyclecloud import_template -f templates/dingo-compute.txt --force```

# Log Files

Log files are written to ```/opt/cycle/jetpack/logs/cluster-init/dingo-compute/default/scripts```


# Tar Ball

```
tar -xvzf azure-yandasoft.tar.gz /shared/bin /shared/include /shared/lib /shared/man /shared/share
```