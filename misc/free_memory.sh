#!/bin/bash
sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
sudo sysctl -w vm.drop_caches=3
watch -n 1 free -m