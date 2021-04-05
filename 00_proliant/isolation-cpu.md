#### CPU Issolation

For dedicating proc just for host and irq, can be feasible to split cpus core just for workload (guest machine), console and hw stuff.
For this purpose we have to add isoaltion_cpus stanza to the kernel parameters. Next posible tweaking can be settting of vcpu realtime
kernel. 
