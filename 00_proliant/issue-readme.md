[root@dl380 libvirt]# virsh start freeipa.lab.local 
error: Failed to start domain freeipa.lab.local
error: Cannot set scheduler parameters for pid 5861: Operation not permitted

[root@dl380 libvirt]# sysctl -a | grep kernel.sched_rt_runtime_us
kernel.sched_rt_runtime_us = 950000
[root@dl380 libvirt]# sysctl -q kernel.sched_rt_runtime_us=-1
[root@dl380 libvirt]# sysctl -a | grep kernel.sched_rt_runtime_us
kernel.sched_rt_runtime_us = -1
[root@dl380 libvirt]# virsh start freeipa.lab.local 
Domain freeipa.lab.local started

[root@dl380 libvirt]# sysctl -a | grep kernel.sched_rt_runtime_us^C
[root@dl380 libvirt]# htop 
[root@dl380 libvirt]# systemctl status tuned
● tuned.service - Dynamic System Tuning Daemon
   Loaded: loaded (/usr/lib/systemd/system/tuned.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2021-04-01 13:34:56 CEST; 1h 4min ago
     Docs: man:tuned(8)
           man:tuned.conf(5)
           man:tuned-adm(8)
 Main PID: 1745 (tuned)
    Tasks: 4 (limit: 822932)
   Memory: 19.8M
   CGroup: /system.slice/tuned.service
           └─1745 /usr/libexec/platform-python -Es /usr/sbin/tuned -l -P

Apr 01 13:34:55 dl380 systemd[1]: Starting Dynamic System Tuning Daemon...
Apr 01 13:34:56 dl380 systemd[1]: Started Dynamic System Tuning Daemon.
[root@dl380 libvirt]# systemctl stop tuned
[root@dl380 libvirt]# systemctl disable tuned
Removed /etc/systemd/system/multi-user.target.wants/tuned.service.

